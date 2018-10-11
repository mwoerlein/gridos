#include "I386ASM/Instruction/Inline.hpp"

// protected
size_t Inline::approximateSizeInBytes(BitWidth data, BitWidth addr, BitWidth mode) {
    return (int) operandSize;
}

void Inline::checkOperands() {
    if (!o1) {
        list->err<<"Missing value!\n";
    }
    if (o2) {
        list->err<<"Unexpected operand: " << *o2 << '\n';
    }
    if (o3) {
        list->err<<"Unexpected operand: " << *o3 << '\n';
    }
    if (operandSize == bit_auto) {
        list->err<<"Missing operand size!\n";
    }
}

void Inline::validateOperands() {
    if (Number *n1 = o1->as<Number>(number)) {
        BitWidth nw = getUnsignedBitWidth(n1->value());
        if ((int) nw > (int) operandSize) {
            list->err<<"value '"<<n1->value()<<"' does not match "<<(operandSize*8)<<" bit operand size\n";
        }
        return;
    }
    list->err<<"unsupported operands in \""<<*this<<"\"\n";
}

size_t Inline::compileOperands(BitWidth data, BitWidth addr, BitWidth mode) {
    if (Number *n1 = o1->as<Number>(number)) {
        immSize = (int) operandSize;
        return immSize;
    }
    return -1;
}

void Inline::writeToStream(OStream & stream) {
    writeOperandsToStream(stream);
}

void Inline::writeOperandsToStream(OStream & stream) {
    writeImmediateToStream(stream, o1);
}

OStream & Inline::operator >>(OStream & stream) {
    switch (operandSize) {
        case bit_8:  stream << ".byte "; break;
        case bit_16: stream << ".word "; break;
        case bit_32: stream << ".long "; break;
    }
    return stream << *o1;
}
