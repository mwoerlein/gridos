#include "I386ASM/Instruction/Add.hpp"

#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Indirect.hpp"

// protected
size_t Add::approximateSizeInBytes() {
    // TODO: validate and determine more variants
    immSize = (int) operandSize;
    return 1 + immSize;
}

void Add::validateOperands() {
    // TODO: validate and determine more variants
    Number *n1 = o1->as<Number>(number);
    Register *r2 = o2->as<Register>(reg);
    
    if (n1 && r2) {
        if (*r2 != reg_eax) {
            list->err<<"unsupported register in \""<<*this<<"\"\n";
        }
        return;
    }
    list->err<<"unsupported operands in \""<<*this<<"\"\n";
}

size_t Add::compileOperands() {
    // TODO: validate and determine more variants
    op1 = 0x05; // addl eax
    immSize = (int) operandSize;
    return 1 + immSize;
}

void Add::writeOperandsToStream(OStream & stream) {
    Number *n1 = o1->as<Number>(number);
    Register *r2 = o2->as<Register>(reg);
    
    if (n1 && r2) {
        writeNumberToStream(stream, n1->value(), immSize);
    }
}
