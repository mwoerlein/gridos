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
    BitWidth addrSize = bit_auto;
    
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
    
    virtual ASMOperand * validateAndReplace(ASMInstructionList & list, BitWidth mode) override {
        addrSize = mode;
        if (_index) {
            switch (_index->name()) {
                case reg_eax:
                case reg_ebx:
                case reg_ecx:
                case reg_edx:
                case reg_edi:
                case reg_esi:
                case reg_ebp:
                case reg_di:
                case reg_si:
                    addrSize = _index->getOperandSize();
                    break;
                default:
                    list.err << "invalid index register: " << *_index << '\n';
            }
        }
        if (_base) {
            switch (_base->name()) {
                case reg_eax:
                case reg_ebx:
                case reg_ecx:
                case reg_edx:
                case reg_edi:
                case reg_esi:
                case reg_ebp:
                case reg_esp:
                case reg_bx:
                case reg_bp:
                    addrSize = _base->getOperandSize();
                    break;
                case reg_di:
                case reg_si:
                    if (_index) {
                        list.err << "invalid index register: " << *_index << '\n';
                    } else {
                        addrSize = _base->getOperandSize();
                    }
                    break;
                default:
                    list.err << "invalid base register: " << *_base << '\n';
            }
        }
        if (_base && _index) {
            if (_base->getOperandSize() != _index->getOperandSize()) {
                list.err << "index and base register do not match: " << *this << '\n';
            }
        }
        if (addrSize == bit_32) {
            switch (_scale) {
                case 1:
                case 2:
                case 4:
                case 8:
                    break;
                default:
                    list.err << "invalid scale: " << _scale << '\n';
            }
        } else {
            if (_scale != 1) {
                list.err << "invalid scale: " << _scale << '\n';
            }
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
    
    virtual BitWidth getAddrSize() {
        return addrSize;
    }
    
    virtual int getModRMSize() {
        return 1;
    }
    
    virtual int getSibSize() {
        if (addrSize == bit_16) {
            return 0;
        }
        if (_index || (_base && (*_base == reg_esp))) {
            return 1;
        }
        return 0;
    }
    
    virtual BitWidth getDispSize() {
        if (_displacementId) {
            return addrSize;
        }
        if (_displacement) {
            int value = _displacement->value();
            if ((_base || _index) && (-128 <= value && value <= 127)) {
                return bit_8; 
            }
            return addrSize;
        }
        if (_base && (*_base == reg_bp) && !_index) {
            return bit_8; // use 0(%bp)
        }
        if (!_base && _index) {
            return addrSize; // use 0(,<_index>)
        }
        return bit_auto; // no disp bytes
    }

    virtual char getModRM(int reg) {
        switch (addrSize) {
            case bit_32: switch (getDispSize()) {
                case bit_auto:
                    if (_index) {
                        return ModRM(0, reg, 4);
                    }
                    return ModRM(0, reg, _base->getOpCodeRegister());
                case bit_8:
                    if (_index) {
                        return ModRM(1, reg, 4);
                    }
                    return ModRM(1, reg, _base->getOpCodeRegister());
                case bit_32:
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
                default:
                    return -1;
            }
            case bit_16: { 
                if (!_base) {
                    // 16 bit offset
                    return ModRM(0, reg, 6);
                }
                int mod = 0;
                switch (getDispSize()) {
                    case bit_8: mod = 1; break;
                    case bit_16: mod = 2;break;
                }
                switch (_base->name()) {
                    case reg_bx:
                        return ModRM(mod, reg, (!_index ? 7 : ((*_index == reg_si) ? 0 : 1)));
                    case reg_bp:
                        return ModRM(mod, reg, (!_index ? 6 : ((*_index == reg_si) ? 2 : 3)));
                    case reg_si:
                        return ModRM(mod, reg, 4);
                    case reg_di:
                        return ModRM(mod, reg, 5);
                }
            }
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
            return list.getLabel(_displacementId->id());
        }
        if (_displacement) {
            return _displacement->value();
        }
        return 0;
    }
    
    virtual bool isOffset() {
        return !_base && !_index;
    }
    
    virtual OStream & operator >>(OStream & stream) {
        if (_displacementId && !_base && !_index) {
            // memory indirect
            return stream << '(' << *_displacementId << ')';
        }
        if (_displacement && !_base && !_index) {
            // memory indirect
            return stream << '(' << *_displacement << ')';
        }
        
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
        return stream << ')';
    }
    
    virtual OperandType type() { return indirect; }
};

#endif //I386ASMINDIRECT_HPP_LOCK
