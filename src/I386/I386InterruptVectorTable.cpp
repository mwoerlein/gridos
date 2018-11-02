#include "I386/I386InterruptVectorTable.hpp"

#include "sys/String.hpp"
#include "memory/MemoryOStream.hpp"
#include "I386ASM/Parser.hpp"
#include "I386ASM/ASMInstructionList.hpp"

void I386_interrupt_trampoline(I386InterruptVectorTable *table, int32_t nr) {
    table->ITable[nr]->call(nr);
}

class I386InterruptVectorTable::IgnoreHandler: public InterruptHandler {
    public:
    IgnoreHandler(Environment &env, MemoryInfo &mi = *notAnInfo):Object(env,mi) {}
    virtual ~IgnoreHandler() {}
    virtual void call(int nr) override {
        const char* name = getName(nr);
        if (name) {
            env().out() << name << "(int " << nr << ") => halting\n";
            while(1) {__asm__("hlt");}
        } 
        env().out() << "(int " << nr << ") => ignored\n";
    }
    inline const char* getName(int nr) {
        switch (nr) {
            case  0: return "Divide-by-zero";
            case  1: return "Debug";
            case  2: return "NMI";
            case  3: return "Breakpoint";
            case  4: return "Overflow";
            case  5: return "Bound Range Exceeded";
            case  6: return "Invalid Opcode";
            case  7: return "Device Not Available";
            case  8: return "Double Fault";
            case  9: return "Coprocessor Segment Overrun";
            case 10: return "Invalid TSS";
            case 11: return "Segment Not Present";
            case 12: return "Stack-Segment Fault";
            case 13: return "General Protection Fault";
            case 14: return "Page Fault";
            case 16: return "x87 Floating-Point Exception";
            case 17: return "Alignment Check";
            case 18: return "Machine Check";
            case 19: return "SIMD Floating-Point Exception";
            case 20: return "Virtualization Exception";
            case 30: return "Security Exception";
        }
        if (nr < 32) {
            return "Reserved";
        }
        return 0;
    }
};

// public
I386InterruptVectorTable::I386InterruptVectorTable(Environment &env, MemoryInfo &mi)
        :Object(env,mi), ignore(env.create<IgnoreHandler>()), idtInfo(compileIdt()) {
    for (int i = 0; i < TABLESIZE; i++) ITable[i] = &ignore;
}

I386InterruptVectorTable::~I386InterruptVectorTable() {
    if (idtInfo != notAnInfo) {
        env().getAllocator().free(*idtInfo);
    }
    ignore.destroy();
}

void I386InterruptVectorTable::insert(int nr, InterruptHandler &hdl) {
    ITable[nr] = &hdl;
}

void I386InterruptVectorTable::deactivate() {
    //warten bis aktuell laufende Interrupts abgearbeitet sind
    //Speicherfreigeben, ...
}

void I386InterruptVectorTable::activate() {
    if (idtInfo == notAnInfo) {
        env().err()<<"idt generation failed => skip activate\n";
        return;
    }

    __asm__("cli");
    //if (active) active->deactivate();
    //active = this;
    __asm__("lidt %0": : "m"(*((void**) idtInfo->buf)));
    __asm__("sti");
}

int I386InterruptVectorTable::getSize() {
    return TABLESIZE;
}

//private
MemoryInfo * I386InterruptVectorTable::compileIdt() {
    String input = env().create<String>();
    input << "trampoline := "<<(void*) I386_interrupt_trampoline<<'\n';
    input << "table_ref := "<<(void*) this<<'\n';
    input << R"(.code32
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
        input << "idt_entry_"<<i<<": pushad; pushl "<<i<<"; jmp idt_common\n";
    }
    input << R"(
idt_common:
    pushl table_ref
    movl trampoline, %eax
    call %eax
    addl 8, %esp
    popad
    .byte 0xCF  #// iret
)";
    IStream &in = input.toIStream();
    Parser &parser = env().create<Parser>();
    ASMInstructionList &list = parser.parse(in, env().err());
    parser.destroy();
    in.destroy();
    input.destroy();
    
    if (list.hasErrors()) {
        env().err()<<"parsing error\n";
        list.destroy();
        return notAnInfo;
    }
    
    size_t size = list.compile();
    if (list.hasErrors()) {
        env().err()<<"compile error\n";
        list.destroy();
        return notAnInfo;
    }
    
    MemoryInfo *idtInfo = &env().getAllocator().allocate(size);
    
    list.finalize((size_t) idtInfo->buf);
    if (list.hasErrors()) {
        env().err()<<"finalize error\n";
        env().getAllocator().free(*idtInfo);
        list.destroy();
        return notAnInfo;
    }
    
    MemoryOStream &idtOStream = env().create<MemoryOStream, MemoryInfo&>(*idtInfo);
    list.writeToStream(idtOStream);
    idtOStream.destroy();
    list.destroy();
    
    return idtInfo;
}    
