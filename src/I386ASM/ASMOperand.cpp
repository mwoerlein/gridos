#include "I386ASM/ASMOperand.hpp"

// public
OStream & operator << (OStream & out, ASMOperand &operand) {
    operand.logToStream(out);
    return out;
}
