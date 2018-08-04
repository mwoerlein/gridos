#ifndef I386ASMJUMP_HPP_LOCK
#define I386ASMJUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Jump: public ASMInstruction {
    private:
    
    public:
    Jump(Environment &env):ASMInstruction(env) {}
    virtual ~Jump() {}
    
    virtual int getSizeInByte();
    virtual void writeToStream(OStream &stream);
};

#endif //I386ASMJUMP_HPP_LOCK
