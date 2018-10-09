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

.org GRIDOS_LOADER_MPT_START
    jmp loader_end
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE
loader_end:
// TODO: include constants via "header"
GRIDOS_LOADER_MBR_SIGNATURE := 0xaa55
GRIDOS_LOADER_MPT_START := 0x1be
GRIDOS_LOADER_MPT_END := 0x1fe
