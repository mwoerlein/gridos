#ifndef I386ASM_INSTRUCTION_INLINE_HPP_LOCK
#define I386ASM_INSTRUCTION_INLINE_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Inline: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes(BitWidth data, BitWidth addr, BitWidth mode) override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands(BitWidth data, BitWidth addr, BitWidth mode) override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Inline(Environment &env, MemoryInfo &mi, ASMOperand *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "INLINE", operandSize, o1), Object(env, mi) {}
    virtual ~Inline() {}
    
    virtual void writeToStream(OStream &stream) override;
    virtual OStream & operator >>(OStream & stream) override;
};

#endif //I386ASM_INSTRUCTION_INLINE_HPP_LOCK
