#include "I386ASM/ASMInstruction.hpp"

// public
OStream & operator << (OStream & out, ASMInstruction &instruction) {
    instruction.logToStream(out);
    return out;
}
