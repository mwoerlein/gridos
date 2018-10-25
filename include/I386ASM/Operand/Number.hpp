#ifndef I386ASMNUMBER_HPP_LOCK
#define I386ASMNUMBER_HPP_LOCK

#include "I386ASM/Operand/Numeric.hpp"

class Number: public Numeric {
    private:
    int _number;
    
    public:
    Number(Environment &env, MemoryInfo &mi, int number);
    virtual ~Number();
    
    virtual int value();
    virtual OStream & operator >>(OStream & stream);
    
    virtual int getValue(ASMInstructionList & list) override;
    virtual Numeric & clone() override;
    
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
