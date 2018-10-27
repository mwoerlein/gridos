#ifndef I386ASM_INSTRUCTION_POP_HPP_LOCK
#define I386ASM_INSTRUCTION_POP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Pop: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Pop(Environment &env, MemoryInfo &mi, ASMOperand *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "pop", operandSize, o1), Object(env, mi) {}
    virtual ~Pop() {}
};

#endif //I386ASM_INSTRUCTION_POP_HPP_LOCK
