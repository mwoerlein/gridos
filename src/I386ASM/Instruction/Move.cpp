#include "I386ASM/Instruction/Move.hpp"

#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Indirect.hpp"

#define ModRM(mod,regO,regM) ((char) ((((mod)&0x3)<<6) + (((regO)&0x7)<<3) + (((regM)&0x7)))) 

// public
void Move::writeToStream(OStream & stream) {
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    if (pre1) { stream << pre1; }
    if (pre2) { stream << pre2; }
    if (pre3) { stream << pre3; }
    if (pre4) { stream << pre4; }
    stream << op1;
    if (op1 == 0x0F) {
        stream << op2;
        if (op2 == 0x38 || op2 == 0x3A) {
            stream << op3;
        }
    }
    if (n1 && r2) {
        writeNumber(stream, n1->value(), immSize);
    }
    if (n1 && i2) {
        if (modrmSize) {
            stream << i2->getModMR(0);
        }
        if (sibSize) {
            stream << i2->getSib();
        }
        if (dispSize) {
            writeNumber(stream, i2->getDispValue(), dispSize);
        }
        writeNumber(stream, n1->value(), immSize);
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
            writeNumber(stream, i2->getDispValue(), dispSize);
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
            writeNumber(stream, i1->getDispValue(), dispSize);
        }
    }
}

// protected
bool Move::validateOperandsAndOperandSize(OStream &err) {
    return true;
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
    err<<"unsupported operands in "<<*this<<'\n';
    return 0;
}
