#ifndef I386ASMIDENTIFIER_HPP_LOCK
#define I386ASMIDENTIFIER_HPP_LOCK

#include "sys/String.hpp"
#include "I386ASM/Operand/Numeric.hpp"

class Identifier: public Numeric {
    private:
    String &_id;
    
    public:
    Identifier(Environment &env, MemoryInfo &mi, String &id);
    virtual ~Identifier();
    
    virtual OStream & operator >>(OStream & stream);
    virtual String &id();
    
    virtual bool isConstant(ASMInstructionList & list) override;
    virtual int getValue(ASMInstructionList & list) override;
    virtual Numeric & clone() override;
    virtual Numeric * validateAndReplace(ASMInstructionList & list, BitWidth mode) override;
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() override;
    virtual int hash() override;
    virtual bool equals(Object &o) override;
};

#endif //I386ASMIDENTIFIER_HPP_LOCK
