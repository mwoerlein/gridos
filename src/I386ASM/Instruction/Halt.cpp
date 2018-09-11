#include "I386ASM/Instruction/Halt.hpp"

// public
size_t Halt::getSizeInBytes() {
    return 1;
}

void Halt::writeToStream(OStream & stream) {
    stream<<(char)0xf4; //hlt
}

// protected
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
    if (os != automatic) {
        err<<"Invalid operand size!\n";
        return false;
    }
    return true;
}

bool Halt::determineOpcodeAndSize(OStream &err) {
    return true;
}
