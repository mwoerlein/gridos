#ifndef I386ASMJUMP_HPP_LOCK
#define I386ASMJUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"
#include "I386ASM/Operand/Number.hpp"

class Jump: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err);
    virtual size_t determineOpcodeAndSize(OStream &err);
    
    public:
    Jump(Environment &env, MemoryInfo &mi, Number *o1, OperandSize os = automatic)
        :ASMInstruction(env, mi, os, o1), Object(env, mi) {}
    virtual ~Jump() {}
    
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "jmp" << ' ' << *o1;
    }
};

#endif //I386ASMJUMP_HPP_LOCK
