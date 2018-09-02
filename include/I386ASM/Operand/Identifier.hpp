#ifndef I386ASMIDENTIFIER_HPP_LOCK
#define I386ASMIDENTIFIER_HPP_LOCK

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
    
    virtual OperandType type() { return id; }
};

#endif //I386ASMIDENTIFIER_HPP_LOCK
