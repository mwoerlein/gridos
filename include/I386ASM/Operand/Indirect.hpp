#ifndef I386ASMINDIRECT_HPP_LOCK
#define I386ASMINDIRECT_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Number.hpp"

class Indirect: public ASMOperand {
    private:
    Identifier *_displacementId;
    Number *_displacement;
    Register *_base;
    Register *_index;
    int _scale;
    
    public:
    Indirect(Environment &env, MemoryInfo &mi, Register *base = 0, Identifier *displacementId = 0, Number *displacement = 0, Register * index = 0, int scale = 1)
        :Object(env, mi), _base(base), _displacementId(displacementId), _displacement(displacement), _index(index), _scale(scale) {
    }
    virtual ~Indirect() {
        if (_base) {
            _base->destroy();
        }
        if (_index) {
            _index->destroy();
        }
        if (_displacementId) {
            _displacementId->destroy();
        }
        if (_displacement) {
            _displacement->destroy();
        }
    }
    
    virtual ASMOperand * validateAndReplace(ASMInstructionList & list) override {
        if (_base) {
            if (_base->getOperandSize() != bit_32) {
                list.err << "invalid base register: " << *_base << '\n';
            }
        }
        if (_index) {
            if (_index->getOperandSize() != bit_32) {
                list.err << "invalid index register: " << *_index << '\n';
            }
        }
        switch (_scale) {
            case 1:
            case 2:
            case 4:
            case 8:
                break;
            default:
                list.err << "invalid scale: " << _scale << '\n';
        }
        if (Number * disp = _displacementId ? _displacementId->validateAndResolveDefinition(list) : 0) {
            _displacementId->destroy();
            _displacementId = 0;
            _displacement = disp;
        }
        if (_displacement && (_displacement->value() == 0) && (_base || _index)) {
            _displacement->destroy();
            _displacement = 0;
        }
        return 0;
    }
    
    virtual int getModMRSize() {
        return 1;
    }
    
    virtual int getSibSize() {
        if (_index || (_base && (*_base == reg_esp))) {
            return 1;
        }
        return 0;
    }
    
    virtual int getDispSize() {
        if (_displacementId) {
            return 4;
        }
        if (_displacement) {
            int value = _displacement->value();
            if ((_base || _index) && (-128 <= value && value <= 127)) {
                return 1; 
            }
            return 4;
        }
        if (!_base && _index) {
            return 4;
        }
        return 0;
    }

    virtual char getModMR(int reg) {
        switch (getDispSize()) {
            case 0:
                if (_index) {
                    return ModRM(0, reg, 4);
                }
                return ModRM(0, reg, _base->getOpCodeRegister());
            case 1:
                if (_index) {
                    return ModRM(1, reg, 4);
                }
                return ModRM(1, reg, _base->getOpCodeRegister());
            case 4:
                if (_index) {
                    if (_base) {
                        return ModRM(2, reg, 4);
                    }
                    return ModRM(0, reg, 4);
                }
                if (_base) {
                    return ModRM(2, reg, _base->getOpCodeRegister());
                }
                return ModRM(0, reg, 5);
        }
        return -1;
    }
    
    virtual char getSib() {
        switch (_scale) {
            case 1:
                return SIB(0, _index?_index->getOpCodeRegister():4, _base?_base->getOpCodeRegister():5); 
            case 2:
                return SIB(1, _index?_index->getOpCodeRegister():4, _base?_base->getOpCodeRegister():5); 
            case 4:
                return SIB(2, _index?_index->getOpCodeRegister():4, _base?_base->getOpCodeRegister():5); 
            case 8:
                return SIB(3, _index?_index->getOpCodeRegister():4, _base?_base->getOpCodeRegister():5); 
        }
        return -1;
    }
    
    virtual int getDispValue(ASMInstructionList & list) {
        if (_displacementId) {
            return list.getLabel(_displacementId->identifier());
        }
        if (_displacement) {
            return _displacement->value();
        }
        return 0;
    }
    
    virtual bool isOffset() {
        return !_base && !_index;
    }
    
    virtual void logToStream(OStream &stream) {
        if (_displacementId && !_base && !_index) {
            // memory indirect
            stream << '(' << *_displacementId << ')';
        } else if (_displacement && !_base && !_index) {
            // memory indirect
            stream << '(' << *_displacement << ')';
        } else {
            // register indirect
            if (_displacementId) {
                stream << *_displacementId;
            } else if (_displacement) {
                stream << *_displacement;
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
