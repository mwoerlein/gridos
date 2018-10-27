#ifndef I386ASM_INSTRUCTION_BLUB_HPP_LOCK
#define I386ASM_INSTRUCTION_BLUB_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Push: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Push(Environment &env, MemoryInfo &mi, ASMOperand *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "push", operandSize, o1), Object(env, mi) {}
    virtual ~Push() {}
};

#endif //I386ASM_INSTRUCTION_PUSH_HPP_LOCK
