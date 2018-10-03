#ifndef I386ASM_INSTRUCTION_DIV_HPP_LOCK
#define I386ASM_INSTRUCTION_DIV_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Div: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Div(Environment &env, MemoryInfo &mi, ASMOperand *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "div", operandSize, o1), Object(env, mi) {}
    virtual ~Div() {}
};

#endif //I386ASM_INSTRUCTION_DIV_HPP_LOCK
