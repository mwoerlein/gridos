#ifndef I386ASMMOVE_HPP_LOCK
#define I386ASMMOVE_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Move: public ASMInstruction {
    protected:
    virtual void checkArguments() override;
    virtual void validateOperandsAndOperandSize() override;
    virtual size_t determineOpcodeAndSize() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Move(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "mov", operandSize, o1, o2), Object(env, mi) {}
    virtual ~Move() {}
    virtual size_t getMaxSizeInBytes() override;
};

#endif //I386ASMMOVE_HPP_LOCK
