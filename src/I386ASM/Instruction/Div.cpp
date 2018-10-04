#include "I386ASM/Instruction/Div.hpp"

// protected
size_t Div::approximateSizeInBytes() {
    Indirect *i1 = o1->as<Indirect>(indirect);
    
    size_t size = 2; //opcode, modrm
    if (operandSize == bit_16) {
        size++;
    }
    
    if (addrSize == bit_16) {
        size++;
    }
    
    if (i1) {
        size += i1->getSibSize();
        size += i1->getDispSize();
    } 
    return 1;
}

void Div::checkOperands() {
    if (!o1) {
        list->err<<"Missing operand!\n";
    }
    if (o2) {
        list->err<<"Unexpected operand: " << *o2 << '\n';
    }
    if (o3) {
        list->err<<"Unexpected operand: " << *o3 << '\n';
    }
    if (list->hasErrors()) return;
    
    if (operandSize == bit_auto) {
        if (Register *r1 = o1->as<Register>(reg)) {
            operandSize = r1->getOperandSize();
        } else {
            list->err<<"missing operand size and no general purpose register to determine from in \""<<*this<<"\"\n";
        }
    }
}

void Div::validateOperands() {
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    
    if (r1) {
        if (r1->kind() != reg_general) {
            list->err<<"Invalid register: " << *o1 << '\n';
        }
        r1->validate(*list, operandSize);
        return;
    }
    if (i1) {
        return;
    }
    
    list->err<<"Invalid operand: " << *o1 << '\n';
    return;
}

size_t Div::compileOperands() {
    size_t size = 0;
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    
    if (operandSize == bit_16) {
        pre3 = 0x66;
        size++;
    }
    
    if (addrSize == bit_16) {
        pre4 = 0x67;
        size++;
    }
    
    if (r1) {
        op1 = (operandSize == bit_8) ? 0xF6 : 0xF7;
        modrmSize = 1;
        return size + 1 + modrmSize;
    }
    if (i1) {
        op1 = (operandSize == bit_8) ? 0xF6 : 0xF7;
        useIndirectSizes(i1);
        return size + 1 + modrmSize + sibSize + dispSize;
    }
    
    return 0;
}

void Div::writeOperandsToStream(OStream & stream) {
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (r1) {
        stream << ModRM(3, 6, r1->getOpCodeRegister());
    }
    if (i1) {
        writeIndirectToStream(stream, i1, 6);
    }
}
