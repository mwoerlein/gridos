#ifndef I386ASMMOVE_HPP_LOCK
#define I386ASMMOVE_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Move: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err);
    virtual bool determineOpcodeAndSize(OStream &err);
    
    public:
    Move(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, OperandSize os = automatic)
        :ASMInstruction(env, mi, os, o1, o2), Object(env, mi) {}
    virtual ~Move() {}
    
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "mov";
        switch (os) {
            case b: stream << 'b'; break;
            case w: stream << 'w'; break;
            case l: stream << 'l'; break;
        }
        stream << ' ' << *o1 << ", " << *o2;
    }
};

#endif //I386ASMMOVE_HPP_LOCK
