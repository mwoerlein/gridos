#include "I386/I386InterruptVectorTable.hpp"

#include "sys/String.hpp"
#include "memory/MemoryIStream.hpp"
#include "memory/MemoryOStream.hpp"
#include "I386ASM/Parser.hpp"
#include "I386ASM/ParseErrorStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Number.hpp"

//I386InterruptVectorTable *I386InterruptVectorTable::active = 0;

MemoryInfo & I386InterruptVectorTable::generateIdt(int entries, void *idt_trampoline) {
    const char *pasm =
R"(.code32
    .byte 0x0f; .byte 0x01; .byte 0x1d #// lidtl idt_global_48
    .long idt_global_48
    ret
    
idt_global_48:
    .word ((idt_desc_end - idt_desc_start)-1) # limit
    .long idt_desc_start                  # base
idt_desc_start:
idt_desc_00: .word idt_00; .word 0x0008; .word 0x8e00; .word (idt_00 >> 16)
idt_desc_01: .word idt_01; .word 0x0008; .word 0x8e00; .word (idt_01 >> 16)
idt_desc_02: .word idt_02; .word 0x0008; .word 0x8e00; .word (idt_02 >> 16)
idt_desc_03: .word idt_03; .word 0x0008; .word 0x8e00; .word (idt_03 >> 16)
idt_desc_04: .word idt_04; .word 0x0008; .word 0x8e00; .word (idt_04 >> 16)
idt_desc_05: .word idt_05; .word 0x0008; .word 0x8e00; .word (idt_05 >> 16)
idt_desc_06: .word idt_06; .word 0x0008; .word 0x8e00; .word (idt_06 >> 16)
idt_desc_07: .word idt_07; .word 0x0008; .word 0x8e00; .word (idt_07 >> 16)
idt_desc_08: .word idt_08; .word 0x0008; .word 0x8e00; .word (idt_08 >> 16)
idt_desc_09: .word idt_09; .word 0x0008; .word 0x8e00; .word (idt_09 >> 16)
idt_desc_10: .word idt_10; .word 0x0008; .word 0x8e00; .word (idt_10 >> 16)
idt_desc_11: .word idt_11; .word 0x0008; .word 0x8e00; .word (idt_11 >> 16)
idt_desc_12: .word idt_12; .word 0x0008; .word 0x8e00; .word (idt_12 >> 16)
idt_desc_13: .word idt_13; .word 0x0008; .word 0x8e00; .word (idt_13 >> 16)
idt_desc_14: .word idt_14; .word 0x0008; .word 0x8e00; .word (idt_14 >> 16)
idt_desc_15: .word idt_15; .word 0x0008; .word 0x8e00; .word (idt_15 >> 16)
idt_desc_16: .word idt_16; .word 0x0008; .word 0x8e00; .word (idt_16 >> 16)
idt_desc_17: .word idt_17; .word 0x0008; .word 0x8e00; .word (idt_17 >> 16)
idt_desc_18: .word idt_18; .word 0x0008; .word 0x8e00; .word (idt_18 >> 16)
idt_desc_19: .word idt_19; .word 0x0008; .word 0x8e00; .word (idt_19 >> 16)
idt_desc_20: .word idt_20; .word 0x0008; .word 0x8e00; .word (idt_20 >> 16)
idt_desc_21: .word idt_21; .word 0x0008; .word 0x8e00; .word (idt_21 >> 16)
idt_desc_22: .word idt_22; .word 0x0008; .word 0x8e00; .word (idt_22 >> 16)
idt_desc_23: .word idt_23; .word 0x0008; .word 0x8e00; .word (idt_23 >> 16)
idt_desc_24: .word idt_24; .word 0x0008; .word 0x8e00; .word (idt_24 >> 16)
idt_desc_25: .word idt_25; .word 0x0008; .word 0x8e00; .word (idt_25 >> 16)
idt_desc_26: .word idt_26; .word 0x0008; .word 0x8e00; .word (idt_26 >> 16)
idt_desc_27: .word idt_27; .word 0x0008; .word 0x8e00; .word (idt_27 >> 16)
idt_desc_28: .word idt_28; .word 0x0008; .word 0x8e00; .word (idt_28 >> 16)
idt_desc_29: .word idt_29; .word 0x0008; .word 0x8e00; .word (idt_29 >> 16)
idt_desc_30: .word idt_30; .word 0x0008; .word 0x8e00; .word (idt_30 >> 16)
idt_desc_31: .word idt_31; .word 0x0008; .word 0x8e00; .word (idt_31 >> 16)
idt_desc_32: .word idt_32; .word 0x0008; .word 0x8e00; .word (idt_32 >> 16)
idt_desc_33: .word idt_33; .word 0x0008; .word 0x8e00; .word (idt_33 >> 16)
idt_desc_34: .word idt_34; .word 0x0008; .word 0x8e00; .word (idt_34 >> 16)
idt_desc_35: .word idt_35; .word 0x0008; .word 0x8e00; .word (idt_35 >> 16)
idt_desc_36: .word idt_36; .word 0x0008; .word 0x8e00; .word (idt_36 >> 16)
idt_desc_37: .word idt_37; .word 0x0008; .word 0x8e00; .word (idt_37 >> 16)
idt_desc_38: .word idt_38; .word 0x0008; .word 0x8e00; .word (idt_38 >> 16)
idt_desc_39: .word idt_39; .word 0x0008; .word 0x8e00; .word (idt_39 >> 16)
idt_desc_40: .word idt_40; .word 0x0008; .word 0x8e00; .word (idt_40 >> 16)
idt_desc_41: .word idt_41; .word 0x0008; .word 0x8e00; .word (idt_41 >> 16)
idt_desc_42: .word idt_42; .word 0x0008; .word 0x8e00; .word (idt_42 >> 16)
idt_desc_43: .word idt_43; .word 0x0008; .word 0x8e00; .word (idt_43 >> 16)
idt_desc_44: .word idt_44; .word 0x0008; .word 0x8e00; .word (idt_44 >> 16)
idt_desc_45: .word idt_45; .word 0x0008; .word 0x8e00; .word (idt_45 >> 16)
idt_desc_46: .word idt_46; .word 0x0008; .word 0x8e00; .word (idt_46 >> 16)
idt_desc_47: .word idt_47; .word 0x0008; .word 0x8e00; .word (idt_47 >> 16)
idt_desc_48: .word idt_48; .word 0x0008; .word 0x8e00; .word (idt_48 >> 16)
idt_desc_49: .word idt_49; .word 0x0008; .word 0x8e00; .word (idt_49 >> 16)
idt_desc_50: .word idt_50; .word 0x0008; .word 0x8e00; .word (idt_50 >> 16)
idt_desc_51: .word idt_51; .word 0x0008; .word 0x8e00; .word (idt_51 >> 16)
idt_desc_52: .word idt_52; .word 0x0008; .word 0x8e00; .word (idt_52 >> 16)
idt_desc_53: .word idt_53; .word 0x0008; .word 0x8e00; .word (idt_53 >> 16)
idt_desc_54: .word idt_54; .word 0x0008; .word 0x8e00; .word (idt_54 >> 16)
idt_desc_55: .word idt_55; .word 0x0008; .word 0x8e00; .word (idt_55 >> 16)
idt_desc_56: .word idt_56; .word 0x0008; .word 0x8e00; .word (idt_56 >> 16)
idt_desc_57: .word idt_57; .word 0x0008; .word 0x8e00; .word (idt_57 >> 16)
idt_desc_58: .word idt_58; .word 0x0008; .word 0x8e00; .word (idt_58 >> 16)
idt_desc_59: .word idt_59; .word 0x0008; .word 0x8e00; .word (idt_59 >> 16)
idt_desc_60: .word idt_60; .word 0x0008; .word 0x8e00; .word (idt_60 >> 16)
idt_desc_61: .word idt_61; .word 0x0008; .word 0x8e00; .word (idt_61 >> 16)
idt_desc_62: .word idt_62; .word 0x0008; .word 0x8e00; .word (idt_62 >> 16)
idt_desc_63: .word idt_63; .word 0x0008; .word 0x8e00; .word (idt_63 >> 16)
idt_desc_end:
idt_00: pushl %eax; movl  0, %eax; jmp idt_base
idt_01: pushl %eax; movl  1, %eax; jmp idt_base
idt_02: pushl %eax; movl  2, %eax; jmp idt_base
idt_03: pushl %eax; movl  3, %eax; jmp idt_base
idt_04: pushl %eax; movl  4, %eax; jmp idt_base
idt_05: pushl %eax; movl  5, %eax; jmp idt_base
idt_06: pushl %eax; movl  6, %eax; jmp idt_base
idt_07: pushl %eax; movl  7, %eax; jmp idt_base
idt_08: pushl %eax; movl  8, %eax; jmp idt_base
idt_09: pushl %eax; movl  9, %eax; jmp idt_base
idt_10: pushl %eax; movl 10, %eax; jmp idt_base
idt_11: pushl %eax; movl 11, %eax; jmp idt_base
idt_12: pushl %eax; movl 12, %eax; jmp idt_base
idt_13: pushl %eax; movl 13, %eax; jmp idt_base
idt_14: pushl %eax; movl 14, %eax; jmp idt_base
idt_15: pushl %eax; movl 15, %eax; jmp idt_base
idt_16: pushl %eax; movl 16, %eax; jmp idt_base
idt_17: pushl %eax; movl 17, %eax; jmp idt_base
idt_18: pushl %eax; movl 18, %eax; jmp idt_base
idt_19: pushl %eax; movl 19, %eax; jmp idt_base
idt_20: pushl %eax; movl 20, %eax; jmp idt_base
idt_21: pushl %eax; movl 21, %eax; jmp idt_base
idt_22: pushl %eax; movl 22, %eax; jmp idt_base
idt_23: pushl %eax; movl 23, %eax; jmp idt_base
idt_24: pushl %eax; movl 24, %eax; jmp idt_base
idt_25: pushl %eax; movl 25, %eax; jmp idt_base
idt_26: pushl %eax; movl 26, %eax; jmp idt_base
idt_27: pushl %eax; movl 27, %eax; jmp idt_base
idt_28: pushl %eax; movl 28, %eax; jmp idt_base
idt_29: pushl %eax; movl 29, %eax; jmp idt_base
idt_30: pushl %eax; movl 30, %eax; jmp idt_base
idt_31: pushl %eax; movl 31, %eax; jmp idt_base
idt_32: pushl %eax; movl 32, %eax; jmp idt_base
idt_33: pushl %eax; movl 33, %eax; jmp idt_base
idt_34: pushl %eax; movl 34, %eax; jmp idt_base
idt_35: pushl %eax; movl 35, %eax; jmp idt_base
idt_36: pushl %eax; movl 36, %eax; jmp idt_base
idt_37: pushl %eax; movl 37, %eax; jmp idt_base
idt_38: pushl %eax; movl 38, %eax; jmp idt_base
idt_39: pushl %eax; movl 39, %eax; jmp idt_base
idt_40: pushl %eax; movl 40, %eax; jmp idt_base
idt_41: pushl %eax; movl 41, %eax; jmp idt_base
idt_42: pushl %eax; movl 42, %eax; jmp idt_base
idt_43: pushl %eax; movl 43, %eax; jmp idt_base
idt_44: pushl %eax; movl 44, %eax; jmp idt_base
idt_45: pushl %eax; movl 45, %eax; jmp idt_base
idt_46: pushl %eax; movl 46, %eax; jmp idt_base
idt_47: pushl %eax; movl 47, %eax; jmp idt_base
idt_48: pushl %eax; movl 48, %eax; jmp idt_base
idt_49: pushl %eax; movl 49, %eax; jmp idt_base
idt_50: pushl %eax; movl 50, %eax; jmp idt_base
idt_51: pushl %eax; movl 51, %eax; jmp idt_base
idt_52: pushl %eax; movl 52, %eax; jmp idt_base
idt_53: pushl %eax; movl 53, %eax; jmp idt_base
idt_54: pushl %eax; movl 54, %eax; jmp idt_base
idt_55: pushl %eax; movl 55, %eax; jmp idt_base
idt_56: pushl %eax; movl 56, %eax; jmp idt_base
idt_57: pushl %eax; movl 57, %eax; jmp idt_base
idt_58: pushl %eax; movl 58, %eax; jmp idt_base
idt_59: pushl %eax; movl 59, %eax; jmp idt_base
idt_60: pushl %eax; movl 60, %eax; jmp idt_base
idt_61: pushl %eax; movl 61, %eax; jmp idt_base
idt_62: pushl %eax; movl 62, %eax; jmp idt_base
idt_63: pushl %eax; movl 63, %eax; jmp idt_base

idt_base:
    pushl %eax
    pushl table_ref
    call (trampoline)
    addl 8, %esp
    popl %eax
    .byte 0xCF  #// iret
trampoline: .long idt_trampoline
)";
    // TODO: use "entries" instead of hard coded idt
    // TODO: generate InstructionList directly?
    String input = env().create<String, const char*>(pasm);
    IStream &in = input.toIStream();
    Parser &parser = env().create<Parser>();
    ASMInstructionList &list = parser.parse(in, env().err());
    list.addDefinition(
        env().create<String, const char*>("idt_trampoline"),
        env().create<Number, int>((int) idt_trampoline)
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
