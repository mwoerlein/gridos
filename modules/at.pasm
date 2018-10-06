/*[meta]
mimetype = text/x-pasm
description = Dies ist das GridOS-Kernel-Modul "< @@ >"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.3.0+20181006233800
*/
cga_lastline := 0xb8f00
_start:
    jmp _init
drawGtAddr: nop; nop; nop; nop
haltAddr: nop; nop; nop; nop
_init:
    movl cga_lastline, %eax
    addl 0x4a, %eax
    movl haltAddr, %ecx
    movl _halt, (%ecx)
    movl drawGtAddr, %ecx
    movl drawGT, (%ecx)
    movl drawLT, %edx
    jmp %edx
_halt:
    hlt
    jmp _halt
drawLT:
    movw 0x73c, (%eax)
    addl 4, %eax
    jmp drawAT
drawGT:
    addl 4, %eax
    movw 0x73e, (%eax)
    jmp (haltAddr)
drawAT:
    movw 0xf40, (%eax)
    addl 2, %eax
    movw 0xf40, (%eax)
    jmp (%ecx)
