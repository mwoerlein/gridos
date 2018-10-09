/*[meta]
mimetype = text/x-pasm
description = Dies ist das GridOS-Kernel-Modul "Blinking"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181005022610
*/
cga_lastline := 0xb8f00
_start:
    movl 0, %ebx // column = 0
    movl 0, %ecx // charOffset = 0
    
blinking_loop:
    // charTmp = charOffset
    movl %ecx, %eax
    
    // show 'a'+charOffset at column
    addl 0x761, %ecx
    movw %cx, cga_lastline(,%ebx,2)
    
    // charOffset = (charTmp + 1) % 26
    addl 1, %eax
    movl 26, %ecx
    divb %cl; movb %ah, %cl
    //movw 0, %dx; divw %cx; movw %dx, %cx
    //movl 0, %edx; divl %ecx; movl %edx, %ecx
    
    // column = (column + 1) % 80
    movl %ebx, %eax
    addl 1, %eax
    movl 80, %ebx
    divb %bl; movb %ah, %bl
    //movw 0, %dx; divw %bx; movw %dx, %bx
    //movl 0, %edx; divl %ebx; movl %edx, %ebx
    
    // wait a bit
    movl 0x3fffff, %eax    
wait:
    addl -1, %eax
    jnz wait
    // endless loop
    jmp blinking_loop