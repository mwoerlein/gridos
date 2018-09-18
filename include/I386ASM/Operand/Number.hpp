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
        stream.printuhex(_number);
    }
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() { return number; }
    virtual int hash() override {
        return _number;
    }
    virtual bool equals(Object &o) override {
        if (ASMOperand *op = env().as<ASMOperand>(o, asm_operand)) {
            if (Number *n = op->as<Number>(number)) {
                return _number == n->_number;
            }
        }
        return false;
    }
};

#endif //I386ASMNUMBER_HPP_LOCK
