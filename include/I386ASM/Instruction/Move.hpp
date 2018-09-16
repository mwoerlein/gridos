#ifndef I386ASMMOVE_HPP_LOCK
#define I386ASMMOVE_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Move: public ASMInstruction {
    protected:
    virtual bool validateOperandsAndOperandSize(OStream &err);
    virtual size_t determineOpcodeAndSize(OStream &err);
    
    public:
    Move(Environment &env, MemoryInfo &mi, ASMOperand *o1, ASMOperand *o2, BitWidth operandSize = bit_auto)
        :ASMInstruction(env, mi, operandSize, o1, o2), Object(env, mi) {}
    virtual ~Move() {}
    
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "mov";
        switch (operandSize) {
            case bit_8: stream << 'b'; break;
            case bit_16: stream << 'w'; break;
            case bit_32: stream << 'l'; break;
        }
        stream << ' ' << *o1 << ", " << *o2;
    }
};

#endif //I386ASMMOVE_HPP_LOCK
