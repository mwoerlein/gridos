/*[meta]
mimetype = text/x-pasm
description = Dies ist das GridOS-Kernel-Modul "< @@ >"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181009145000
*/
cga_lastline := 0xb8f00
_start:
    jmp _init
_init:
    movl cga_lastline, %eax
    addl 0x4a, %eax
    jmp drawLT
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
    jmp _halt
drawAT:
    movw 0xf40, (%eax)
    addl 2, %eax
    movw 0xe40, (%eax)
    jmp drawGT
