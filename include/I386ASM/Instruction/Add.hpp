#ifndef I386ASMADD_HPP_LOCK
#define I386ASMADD_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Add: public ASMInstruction {
    private:
    
    public:
    Add(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, OperandSize os = automatic)
        :ASMInstruction(env, mi, os, o1, o2), Object(env, mi) {}
    virtual ~Add() {}
    
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "add";
        switch (os) {
            case b: stream << 'b'; break;
            case w: stream << 'w'; break;
            case l: stream << 'l'; break;
        }
        stream << ' ' << *o1 << ", " << *o2;
    }
};

#endif //I386ASMADD_HPP_LOCK
