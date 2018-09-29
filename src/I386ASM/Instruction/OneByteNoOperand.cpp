#include "I386ASM/Instruction/OneByteNoOperand.hpp"

// protected
void OneByteNoOperand::writeOperandsToStream(OStream &stream) {}

bool OneByteNoOperand::validateOperandsAndOperandSize(OStream &err) {
    if (o1) {
        err<<"Unexpected operand: " << *o1 << '\n';
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
    return true;
}

size_t OneByteNoOperand::determineOpcodeAndSize(OStream &err) {
    return 1;
}

size_t OneByteNoOperand::getMaxSizeInBytes() {
    return 1;
}
