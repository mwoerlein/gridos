#ifndef I386ASMJUMP_HPP_LOCK
#define I386ASMJUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Jump: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Jump(Environment &env, MemoryInfo &mi, ASMOperand *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "jmp", operandSize, o1), Object(env, mi) {}
    virtual ~Jump() {}
};

#endif //I386ASMJUMP_HPP_LOCK
