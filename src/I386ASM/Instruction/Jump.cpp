#include "I386ASM/Instruction/Jump.hpp"

#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/ASMInstructionList.hpp"


// protected
void Jump::writeOperandsToStream(OStream & stream) {
    Identifier *i1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    if (i1) {
        // Reached only for labels. Definitions will be rewritten to numbers before.
        int offset = list->getLabel(i1->identifier()) - (pos + size);
        writeNumberToStream(stream, offset, immSize);
    }
    if (n1) {
        writeNumberToStream(stream, n1->value() - (pos + size), immSize);
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
    Identifier *i1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    
    if (i1) {
        String & identifier = i1->identifier();
        if (list->hasLabel(i1->identifier()) || list->hasDefinition(i1->identifier())) {
            return true;
        }
        err<<"Unknown identifier: " << identifier << '\n';
        return false;
    }
    if (n1) {
        return true;
    } else {
        err<<"Invalid operand: " << *o1 << '\n';
        return false;
    }
    
    return true;
}

size_t Jump::determineOpcodeAndSize(OStream &err) {
    Identifier *i1 = o1->as<Identifier>(id);
    if (i1) {
        String & identifier = i1->identifier();
        if (list->hasDefinition(identifier)) {
            o1 = &list->getDefinition(identifier);
        } else { // label
            int offset = pos - list->getLabel(identifier);
            if (-128 <= offset && offset <= 127) {
                op1 = 0xEB;
                immSize = 1;
            } else {
                op1 = 0xE9;
                immSize = 4;
            }
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
    }
    
    return 1 + immSize;
}

size_t Jump::getMaxSizeInBytes() {
    return 5; // opcode + immediate
}
