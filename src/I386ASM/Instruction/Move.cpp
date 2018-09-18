#include "I386ASM/Instruction/Move.hpp"

#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Indirect.hpp"

// protected
void Move::writeOperandsToStream(OStream & stream) {
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    if (n1 && r2) {
        writeNumberToStream(stream, n1->value(), immSize);
    }
    if (n1 && i2) {
        if (modrmSize) {
            stream << i2->getModMR(0);
        }
        if (sibSize) {
            stream << i2->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i2->getDispValue(), dispSize);
        }
        writeNumberToStream(stream, n1->value(), immSize);
    }
    if (r1 && r2) {
        stream << ModRM(3, r1->getOpCodeRegister(), r2->getOpCodeRegister());
    }
    if (r1 && i2) {
        if (modrmSize) {
            stream << i2->getModMR(r1->getOpCodeRegister());
        }
        if (sibSize) {
            stream << i2->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i2->getDispValue(), dispSize);
        }
    }
    if (i1 && r2) {
        if (modrmSize) {
            stream << i1->getModMR(r2->getOpCodeRegister());
        }
        if (sibSize) {
            stream << i1->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i1->getDispValue(), dispSize);
        }
    }
}

bool Move::validateOperandsAndOperandSize(OStream &err) {
    bool valid = true;
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    if (operandSize == bit_auto) {
        if (r1) {
            BitWidth newSize = r1->getOperandSize();
            if (r2) {
                if (newSize != r2->getOperandSize()) {
                    err<<"ambigious operand size in \""<<*this<<"\"\n";
                    return false;
                }
            }
            operandSize = newSize;
        } else if (r2) {
            operandSize = r2->getOperandSize();
        } else {
            err<<"missing operand size and no register to determine from in \""<<*this<<"\"\n";
            return false;
        }
    }
    
    if (r1) {
        valid &= r1->validate(err, operandSize);
    }
    if (r2) {
        valid &= r2->validate(err, operandSize);
    }
    if (!valid) {
        return valid;
    }
    
    if (n1 && r2) {
        return true;
    }
    if (n1 && i2) {
        return true;
    }
    if (r1 && r2) {
        return true;
    }
    if (r1 && i2) {
        return true;
    }
    if (i1 && r2) {
        return true;
    }
    err<<"unsupported operands in \""<<*this<<"\"\n";
    return false;
}

size_t Move::determineOpcodeAndSize(OStream &err) {
    size_t size = 0;
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    if (operandSize == bit_16) {
        pre3 = 0x66;
        size++;
    }
    
    if (addrSize == bit_16) {
        pre4 = 0x67;
        size++;
    }
    
    if (n1 && r2) {
        immSize = (int) operandSize;
        op1 = (operandSize == bit_8) ? 0xB0 : 0xB8;
        op1 += r2->getOpCodeRegister();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (n1 && i2) {
        immSize = (int) operandSize;
        op1 = (operandSize == bit_8) ? 0xC6 : 0xC7;
        modrmSize = i2->getModMRSize();
        sibSize = i2->getSibSize();
        dispSize = i2->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (r1 && r2) {
        op1 = (operandSize == bit_8) ? 0x88 : 0x89;
        modrmSize = 1;
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (r1 && i2) {
        op1 = (operandSize == bit_8) ? 0x88 : 0x89;
        modrmSize = i2->getModMRSize();
        sibSize = i2->getSibSize();
        dispSize = i2->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (i1 && r2) {
        op1 = (operandSize == bit_8) ? 0x8A : 0x8B;
        modrmSize = i1->getModMRSize();
        sibSize = i1->getSibSize();
        dispSize = i1->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    return 0;
}
