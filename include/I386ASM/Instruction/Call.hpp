#ifndef I386ASM_INSTRUCTION_CALL_HPP_LOCK
#define I386ASM_INSTRUCTION_CALL_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Call: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Call(Environment &env, MemoryInfo &mi, ASMOperand *o1)
        :ASMInstruction(env, mi, "call", bit_auto, o1), Object(env, mi) {}
    virtual ~Call() {}
};

#endif //I386ASM_INSTRUCTION_CALL_HPP_LOCK
