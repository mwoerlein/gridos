#include "I386ASM/Instruction/Jump.hpp"

#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"

// protected
size_t Jump::approximateSizeInBytes() {
    Identifier *id1 = o1->as<Identifier>(id);
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
        size += i1->getModMRSize();
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
    Identifier *id1 = o1->as<Identifier>(id);
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
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (id1) {
        size_t size = 1;
        int offset = pos - list->getLabel(id1->identifier());
        if (-128 <= offset && offset <= 127) {
            op1 = 0xEB;
            immSize = (int) bit_8;
        } else if (-32768 <= offset && offset <= 32767) {
            pre3 = 0x66;
            size++;
            op1 = 0xE9;
            immSize = (int) bit_16;
        } else {
            op1 = 0xE9;
            immSize = (int) bit_32;
        }
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
        modrmSize = i1->getModMRSize();
        sibSize = i1->getSibSize();
        dispSize = i1->getDispSize();
        return 1 + modrmSize + sibSize + dispSize;
    }
        
    return 0;
}

void Jump::writeOperandsToStream(OStream & stream) {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (n1 || id1) {
        // Reached only for labels. Definitions will be rewritten to numbers before.
        int val = n1 ? n1->value() : list->getLabel(id1->identifier());
        writeNumberToStream(stream, val - (pos + size), immSize);
    }
    if (r1) {
        stream << ModRM(3, 4, r1->getOpCodeRegister());
    }
    if (i1) {
        if (modrmSize) {
            stream << i1->getModMR(4);
        }
        if (sibSize) {
            stream << i1->getSib();
        }
        if (dispSize) {
            writeNumberToStream(stream, i1->getDispValue(*list), dispSize);
        }
    }
}
