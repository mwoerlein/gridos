#include "I386/I386InterruptVectorTable.hpp"

#include "sys/String.hpp"
#include "memory/MemoryIStream.hpp"
#include "memory/MemoryOStream.hpp"
#include "I386ASM/Parser.hpp"
#include "I386ASM/ParseErrorStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Number.hpp"

void trampoline(I386InterruptVectorTable *table, int32_t nr) {
    table->ITable[nr]->call(nr);
}

MemoryInfo & I386InterruptVectorTable::generateIdt() {
    String input = env().create<String>();
    input << R"(.code32
idt_activate:
    .byte 0x0f; .byte 0x01; .byte 0x1d #// lidtl idt_global_48
    .long idt
    ret
    
idt:
    .word ((idt_end - idt_start) - 1)
    .long idt_start
idt_start:
)";
    for (int i = 0; i < TABLESIZE; i++) {
        input << ".word idt_entry_"<<i<<"; .word 0x0008; .word 0x8e00; .word (idt_entry_"<<i<<" >> 16)\n";
    }
    input << "idt_end:\n";
    for (int i = 0; i < TABLESIZE; i++) {
        input << "idt_entry_"<<i<<": pushl %eax; pushl "<<i<<"; jmp idt_common\n";
    }
    input << R"(
idt_common:
    pushl table_ref
    movl trampoline, %eax
    call %eax
    addl 8, %esp
    popl %eax
    .byte 0xCF  #// iret
)";
    // TODO: generate InstructionList directly?
    IStream &in = input.toIStream();
    Parser &parser = env().create<Parser>();
    ASMInstructionList &list = parser.parse(in, env().err());
    list.addDefinition(
        env().create<String, const char*>("trampoline"),
        env().create<Number, int>((int) trampoline)
    );
    list.addDefinition(
        env().create<String, const char*>("table_ref"),
        env().create<Number, int>((int) this)
    );
    parser.destroy();
    in.destroy();
    input.destroy();
    
    if (list.hasErrors()) {
        env().err()<<"parsing error\n";
        list.destroy();
        return *notAnInfo;
    }
    
    size_t size = list.compile();
    if (list.hasErrors()) {
        env().err()<<"compile error\n";
        list.destroy();
        return *notAnInfo;
    }
    
    MemoryInfo &idtInfo = env().getAllocator().allocate(size);
    MemoryOStream &idtOStream = env().create<MemoryOStream, MemoryInfo&>(idtInfo);
    
    list.finalize((size_t)idtInfo.buf);
    if (list.hasErrors()) {
        env().err()<<"finalize error\n";
        idtOStream.destroy();
        env().getAllocator().free(idtInfo);
        list.destroy();
        return *notAnInfo;
    }
    
    list.writeToStream(idtOStream);
    idtOStream.destroy();
    list.destroy();
    
    return idtInfo;
}    
