#include "I386ASM/ASMInstruction.hpp"

// public
OStream & operator << (OStream & out, ASMInstruction &instruction) {
    instruction.logToStream(out);
    return out;
}

bool ASMInstruction::prepare(OStream & err) {
    if (!validateOperandsAndOperandSize(err)) {
        return false;
    }
    size = determineOpcodeAndSize(err);
    if (!size) {
        return false;
    }
    return true;
}
