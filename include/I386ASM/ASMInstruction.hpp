#ifndef I386ASMINSTRUCTION_HPP_LOCK
#define I386ASMINSTRUCTION_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/OStream.hpp"
#include "I386ASM/ASMOperand.hpp"

enum OperandSize { b = 1, w = 2, l = 4, automatic = 0 };

class ASMInstruction: virtual public Object {
    protected:
    enum OperandSize os;
    ASMOperand *o1, *o2, *o3;
    
    char pre1, pre2, pre3, pre4;
    char op1, op2, op3;
    int modrmSize, sibSize, dispSize, immSize;
    size_t size;
    
    virtual bool validateOperandsAndOperandSize(OStream &err) = 0;
    virtual size_t determineOpcodeAndSize(OStream &err) = 0;
    
    virtual void writeNumber(OStream &stream, int val, int size) {
        switch (size) {
            case 1: stream << (char)val; break;
            case 2: stream << (char)val << (char)(val>>8); break;
            case 4: stream << (char)val << (char)(val>>8) << (char)(val>>16) << (char)(val>>24); break;
        }
    }
    
    public:
    ASMInstruction(Environment &env, MemoryInfo &mi, OperandSize os = automatic, ASMOperand *o1 = 0, ASMOperand *o2 = 0, ASMOperand *o3 = 0)
        :Object(env, mi), os(os), o1(o1), o2(o2), o3(o3),
         pre1(0), pre2(0), pre3(0), pre4(0),
         op1(90), op2(0), op3(0),
         modrmSize(0), sibSize(0), dispSize(0), immSize(0), size(0) {}
    virtual ~ASMInstruction() {
        if (o1) {
            o1->destroy();
        }
        if (o2) {
            o2->destroy();
        }
        if (o3) {
            o3->destroy();
        }
    }
    
    virtual bool prepare(OStream &err);
    virtual size_t getSizeInBytes() {
        return size;
    }
    virtual void writeToStream(OStream &stream) = 0;
    virtual void logToStream(OStream &stream) = 0;
    
    friend OStream & operator << (OStream & out, ASMInstruction &instruction);
};

// http://sparksandflames.com/files/x86InstructionChart.html

#endif //I386ASMINSTRUCTION_HPP_LOCK
