/* Code */

#//.code16
loader_start:
/* set up the REAL stack */
    .byte 0xbc; .word 0x1000 #// movw 0x1000, %sp

    .byte 0xbb; .word 0x7    #// movw 0x07, %bx
    .byte 0xb8; .word 0x0e40 #// movw 0x0e40, %ax
    .byte 0xcd; .byte 0x10   #// int $0x10    

    .byte 0xbb; .word 0x7    #// movw 0x07, %bx
    .byte 0xb8; .word 0x0e40 #// movw 0x0e40, %ax
    .byte 0xcd; .byte 0x10   #// int $0x10    

/* stop bootloader */
halt:
    hlt
    jmp halt

.org 0x1f0
    jmp loader_end
.org 0x1fe
    .word 0xaa55
loader_end:
