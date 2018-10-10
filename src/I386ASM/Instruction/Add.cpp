#include "I386ASM/Instruction/Add.hpp"

// protected
size_t Add::approximateSizeInBytes() {
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    size_t size = 2; //opcode, modrm
    if (operandSize == bit_16) {
        size++;
    }
    
    if (addrSize == bit_16) {
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

void Add::checkOperands() {
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
    
    if (operandSize == bit_auto) {
        if (r1) {
            BitWidth newSize = r1->getOperandSize();
            if (r2) {
                if (newSize != r2->getOperandSize()) {
                    list->err<<"ambigious operand sizes in \""<<*this<<"\"\n";
                }
            }
            operandSize = newSize;
        } else if (r2) {
            operandSize = r2->getOperandSize();
        } else {
            list->err<<"missing operand size and no general purpose register to determine from in \""<<*this<<"\"\n";
        }
    }
}

void Add::validateOperands() {
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    if (r1) {
        if (r1->kind() != reg_general) {
            list->err<<"Invalid register: " << *o1 << '\n';
        }
        r1->validate(*list, operandSize);
    }
    if (r2) {
        if (r2->kind() != reg_general) {
            list->err<<"Invalid register: " << *o2 << '\n';
        }
        r2->validate(*list, operandSize);
    }
    if (list->hasErrors()) return;
    
    if ((n1 || id1) && (r2 || i2)) {
        return;
    }
    if (r1 && (r2 || i2)) {
        return;
    }
    if (i1 && r2) {
        return;
    }
    list->err<<"unsupported operands in \""<<*this<<"\"\n";
}

size_t Add::compileOperands() {
    size_t size = 0;
    Identifier *id1 = o1->as<Identifier>(identifier);
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
    
    if ((n1 || id1) && (r2 || i2)) {
        immSize = (int) operandSize;
        if (r2 && (r2->getOpCodeRegister() == 0 /*al, ax, eax*/)) {
            op1 = (operandSize == bit_8) ? 0x04 : 0x05;
            return size + 1 + immSize;
        }
        if (operandSize == bit_8) {
            op1 = 0x80;
        } else {
            op1 = 0x81;
            if (n1 && (getBitWidth(n1->value()) == bit_8)) {
                op1 = 0x83;
                immSize = (int) bit_8;
            }
        }
        modrmSize = 1;
        if (i2) { useIndirectSizes(i2); }
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
    if (r1 && (r2 || i2)) {
        op1 = (operandSize == bit_8) ? 0x00 : 0x01;
        modrmSize = 1;
        if (i2) { useIndirectSizes(i2); }
        return size + 1 + modrmSize + sibSize + dispSize;
    }
    if (i1 && r2) {
        op1 = (operandSize == bit_8) ? 0x02 : 0x03;
        useIndirectSizes(i1);
        return size + 1 + modrmSize + sibSize + dispSize;
    }
    return -1;
}

void Add::writeOperandsToStream(OStream & stream) {
    Register *r1 = o1->as<Register>(reg);
    Register *r2 = o2->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    Indirect *i2 = o2->as<Indirect>(indirect);
    
    if (immSize) {
        if (r2) {
            writeModRMToStream(stream, 0, r2);
        }
        if (i2) {
            writeIndirectToStream(stream, i2, 0);
        }
        writeImmediateToStream(stream, o1);
    }
    if (r1 && r2) {
        writeModRMToStream(stream, r1, r2);
    }
    if (r1 && i2) {
        writeIndirectToStream(stream, i2, r1);
    }
    if (i1 && r2) {
        writeIndirectToStream(stream, i1, r2);
    }
}
