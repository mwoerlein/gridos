#ifndef I386ASMJUMP_HPP_LOCK
#define I386ASMJUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"
#include "I386ASM/Operand/Number.hpp"

class Jump: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err) override;
    virtual size_t determineOpcodeAndSize(OStream &err) override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Jump(Environment &env, MemoryInfo &mi, Number *o1, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, "jmp", operandSize, o1), Object(env, mi) {}
    virtual ~Jump() {}
};

#endif //I386ASMJUMP_HPP_LOCK
