#include "I386ASM/Jump.hpp"

// public
int Jump::getSizeInByte() {
    return 2;
}

void Jump::writeToStream(OStream & stream) {
    stream
        <<(char)0xeb // jmp
        <<(char)0xfd // -3
    ;
}
