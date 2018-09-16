#include "I386ASM/Instruction/Add.hpp"

#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Indirect.hpp"

// public
void Add::writeToStream(OStream & stream) {
    if (Number *n = o1->as<Number>(number)) {
        if (Register *r = o2->as<Register>(reg)) {
            stream << op1;
            writeNumber(stream, n->value(), immSize);
        }
    }
}

// protected
bool Add::validateOperandsAndOperandSize(OStream &err) {
    return true;
}

size_t Add::determineOpcodeAndSize(OStream &err) {
    op1 = 0x05; // addl eax
    immSize = (int) operandSize;
    return 1 + immSize;
}
