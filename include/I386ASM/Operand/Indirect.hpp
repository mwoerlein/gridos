#ifndef I386ASMINDIRECT_HPP_LOCK
#define I386ASMINDIRECT_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"
#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Number.hpp"


class Indirect: public ASMOperand {
    private:
    Number *_displacement;
    Register *_base;
    Register *_index;
    int _scale;
    
    public:
    Indirect(Environment &env, MemoryInfo &mi, Register *base = 0, Number *displacement = 0, Register * index = 0, int scale = 1)
        :Object(env, mi), _base(base), _displacement(displacement), _index(index), _scale(scale) {}
    virtual ~Indirect() {
        if (_base) {
            _base->destroy();
        }
        if (_index) {
            _index->destroy();
        }
        if (_displacement) {
            _displacement->destroy();
        }
    }
    
    virtual void logToStream(OStream &stream) {
        if (_displacement && !_base && !_index) {
            // memory indirect
            stream << '(' << (void*)_displacement->value() << ')';
        } else {
            // register indirect
            if (_displacement) {
                stream << (void*)_displacement->value();
            }
            stream << '(';
            if (_base) {
                stream << *_base;
            }
            if (_index) {
                stream << ',' << *_index;
                if (_scale > 1) {
                    stream << ',' << _scale;
                }
            }
            stream << ')';
        }
    }
    
    virtual OperandType type() { return indirect; }
};

#endif //I386ASMINDIRECT_HPP_LOCK
