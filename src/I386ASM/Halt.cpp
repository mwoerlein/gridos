#include "I386ASM/Halt.hpp"

// public
size_t Halt::getSizeInBytes() {
    return 1;
}

void Halt::writeToStream(OStream & stream) {
    stream<<(char)0xf4; //hlt
}
