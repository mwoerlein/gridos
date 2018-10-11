#ifndef I386ASM_INSTRUCTION_JUMP_HPP_LOCK
#define I386ASM_INSTRUCTION_JUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Jump: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes(BitWidth data, BitWidth addr, BitWidth mode) override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands(BitWidth data, BitWidth addr, BitWidth mode) override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Jump(Environment &env, MemoryInfo &mi, ASMOperand *o1)
        :ASMInstruction(env, mi, "jmp", bit_auto, o1), Object(env, mi) {}
    virtual ~Jump() {}
};

#endif //I386ASM_INSTRUCTION_JUMP_HPP_LOCK
