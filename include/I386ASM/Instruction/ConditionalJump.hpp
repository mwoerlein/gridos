#ifndef I386ASM_INSTRUCTION_CONDITIONALJUMP_HPP_LOCK
#define I386ASM_INSTRUCTION_CONDITIONALJUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class ConditionalJump: public ASMInstruction {
    private:
    const char* getMnemonic(InstructionCondition cond);
    
    protected:
    InstructionCondition condition;
    
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    ConditionalJump(Environment &env, MemoryInfo &mi, InstructionCondition cond, ASMOperand *o1)
        :ASMInstruction(env, mi, getMnemonic(cond), bit_auto, o1), Object(env, mi), condition(cond) {}
    virtual ~ConditionalJump() {}
};

#endif //I386ASM_INSTRUCTION_CONDITIONALJUMP_HPP_LOCK
