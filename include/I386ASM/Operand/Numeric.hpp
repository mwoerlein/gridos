#ifndef I386ASM_OPERAND_NUMERIC_HPP_LOCK
#define I386ASM_OPERAND_NUMERIC_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"

class Numeric: public ASMOperand {
    public:
    Numeric(Environment &env, MemoryInfo &mi):Object(env, mi) {}
    virtual ~Numeric() {}
    
    virtual int getValue(ASMInstructionList & list) = 0;
    virtual Numeric & clone() = 0;
    virtual Numeric * asNumeric() {
        return this;
    }
};

#endif //I386ASM_OPERAND_FORMULA_HPP_LOCK
