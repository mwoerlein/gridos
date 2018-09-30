#ifndef I386ASM_INSTRUCTION_ONEBYTENOOPERAND_HPP_LOCK
#define I386ASM_INSTRUCTION_ONEBYTENOOPERAND_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class OneByteNoOperand: public ASMInstruction {
    protected:
    virtual void validateOperandsAndOperandSize() override;
    virtual size_t determineOpcodeAndSize() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    OneByteNoOperand(Environment &env, MemoryInfo &mi, const char * mnemonic, char opCode)
        :ASMInstruction(env, mi, mnemonic), Object(env, mi) {
        op1 = opCode;
    }
    virtual ~OneByteNoOperand() {}
    virtual size_t getMaxSizeInBytes() override;
};

#endif //I386ASM_INSTRUCTION_ONEBYTENOOPERAND_HPP_LOCK
