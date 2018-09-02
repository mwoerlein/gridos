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
