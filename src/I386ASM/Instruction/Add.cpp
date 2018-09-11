#include "I386ASM/Instruction/Add.hpp"

#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Indirect.hpp"

// public
size_t Add::getSizeInBytes() {
    return 5;
}

void Add::writeToStream(OStream & stream) {
    if (Number *n = o1->as<Number>(number)) {
        int val = n->value();
        if (Register *r = o2->as<Register>(reg)) {
            stream
                <<(char)0x05 // addl eax
                <<(char)val
                <<(char)(val>>8)
                <<(char)(val>>16)
                <<(char)(val>>24)
            ;
        }
    }
}

// protected
bool Add::validateOperandsAndOperandSize(OStream &err) {
    return true;
}

bool Add::determineOpcodeAndSize(OStream &err) {
    return true;
}

/*
00000000 <.data>:
   0:	b8 00 8f 0b 00       	mov    eax,0xb8f00
   5:	bb 00 8f 0b 00       	mov    ebx,0xb8f00
   a:	66 c7 00 40 07       	mov    WORD PTR [eax],0x740
   f:	66 c7 03 40 07       	mov    WORD PTR [ebx],0x740
  14:	f4                   	hlt    
  15:	eb e9                	jmp    0x0
  17:	eb fb                	jmp    0x14
*/
