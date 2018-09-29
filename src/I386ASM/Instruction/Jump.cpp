#include "I386ASM/Instruction/Jump.hpp"

#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"

// protected
void Jump::writeOperandsToStream(OStream & stream) {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (id1) {
        // Reached only for labels. Definitions will be rewritten to numbers before.
        int offset = list->getLabel(id1->identifier()) - (pos + size);
        writeNumberToStream(stream, offset, immSize);
    }
    if (n1) {
        writeNumberToStream(stream, n1->value() - (pos + size), immSize);
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
            writeNumberToStream(stream, i1->getDispValue(), dispSize);
        }
    }
}

bool Jump::validateOperandsAndOperandSize(OStream &err) {
    if (!o1) {
        err<<"Missing operand!\n";
        return false;
    }
    if (o2) {
        err<<"Unexpected operand: " << *o2 << '\n';
        return false;
    }
    if (o3) {
        err<<"Unexpected operand: " << *o3 << '\n';
        return false;
    }
    if (operandSize != bit_auto) {
        err<<"Invalid operand size!\n";
        return false;
    }
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    
    if (id1) {
        String & identifier = id1->identifier();
        if (list->hasLabel(identifier) || list->hasDefinition(identifier)) {
            return true;
        }
        err<<"Unknown identifier: " << identifier << '\n';
        return false;
    }
    if (n1) {
        return true;
    }
    if (r1) {
        if (r1->kind() != reg_general) {
            err<<"Invalid register: " << *o1 << '\n';
            return false;
        }
        return true;
    }
    if (i1) {
        // TODO: validate indirect registers?
        return true;
    }
    err<<"Invalid operand: " << *o1 << '\n';
    return false;
}

size_t Jump::determineOpcodeAndSize(OStream &err) {
    Identifier *id1 = o1->as<Identifier>(id);
    Register *r1 = o1->as<Register>(reg);
    Indirect *i1 = o1->as<Indirect>(indirect);
    if (id1) {
        String & identifier = id1->identifier();
        if (list->hasDefinition(identifier)) {
            o1 = &list->cloneNumber(identifier);
            id1->destroy();
        } else { // label
            int offset = pos - list->getLabel(identifier);
            if (-128 <= offset && offset <= 127) {
                op1 = 0xEB;
                immSize = 1;
            } else {
                op1 = 0xE9;
                immSize = 4;
            }
        return 1 + immSize;
        }
    }
    Number *n1 = o1->as<Number>(number);
    if (n1) {
        int offset = pos - n1->value();
        if (-128 <= offset && offset <= 127) {
            op1 = 0xEB;
            immSize = 1;
        } else {
            op1 = 0xE9;
            immSize = 4;
        }
        return 1 + immSize;
    }
    if (r1) {
        op1 = 0xFF;
        modrmSize = 1;
        return size + 1 + modrmSize;
    }
    if (i1) {
        op1 = 0xFF;
        modrmSize = i1->getModMRSize();
        sibSize = i1->getSibSize();
        dispSize = i1->getDispSize();
        return size + 1 + modrmSize + sibSize + dispSize + immSize;
    }
        
    return 0;
}

size_t Jump::getMaxSizeInBytes() {
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
    return 7;
}
