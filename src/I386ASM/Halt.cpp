#include "I386ASM/Halt.hpp"

// public
int Halt::getSizeInByte() {
    return 1;
}

void Halt::writeToStream(OStream & stream) {
    stream<<(char)0xf4; //hlt
}
