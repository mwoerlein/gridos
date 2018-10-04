#include "I386ASM/Instruction/Jump.hpp"

// protected
size_t Jump::approximateSizeInBytes() {
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    if (id1 || n1) {
        return 5; // opcode + immediate
    }
    Register *r1 = o1->as<Register>(reg);
    if (r1) {
        return 2; // opcode + modmr
    }
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (i1) {
        size_t size = 1; // opcode
        size += i1->getModRMSize();
        size += i1->getSibSize();
        size += i1->getDispSize();
        return size;
    }
    return 7; // all over maximum
}

void Jump::checkOperands() {
    if (!o1) {
        list->err<<"Missing operand!\n";
    }
    if (o2) {
        list->err<<"Unexpected operand: " << *o2 << '\n';
    }
    if (o3) {
        list->err<<"Unexpected operand: " << *o3 << '\n';
    }
    if (operandSize != bit_auto) {
        list->err<<"Invalid operand size!\n";
    }
}

void Jump::validateOperands() {
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    
    if (id1 || n1 || i1) {
        return;
    }
    if (r1) {
        if (r1->kind() != reg_general) {
            list->err<<"Invalid register: " << *o1 << '\n';
        }
        return;
    }
    list->err<<"Invalid operand: " << *o1 << '\n';
    return;
}

size_t Jump::compileOperands() {
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (id1) {
        size_t size = 1;
        BitWidth offsetWidth = approximateOffsetWidth(id1); 
        switch (offsetWidth) {
            case bit_8:
                op1 = 0xEB;
                break;
            case bit_16:
                pre3 = 0x66;
                size++;
                // fallthrough
            default:
                op1 = 0xE9;
        }
        immSize = (int) offsetWidth;
        return size + immSize;
    }
    if (n1) {
        // Offset of explicit address cannot be determined before final positioning in ASMInstructionList::finalize
        op1 = 0xE9;
        immSize = (int) bit_32;
        return 1 + immSize;
    }
    if (r1) {
        op1 = 0xFF;
        modrmSize = 1;
        return 1 + modrmSize;
    }
    if (i1) {
        op1 = 0xFF;
        useIndirectSizes(i1);
        return 1 + modrmSize + sibSize + dispSize;
    }
        
    return 0;
}

void Jump::writeOperandsToStream(OStream & stream) {
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (immSize) {
        writeOffsetToStream(stream, o1);
    }
    if (r1) {
        writeModRMToStream(stream, 4, r1);
    }
    if (i1) {
        writeIndirectToStream(stream, i1, 4);
    }
}
