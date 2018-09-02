#ifndef I386ASMNUMBER_HPP_LOCK
#define I386ASMNUMBER_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"


class Number: public ASMOperand {
    private:
    int _number;
    
    public:
    Number(Environment &env, MemoryInfo &mi, int number):Object(env, mi), _number(number) {}
    virtual ~Number() {}
    
    virtual int value() {
        return _number;
    }

    virtual void logToStream(OStream &stream) {
        stream<<(void*)_number;
    }
    
    virtual OperandType type() { return number; }
};

#endif //I386ASMNUMBER_HPP_LOCK
