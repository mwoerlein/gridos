#ifndef I386ASM_OPERAND_FORMULA_HPP_LOCK
#define I386ASM_OPERAND_FORMULA_HPP_LOCK

#include "I386ASM/Operand/Numeric.hpp"

enum FormulaOperation { op_add, op_sub, op_mul, op_div, op_mod, op_shr, op_shl };

class Formula: public Numeric {
    private:
    const char* getOperation(FormulaOperation op);
    
    FormulaOperation _op;
    Numeric *_o1, *_o2;
    
    protected:
    virtual int compute(int v1, int v2);
    
    public:
    Formula(Environment &env, MemoryInfo &mi, FormulaOperation op, Numeric &o1, Numeric &o2);
    virtual ~Formula();

    virtual OStream & operator >>(OStream & stream);
        
    virtual bool isConstant(ASMInstructionList & list) override;
    virtual int getValue(ASMInstructionList & list) override;
    virtual Numeric * validateAndReplace(ASMInstructionList & list, BitWidth mode) override;
    virtual Numeric & clone() override;
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() { return formula; }
    virtual int hash() override {
        return (_o1->hash()<<(int)_op) + _o2->hash();
    }
    virtual bool equals(Object &o) override {
        if (ASMOperand *op = env().as<ASMOperand>(o, asm_operand)) {
            if (Formula *id = op->as<Formula>(formula)) {
                return (_op == id->_op) && (_o1->equals(*id->_o1)) && (_o2->equals(*id->_o2));
            }
        }
        return false;
    }
};

#endif //I386ASM_OPERAND_FORMULA_HPP_LOCK
