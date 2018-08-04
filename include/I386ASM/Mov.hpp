#ifndef I386ASMMOV_HPP_LOCK
#define I386ASMMOV_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Mov: public ASMInstruction {
    private:
    
    public:
    Mov(Environment &env):ASMInstruction(env) {}
    virtual ~Mov() {}
    
    virtual int getSizeInByte();
    virtual void writeToStream(OStream &stream);
};

#endif //I386ASMMOV_HPP_LOCK
