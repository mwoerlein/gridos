#include "I386ASM/ASMInstruction.hpp"

#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Number.hpp"

// public
OStream & operator << (OStream & out, ASMInstruction &instruction) {
    instruction.logToStream(out);
    return out;
}

void ASMInstruction::logToStream(OStream &stream) {
    stream << mnemonic;
    switch (operandSize) {
        case bit_8: stream << 'b'; break;
        case bit_16: stream << 'w'; break;
        case bit_32: stream << 'l'; break;
    }
    if (o1) {
        stream << ' ' << *o1;
    }
    if (o2) {
        stream << ", " << *o2;
    }
    if (o3) {
        stream << ", " << *o3;
    }
}

void ASMInstruction::writeToStream(OStream & stream) {
    if (pre1) { stream << pre1; }
    if (pre2) { stream << pre2; }
    if (pre3) { stream << pre3; }
    if (pre4) { stream << pre4; }
    stream << op1;
    if (op1 == 0x0F) {
        stream << op2;
        if (op2 == 0x38 || op2 == 0x3A) {
            stream << op3;
        }
    }
    writeOperandsToStream(stream);
}

// protected
void ASMInstruction::checkOperands() {}

void ASMInstruction::sanitizeOperands() {
    if (ASMOperand * replacement = o1 ? o1->validateAndReplace(*list) : 0) {
        o1->destroy();
        o1 = replacement;
    }
    if (ASMOperand * replacement = o2 ? o2->validateAndReplace(*list) : 0) {
        o2->destroy();
        o2 = replacement;
    }
    if (ASMOperand * replacement = o3 ? o3->validateAndReplace(*list) : 0) {
        o3->destroy();
        o3 = replacement;
    }
}

void ASMInstruction::validateOperands() {}

size_t ASMInstruction::compile() {
    checkOperands();
    if (list->hasErrors()) return 0;
    
    sanitizeOperands();
    if (list->hasErrors()) return 0;
    
    validateOperands();
    if (list->hasErrors()) return 0;
    
    size = compileOperands();
    if (!size) {
        list->err<<"invalid opcode size determined for \""<<*this<<"\"\n";
    }
    return size;
}

void ASMInstruction::writeNumberToStream(OStream &stream, int val, int size) {
    switch (size) {
        case 1: stream << (char)val; break;
        case 2: stream << (char)val << (char)(val>>8); break;
        case 4: stream << (char)val << (char)(val>>8) << (char)(val>>16) << (char)(val>>24); break;
    }
}
