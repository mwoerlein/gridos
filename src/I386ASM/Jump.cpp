#include "I386ASM/Jump.hpp"

// public
size_t Jump::getSizeInBytes() {
    return 2;
}

void Jump::writeToStream(OStream & stream) {
    stream
        <<(char)0xeb // jmp
        <<(char)0xfd // -3
    ;
}
