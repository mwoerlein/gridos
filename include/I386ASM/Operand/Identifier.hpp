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
    
    virtual String &identifier() {
        return _id;
    }

    virtual void logToStream(OStream &stream) {
        stream<<_id;
    }
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() { return id; }
    virtual int hash() override {
        return _id.hash();
    }
    virtual bool equals(Object &o) override {
        if (ASMOperand *op = env().as<ASMOperand>(o, asm_operand)) {
            if (Identifier *i = op->as<Identifier>(id)) {
                return _id.equals(i->_id);
            }
        }
        return false;
    }
};

#endif //I386ASMIDENTIFIER_HPP_LOCK
