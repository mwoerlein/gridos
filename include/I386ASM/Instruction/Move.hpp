#ifndef I386ASMMOV_HPP_LOCK
#define I386ASMMOV_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Move: public ASMInstruction {
    private:
    
    public:
    Move(Environment &env):ASMInstruction(env) {}
    virtual ~Move() {}
    
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
};

#endif //I386ASMMOV_HPP_LOCK
