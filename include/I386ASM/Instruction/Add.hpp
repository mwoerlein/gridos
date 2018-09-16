#ifndef I386ASMADD_HPP_LOCK
#define I386ASMADD_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Add: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err);
    virtual size_t determineOpcodeAndSize(OStream &err);
    
    public:
    Add(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, operandSize, o1, o2), Object(env, mi) {}
    virtual ~Add() {}
    
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "add";
        switch (operandSize) {
            case bit_8: stream << 'b'; break;
            case bit_16: stream << 'w'; break;
            case bit_32: stream << 'l'; break;
        }
        stream << ' ' << *o1 << ", " << *o2;
    }
};

#endif //I386ASMADD_HPP_LOCK
