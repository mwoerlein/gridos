#ifndef I386ASM_INSTRUCTION_ORGANIZE_HPP_LOCK
#define I386ASM_INSTRUCTION_ORGANIZE_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Organize: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Organize(Environment &env, MemoryInfo &mi, ASMOperand *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, ".org", operandSize, o1), Object(env, mi) {}
    virtual ~Organize() {}
    
    virtual void writeToStream(OStream &stream) override;
    virtual OStream & operator >>(OStream & stream) override;
};

#endif //I386ASM_INSTRUCTION_ORGANIZE_HPP_LOCK
