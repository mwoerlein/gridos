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
    
    virtual bool isConstant(ASMInstructionList & list) override;
    virtual int getValue(ASMInstructionList & list) override;
    virtual Numeric & clone() override;
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() override;
    virtual int hash() override;
    virtual bool equals(Object &o) override;
};

#endif //I386ASMNUMBER_HPP_LOCK
