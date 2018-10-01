#ifndef I386ASMADD_HPP_LOCK
#define I386ASMADD_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Add: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Add(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "add", operandSize, o1, o2), Object(env, mi) {}
    virtual ~Add() {}
};

#endif //I386ASMADD_HPP_LOCK
