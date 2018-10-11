/* Code */
.code16
loader_start:
/* set up the REAL stack */
    movw GRIDOS_STACK_ADDR, %sp

    movw 0x07, %bx
    movw 0x0e2e, %ax
    .byte 0xcd; .byte 0x10   #// int $0x10    

    movw 0x07, %bx
    movw 0, %ax
    addw 0x0e40, %ax
    .byte 0xcd; .byte 0x10   #// int $0x10    

/* stop bootloader */
halt:
    hlt
    jmp halt

    addl 0xdeadbeaf, (%eax)

.org GRIDOS_LOADER_MPT_START
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE

.align 512
loader_end:

// TODO: include constants via "header"
GRIDOS_LOADER_MBR_SIGNATURE := 0xaa55
GRIDOS_LOADER_MPT_START := 0x1be
GRIDOS_LOADER_MPT_END := 0x1fe
GRIDOS_STACK_ADDR := 0x1000
