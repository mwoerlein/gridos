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
    virtual OperandType type() { return identifier; }
    virtual int hash() override {
        return _id.hash();
    }
    virtual bool equals(Object &o) override {
        if (ASMOperand *op = env().as<ASMOperand>(o, asm_operand)) {
            if (Identifier *id = op->as<Identifier>(identifier)) {
                return _id.equals(id->_id);
            }
        }
        return false;
    }
};

#endif //I386ASMIDENTIFIER_HPP_LOCK
