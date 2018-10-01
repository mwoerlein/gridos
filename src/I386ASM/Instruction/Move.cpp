#include "I386ASM/Instruction/Move.hpp"

#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"

// protected
void Move::writeOperandsToStream(OStream & stream) {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    Register *gr1 = (r1 && (r1->kind() == reg_general)) ? r1 : 0;
    Register *gr2 = (r2 && (r2->kind() == reg_general)) ? r2 : 0;
    Register *sr1 = (r1 && (r1->kind() == reg_segment)) ? r1 : 0;
    Register *sr2 = (r2 && (r2->kind() == reg_segment)) ? r2 : 0;
    
    if (n1 || id1) {
        // Reached only for labels. Definitions will be rewritten to numbers before.
        int val = n1 ? n1->value() : list->getLabel(id1->identifier());
        if (gr2) {
            writeNumberToStream(stream, val, immSize);
        }
        if (i2) {
            if (modrmSize) {
                stream << i2->getModMR(0);
            }
            if (sibSize) {
                stream << i2->getSib();
            }
            if (dispSize) {
                writeNumberToStream(stream, i2->getDispValue(*list), dispSize);
            }
            writeNumberToStream(stream, val, immSize);
        }
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
            writeNumberToStream(stream, i2->getDispValue(*list), dispSize);
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
            writeNumberToStream(stream, i1->getDispValue(*list), dispSize);
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
            writeNumberToStream(stream, i1->getDispValue(*list), dispSize);
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
            writeNumberToStream(stream, i2->getDispValue(*list), dispSize);
        }
    }
}

void Move::checkArguments() {
    if (!o1) {
        list->err<<"Missing source!\n";
    }
    if (!o2) {
        list->err<<"Missing destination!\n";
    }
    if (o3) {
        list->err<<"Unexpected operand: " << *o3 << '\n';
    }
    if (list->hasErrors()) return;
    
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Register *gr1 = (r1 && (r1->kind() == reg_general)) ? r1 : 0;
    Register *gr2 = (r2 && (r2->kind() == reg_general)) ? r2 : 0;
    Register *sr1 = (r1 && (r1->kind() == reg_segment)) ? r1 : 0;
    Register *sr2 = (r2 && (r2->kind() == reg_segment)) ? r2 : 0;
    
    if (operandSize == bit_auto) {
        if (gr1) {
            BitWidth newSize = gr1->getOperandSize();
            if (gr2) {
                if (newSize != gr2->getOperandSize()) {
                    list->err<<"ambigious operand sizes in \""<<*this<<"\"\n";
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
            list->err<<"missing operand size and no general purpose register to determine from in \""<<*this<<"\"\n";
        }
    }
}

void Move::validateOperandsAndOperandSize() {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    Register *gr1 = (r1 && (r1->kind() == reg_general)) ? r1 : 0;
    Register *gr2 = (r2 && (r2->kind() == reg_general)) ? r2 : 0;
    Register *sr1 = (r1 && (r1->kind() == reg_segment)) ? r1 : 0;
    Register *sr2 = (r2 && (r2->kind() == reg_segment)) ? r2 : 0;
    
    if (gr1) {
        gr1->validate(*list, operandSize);
    }
    if (gr2) {
        gr2->validate(*list, operandSize);
    }
    if (list->hasErrors()) return;
    
    if ((n1 || id1) && gr2) {
        return;
    }
    if ((n1 || id1) && i2) {
        return;
    }
    if (gr1 && gr2) {
        return;
    }
    if (gr1 && i2) {
        return;
    }
    if (i1 && gr2) {
        return;
    }
    if (gr1 && sr2) {
        return;
    }
    if (i1 && sr2) {
        if (operandSize != bit_16) {
            list->err<<"invalid operand size in \""<<*this<<"\"\n";
        }
        return;
    }
    if (sr1 && gr2) {
        return;
    }
    if (sr1 && i2) {
        if (operandSize != bit_16) {
            list->err<<"invalid operand size in \""<<*this<<"\"\n";
        }
        return;
    }
    list->err<<"unsupported operands in \""<<*this<<"\"\n";
}

size_t Move::determineOpcodeAndSize() {
    size_t size = 0;
    Identifier *id1 = o1->as<Identifier>(id);
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
    
    if (id1 && list->hasDefinition(id1->identifier())) {
        o1 = n1 = &list->cloneNumber(id1->identifier());
        id1->destroy();
        id1 = 0;
    }
    
    if ((n1 || id1) && gr2) {
        immSize = (int) operandSize;
        op1 = (operandSize == bit_8) ? 0xB0 : 0xB8;
        op1 += gr2->getOpCodeRegister();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if ((n1 || id1) && i2) {
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
        if (i2->isOffset() && (gr1->getOpCodeRegister() == 0 /*al, ax, eax*/)) {
            op1 = (operandSize == bit_8) ? 0xA2 : 0xA3;
            dispSize = (int) addrSize;
            return size + 1 + modrmSize + sibSize + dispSize + immSize;
        }
        op1 = (operandSize == bit_8) ? 0x88 : 0x89;
        modrmSize = i2->getModMRSize();
        sibSize = i2->getSibSize();
        dispSize = i2->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (i1 && gr2) {
        if (i1->isOffset() && (gr2->getOpCodeRegister() == 0 /*al, ax, eax*/)) {
            op1 = (operandSize == bit_8) ? 0xA0 : 0xA1;
            dispSize = (int) addrSize;
            return size + 1 + modrmSize + sibSize + dispSize + immSize;
        }
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

size_t Move::getMaxSizeInBytes() {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    size_t size = 2; //opcode, modrm
    if (operandSize == bit_16) {
        pre3 = 0x66;
        size++;
    }
    
    if (addrSize == bit_16) {
        pre4 = 0x67;
        size++;
    }
    if (n1 || id1) {
        size += (operandSize == bit_auto) ? (int) bit_32 : (int) operandSize;
    }
    if (i1) {
        size += i1->getSibSize();
        size += i1->getDispSize();
    } 
    if (i2) {
        size += i2->getSibSize();
        size += i2->getDispSize();
    }
    return size;
}
