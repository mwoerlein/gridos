#ifndef I386ASM_INSTRUCTION_NOOPERANDINSTRUCTION_HPP_LOCK
#define I386ASM_INSTRUCTION_NOOPERANDINSTRUCTION_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class NoOperandInstruction: public ASMInstruction {
    protected:
    virtual size_t approximateSizeInBytes(BitWidth data, BitWidth addr, BitWidth mode) override;
    virtual void checkOperands() override;
    virtual size_t compileOperands(BitWidth data, BitWidth addr, BitWidth mode) override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    NoOperandInstruction(Environment &env, MemoryInfo &mi, const char * mnemonic, char opCode1 = 90, char opCode2 = 0, char opCode3 = 0);
    virtual ~NoOperandInstruction();
};

#endif //I386ASM_INSTRUCTION_NOOPERANDINSTRUCTION_HPP_LOCK
