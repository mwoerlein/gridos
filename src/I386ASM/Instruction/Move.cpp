#include "I386ASM/Instruction/Move.hpp"

// public
size_t Move::getSizeInBytes() {
    return 20;
}

void Move::writeToStream(OStream & stream) {
    stream
    
        <<(char)0xb8 // movl eax
        <<(char)0x00 // 0x000b8f00
        <<(char)0x8f
        <<(char)0x0b
        <<(char)0x00
        
        <<(char)0x66 //    w
        <<(char)0xc7 // mov
        <<(char)0x00 // (eax)
        <<(char)0x40 // 0x0740
        <<(char)0x07
        
        <<(char)0x05 // addl eax
        <<(char)0x02 // 0x00000002
        <<(char)0x00
        <<(char)0x00
        <<(char)0x00
        
        <<(char)0x66 //    w
        <<(char)0xc7 // mov
        <<(char)0x00 // (eax)
        <<(char)0x40 // 0x0740
        <<(char)0x07
    ;
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
