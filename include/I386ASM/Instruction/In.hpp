#ifndef I386ASM_INSTRUCTION_IN_HPP_LOCK
#define I386ASM_INSTRUCTION_IN_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class In: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    In(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "in", operandSize, o1, o2), Object(env, mi) {}
    virtual ~In() {}
};

#endif //I386ASM_INSTRUCTION_IN_HPP_LOCK
