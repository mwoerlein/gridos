#include "I386ASM/Instruction/NoOperandInstruction.hpp"

// public
NoOperandInstruction::NoOperandInstruction(Environment &env, MemoryInfo &mi, const char * mnemonic, char opCode1, char opCode2, char opCode3)
        :ASMInstruction(env, mi, mnemonic), Object(env, mi) {
    op1 = opCode1;
    op2 = opCode2;
    op3 = opCode3;
}
NoOperandInstruction::~NoOperandInstruction() {}

// protected
size_t NoOperandInstruction::approximateSizeInBytes() {
    if (op1 == 0x0F) {
        if (op2 == 0x38 || op2 == 0x3A) {
            return 3;
        }
        return 2;
    }
    return 1;
}

void NoOperandInstruction::checkOperands() {
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

size_t NoOperandInstruction::compileOperands() {
    return approximateSizeInBytes();
}

void NoOperandInstruction::writeOperandsToStream(OStream &stream) {}
