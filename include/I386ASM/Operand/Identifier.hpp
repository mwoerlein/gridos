#ifndef I386ASMIDENTIFIER_HPP_LOCK
#define I386ASMIDENTIFIER_HPP_LOCK

#include "sys/String.hpp"
#include "I386ASM/ASMOperand.hpp"

class Identifier: public ASMOperand {
    private:
    String &_id;
    
    public:
    Identifier(Environment &env, MemoryInfo &mi, String &id):Object(env, mi), _id(id) {}
    virtual ~Identifier() {
        _id.destroy();
    }
    
    virtual String &id() {
        return _id;
    }

    virtual OStream & operator >>(OStream & stream) {
        return stream << _id;
    }

    virtual Number * validateAndResolveDefinition(ASMInstructionList & list) {
        if (list.hasDefinition(_id)) {
            return &list.getNumberForDefinition(_id);
        } else if (!list.hasLabel(_id)) {
            list.err << "Unknown identifier: " << *this << '\n';
        }
        return 0;
    }
    
    virtual ASMOperand * validateAndReplace(ASMInstructionList & list, BitWidth mode) override {
        return validateAndResolveDefinition(list);
    }
    
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
