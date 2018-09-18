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
    Register *gr1 = (r1 && (r1->kind() == reg_general)) ? r1 : 0;
    Register *gr2 = (r2 && (r2->kind() == reg_general)) ? r2 : 0;
    Register *sr1 = (r1 && (r1->kind() == reg_segment)) ? r1 : 0;
    Register *sr2 = (r2 && (r2->kind() == reg_segment)) ? r2 : 0;
    
    if (n1 && gr2) {
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
    if (gr1 && gr2) {
        stream << ModRM(3, gr1->getOpCodeRegister(), gr2->getOpCodeRegister());
    }
    if (gr1 && i2) {
        if (modrmSize) {
            stream << i2->getModMR(gr1->getOpCodeRegister());
        }
        if (sibSize) {
            stream << i2->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i2->getDispValue(), dispSize);
        }
    }
    if (i1 && gr2) {
        if (modrmSize) {
            stream << i1->getModMR(gr2->getOpCodeRegister());
        }
        if (sibSize) {
            stream << i1->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i1->getDispValue(), dispSize);
        }
    }
    if (gr1 && sr2) {
        stream << ModRM(3, sr2->getOpCodeRegister(), gr1->getOpCodeRegister());
    }
    if (i1 && sr2) {
        if (modrmSize) {
            stream << i1->getModMR(sr2->getOpCodeRegister());
        }
        if (sibSize) {
            stream << i1->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i1->getDispValue(), dispSize);
        }
    }
    if (sr1 && gr2) {
        stream << ModRM(3, sr1->getOpCodeRegister(), gr2->getOpCodeRegister());
    }
    if (sr1 && i2) {
        if (modrmSize) {
            stream << i2->getModMR(sr1->getOpCodeRegister());
        }
        if (sibSize) {
            stream << i2->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i2->getDispValue(), dispSize);
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
    Register *gr1 = (r1 && (r1->kind() == reg_general)) ? r1 : 0;
    Register *gr2 = (r2 && (r2->kind() == reg_general)) ? r2 : 0;
    Register *sr1 = (r1 && (r1->kind() == reg_segment)) ? r1 : 0;
    Register *sr2 = (r2 && (r2->kind() == reg_segment)) ? r2 : 0;
    
    if (operandSize == bit_auto) {
        if (gr1) {
            BitWidth newSize = gr1->getOperandSize();
            if (gr2) {
                if (newSize != gr2->getOperandSize()) {
                    err<<"ambigious operand size in \""<<*this<<"\"\n";
                    return false;
                }
            }
            operandSize = newSize;
        } else if (gr2) {
            operandSize = gr2->getOperandSize();
        } else if (sr1) {
            operandSize = sr1->getOperandSize();
        } else if (sr2) {
            operandSize = sr2->getOperandSize();
        } else {
            err<<"missing operand size and no general purpose register to determine from in \""<<*this<<"\"\n";
            return false;
        }
    }
    
    if (gr1) {
        valid &= gr1->validate(err, operandSize);
    }
    if (gr2) {
        valid &= gr2->validate(err, operandSize);
    }
    if (!valid) {
        return valid;
    }
    
    if (n1 && gr2) {
        return true;
    }
    if (n1 && i2) {
        return true;
    }
    if (gr1 && gr2) {
        return true;
    }
    if (gr1 && i2) {
        return true;
    }
    if (i1 && gr2) {
        return true;
    }
    if (gr1 && sr2) {
        return true;
    }
    if (i1 && sr2) {
        if (operandSize != bit_16) {
            err<<"invalid operand size in \""<<*this<<"\"\n";
            return false;
        }
        return true;
    }
    if (sr1 && gr2) {
        return true;
    }
    if (sr1 && i2) {
        if (operandSize != bit_16) {
            err<<"invalid operand size in \""<<*this<<"\"\n";
            return false;
        }
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
    Register *gr1 = (r1 && (r1->kind() == reg_general)) ? r1 : 0;
    Register *gr2 = (r2 && (r2->kind() == reg_general)) ? r2 : 0;
    Register *sr1 = (r1 && (r1->kind() == reg_segment)) ? r1 : 0;
    Register *sr2 = (r2 && (r2->kind() == reg_segment)) ? r2 : 0;
    
    if (operandSize == bit_16) {
        pre3 = 0x66;
        size++;
    }
    
    if (addrSize == bit_16) {
        pre4 = 0x67;
        size++;
    }
    
    if (n1 && gr2) {
        immSize = (int) operandSize;
        op1 = (operandSize == bit_8) ? 0xB0 : 0xB8;
        op1 += gr2->getOpCodeRegister();
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
    if (gr1 && gr2) {
        op1 = (operandSize == bit_8) ? 0x88 : 0x89;
        modrmSize = 1;
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (gr1 && i2) {
        op1 = (operandSize == bit_8) ? 0x88 : 0x89;
        modrmSize = i2->getModMRSize();
        sibSize = i2->getSibSize();
        dispSize = i2->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (i1 && gr2) {
        op1 = (operandSize == bit_8) ? 0x8A : 0x8B;
        modrmSize = i1->getModMRSize();
        sibSize = i1->getSibSize();
        dispSize = i1->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (gr1 && sr2) {
        op1 = 0x8E;
        modrmSize = 1;
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (i1 && sr2) {
        pre3 = 0; size--; // segment register implicit use 16 bit 
        op1 = 0x8E;
        modrmSize = i1->getModMRSize();
        sibSize = i1->getSibSize();
        dispSize = i1->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (sr1 && gr2) {
        op1 = 0x8C;
        modrmSize = 1;
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (sr1 && i2) {
        pre3 = 0; size--; // segment register implicit use 16 bit 
        op1 = 0x8C;
        modrmSize = i2->getModMRSize();
        sibSize = i2->getSibSize();
        dispSize = i2->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    return 0;
}
