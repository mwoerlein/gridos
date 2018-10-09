#ifndef I386ASMINSTRUCTION_HPP_LOCK
#define I386ASMINSTRUCTION_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/stream/OStream.hpp"
#include "I386ASM/ASMTypes.hpp"
#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Number.hpp"

#define useIndirectSizes(i) { \
    modrmSize = (i)->getModRMSize();\
    sibSize = (i)->getSibSize();\
    dispSize = (i)->getDispSize();\
}

class ASMInstruction: virtual public Object {
    protected:
    friend class ASMInstructionList;
    const char *mnemonic;
    ASMOperand *o1, *o2, *o3;
    enum BitWidth operandSize, addrSize;
    
    char pre1, pre2, pre3, pre4;
    char op1, op2, op3;
    int modrmSize, sibSize, dispSize, immSize;
    size_t size, pos;
    ASMInstructionList * list;
    
    virtual size_t approximateSizeInBytes();
    virtual void checkOperands();
    virtual void sanitizeOperands();
    virtual void validateOperands();
    virtual size_t compileOperands() = 0;
    virtual void writeOperandsToStream(OStream &stream) = 0;
    virtual void writeNumberToStream(OStream &stream, int val, int size);
    virtual void writeOffsetToStream(OStream &stream, ASMOperand *o);
    virtual void writeImmediateToStream(OStream &stream, ASMOperand *o);
    virtual void writeModRMToStream(OStream &stream, int regO, int regM);
    virtual void writeIndirectToStream(OStream &stream, Indirect *i, int reg);
    virtual BitWidth getBitWidth(int value);
    virtual BitWidth getUnsignedBitWidth(unsigned int value);
    virtual BitWidth approximateOffsetWidth(Identifier *id);

    inline void writeModRMToStream(OStream &stream, Register *regO, Register *regM) {
        writeModRMToStream(stream, regO->getOpCodeRegister(), regM->getOpCodeRegister());
    }
    inline void writeModRMToStream(OStream &stream, int regO, Register *regM) {
        writeModRMToStream(stream, regO, regM->getOpCodeRegister());
    }
    inline void writeIndirectToStream(OStream &stream, Indirect *i, Register *reg) {
        writeIndirectToStream(stream, i, reg->getOpCodeRegister());
    }
    
    public:
    ASMInstruction(Environment &env, MemoryInfo &mi, const char * mnemonic, BitWidth operandSize = bit_auto, ASMOperand *o1 = 0, ASMOperand *o2 = 0, ASMOperand *o3 = 0, BitWidth addrSize = bit_32)
        :Object(env, mi), mnemonic(mnemonic), o1(o1), o2(o2), o3(o3), operandSize(operandSize), addrSize(addrSize),
         pre1(0), pre2(0), pre3(0), pre4(0),
         op1(0x90), op2(0), op3(0),
         modrmSize(0), sibSize(0), dispSize(0), immSize(0), size(0), pos(-1), list(0) {}
    virtual ~ASMInstruction() {
        if (o1) { o1->destroy(); }
        if (o2) { o2->destroy(); }
        if (o3) { o3->destroy(); }
    }
    
    virtual size_t compile();
    
    virtual void writeToStream(OStream &stream);
    virtual OStream & operator >>(OStream & stream) override;
};

// http://sparksandflames.com/files/x86InstructionChart.html

#endif //I386ASMINSTRUCTION_HPP_LOCK
