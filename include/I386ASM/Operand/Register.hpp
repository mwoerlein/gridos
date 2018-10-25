#ifndef I386ASMREGISTER_HPP_LOCK
#define I386ASMREGISTER_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"

class Register: public ASMOperand {
    private:
    RegisterName _reg;
    
    public:
    Register(Environment &env, MemoryInfo &mi, RegisterName reg);
    virtual ~Register();
    
    virtual BitWidth getOperandSize();
    virtual RegisterKind kind();
    virtual int getOpCodeRegister();
    virtual void validate(ASMInstructionList & list, BitWidth operandSize);
    virtual RegisterName wideRegister(RegisterName orig, BitWidth size);
    virtual OStream & operator >>(OStream & stream);
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() { return reg; }
    virtual int hash() override {
        return (int) _reg;
    }
    virtual bool equals(Object &o) override {
        if (ASMOperand *op = env().as<ASMOperand>(o, asm_operand)) {
            if (Register *r = op->as<Register>(reg)) {
                return _reg == r->_reg;
            }
        }
        return false;
    }
    inline RegisterName name() { return _reg; }
    inline bool operator ==(RegisterName reg) { return _reg == reg; }
    inline bool operator !=(RegisterName reg) { return _reg != reg; }
};

#endif //I386ASMREGISTER_HPP_LOCK
