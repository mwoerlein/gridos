#include "I386ASM/Instruction/OneByteNoOperand.hpp"

// protected
void OneByteNoOperand::writeOperandsToStream(OStream &stream) {}

void OneByteNoOperand::validateOperandsAndOperandSize() {
    if (o1) {
        list->err<<"Unexpected operand: " << *o1 << '\n';
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

size_t OneByteNoOperand::determineOpcodeAndSize() {
    return 1;
}

size_t OneByteNoOperand::getMaxSizeInBytes() {
    return 1;
}
