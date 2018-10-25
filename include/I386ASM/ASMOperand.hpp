#ifndef I386ASMOPERAND_HPP_LOCK
#define I386ASMOPERAND_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/stream/OStream.hpp"
#include "I386ASM/ASMTypes.hpp"

class ASMInstructionList;
class Numeric;
class ASMOperand: virtual public Object {
    public:
    virtual ~ASMOperand() {}
    
    virtual ASMOperand * validateAndReplace(ASMInstructionList & list, BitWidth mode) {
        return 0;
    }
    virtual OStream & operator >>(OStream & stream) = 0;
    
    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() override { return asm_operand; }
    template <class As> As * as(OperandType type) {
        return (As *) ((this->type() == type) ? this->_memory_info->buf : 0);
    }
    virtual Numeric * asNumeric() {
        return 0;
    }
    virtual OperandType type() = 0;
};
//#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Numeric.hpp"

#endif //I386ASMOPERAND_HPP_LOCK
