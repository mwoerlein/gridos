#ifndef I386ASMADD_HPP_LOCK
#define I386ASMADD_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Add: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err) override;
    virtual size_t determineOpcodeAndSize(OStream &err) override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Add(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "add", operandSize, o1, o2), Object(env, mi) {}
    virtual ~Add() {}
    virtual size_t getMaxSizeInBytes() override;
};

#endif //I386ASMADD_HPP_LOCK
