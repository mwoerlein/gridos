#ifndef I386ASMHALT_HPP_LOCK
#define I386ASMHALT_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Halt: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err) override;
    virtual size_t determineOpcodeAndSize(OStream &err) override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Halt(Environment &env, MemoryInfo &mi):ASMInstruction(env, mi, "hlt"), Object(env, mi) {}
    virtual ~Halt() {}
};

#endif //I386ASMHALT_HPP_LOCK
