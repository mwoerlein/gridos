#include "I386ASM/Instruction/Halt.hpp"

// protected
void Halt::writeOperandsToStream(OStream &stream) {}

bool Halt::validateOperandsAndOperandSize(OStream &err) {
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

size_t Halt::determineOpcodeAndSize(OStream &err) {
    op1 = 0xF4;
    return 1;
}
