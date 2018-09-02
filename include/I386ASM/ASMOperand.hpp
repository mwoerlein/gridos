#ifndef I386ASMOPERAND_HPP_LOCK
#define I386ASMOPERAND_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/OStream.hpp"

enum OperandType { reg, indirect, number, id };

class ASMOperand: virtual public Object {
    public:
    virtual ~ASMOperand() {}
    
    virtual void logToStream(OStream &stream) = 0;
    
    friend OStream & operator << (OStream & out, ASMOperand &operand);
    
    // TODO #6: implement RTTI correctly
    template <class As> As * as(OperandType type) {
        return (As *) ((this->type() == type) ? this->_memory_info->buf : 0);
    }
    virtual OperandType type() = 0;
};

#endif //I386ASMOPERAND_HPP_LOCK
