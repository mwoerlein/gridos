#ifndef I386ASMINSTRUCTION_HPP_LOCK
#define I386ASMINSTRUCTION_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/OStream.hpp"
#include "I386ASM/ASMTypes.hpp"
#include "I386ASM/ASMOperand.hpp"

class ASMInstructionList;
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
    
    virtual void writeNumberToStream(OStream &stream, int val, int size);
    
    virtual bool validateOperandsAndOperandSize(OStream &err) = 0;
    virtual size_t determineOpcodeAndSize(OStream &err) = 0;
    virtual void writeOperandsToStream(OStream &stream) = 0;
    
    public:
    ASMInstruction(Environment &env, MemoryInfo &mi, const char * mnemonic, BitWidth operandSize = bit_auto, ASMOperand *o1 = 0, ASMOperand *o2 = 0, ASMOperand *o3 = 0, BitWidth addrSize = bit_32)
        :Object(env, mi), mnemonic(mnemonic), o1(o1), o2(o2), o3(o3), operandSize(operandSize), addrSize(addrSize),
         pre1(0), pre2(0), pre3(0), pre4(0),
         op1(90), op2(0), op3(0),
         modrmSize(0), sibSize(0), dispSize(0), immSize(0), size(0), pos(-1), list(0) {}
    virtual ~ASMInstruction() {
        if (o1) { o1->destroy(); }
        if (o2) { o2->destroy(); }
        if (o3) { o3->destroy(); }
    }
    
    virtual bool prepare(OStream &err);
    virtual size_t getMaxSizeInBytes() = 0;
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream);
    
    friend OStream & operator << (OStream & out, ASMInstruction &instruction);
};

// http://sparksandflames.com/files/x86InstructionChart.html

#endif //I386ASMINSTRUCTION_HPP_LOCK
