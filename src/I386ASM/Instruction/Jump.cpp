#include "I386ASM/Instruction/Jump.hpp"

// public
size_t Jump::getSizeInBytes() {
    return 2;
}

void Jump::writeToStream(OStream & stream) {
    if (Number *n = o1->as<Number>(number)) {
        stream
            <<(char)0xeb // jmp
            <<(char)n->value()
        ;
    }
}

// protected
bool Jump::validateOperandsAndOperandSize(OStream &err) {
    if (!o1) {
        err<<"Missing operand!\n";
        return false;
    }
    if (Number *n = o1->as<Number>(number)) {
        int val = n->value();
        if (-128 <= val && val <= 127) {
            return true;
        }
        err<<"Invalid short jmp destination: "<<val<<'\n';
        return false;
    } else {
        err<<"Invalid operand: " << *o1 << '\n';
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

bool Jump::determineOpcodeAndSize(OStream &err) {
    return true;
}
