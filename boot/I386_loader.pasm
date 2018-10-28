/* Code */
.code16
loader_start:
/* set up the REAL stack */
    movw GRIDOS_STACK_ADDR, %sp
/* BIOS stores boot device in %dl => remember for later */
    pushw %dx
    
/* move bootsector to loader segment */
    movw    GRIDOS_BIOS_BOOTSECTOR_SEG, %ax
    movw    %ax, %ds                # %ds = BOOTSEG
    movw    GRIDOS_LOADER_SEG, %ax
    movw    %ax, %es                # %ax = %es = INITSEG
    movw    0x100, %cx
    movw    0, %si
    movw    0, %di
    cld
    .byte 0xf3; .byte 0xa5;  #//rep movsw

/* Segmentpointer richtig setzen */
    movw    GRIDOS_LOADER_SEG, %ax
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %fs
    movw    %ax, %gs
    movw    %ax, %ss
    .byte 0xea;              #//fjmpw    GRIDOS_LOADER_SEG, loader_stage1
    .word loader_stage1
    .word GRIDOS_LOADER_SEG

loadmsg:    .asciz "Loading "
readerr:    .asciz "read error"
memerr:     .asciz "memory error"

loader_stage1:

    movw loadmsg, %si
    jmp message
write_char:
    movw    0x07, %bx  # page 0, attribute 7 (normal)
    movb    0xe, %ah
    int 0x10           # display a byte
message:
    lodsb
    addb    0, %al
    jnz write_char /* if not end of string, write next char */
    
    movw 0x07, %bx
    movw 0x0e2e, %ax
    int 0x10    

    movw 0x07, %bx
    movw 0, %ax
    addw 0x0e40, %ax
    int 0x10

/* activate A20 gate */
    inb 0x92, %al
    .byte 0x0c; .byte 0x02   #// orb 2, %al
    outb %al, 0x92
    
/* disable interrupts */
    cli
    
/* disable NMI */
    movb 0x80, %al
    outb %al, 0x70
    
/* initialize IDT and GDT*/
    .byte 0x0f; .byte 0x01; .byte 0x1e   #//lidtl idt_48
    .long (GRIDOS_LOADER_ADDR + idt_48)
    .byte 0x0f; .byte 0x01; .byte 0x16   #//lgdtl gdt_48
    .long (GRIDOS_LOADER_ADDR + gdt_48)
    
/* real to prod */
    movw 1, %ax # protected mode (PE) bit
    .byte 0x0f; .byte 0x01; .byte 0xf0   #//lmsw    %ax     # This is it!
    .byte 0x66; .byte 0xea;              #//fjmpl    0x08, (GRIDOS_LOADER_ADDR + loader_stage2)
    .long ( ( GRIDOS_LOADER_SEG << 4 ) + loader_stage2 )
    .word 0x8
    
.code32
loader_stage2:
/* init segment-pointer */
    movl    0x10, %edx
    movw    %dx, %ds
    movw    %dx, %es
    movw    %dx, %fs
    movw    %dx, %gs
    movw    %dx, %ss

    movw 0xf40, (cga_lastline) // draw @

/* stop bootloader */
halt:
    hlt
    jmp halt

/* descriptor tables */
.align 32
gdt:
    .word   0                       # dummy
    .word   0
    .word   0
    .word   0
    
    .word   0xFFFF                  # 4Gb - (0x100000*0x1000 = 4Gb)
    .word   0x0000                  # base address = 0
    .byte   0
    .byte   0x9A                    # code read/exec
    .byte   0xCF
    .byte   0                       # granularity = 4096, 386
                                    #  (+5th nibble of limit)
    
    .word   0xFFFF                  # 4Gb - (0x100000*0x1000 = 4Gb)
    .word   0x0000                  # base address = 0
    .byte   0
    .byte   0x92                    # code read/write
    .byte   0xCF
    .byte   0                       # granularity = 4096, 386
                                    #  (+5th nibble of limit)
idt_48:
    .word   0                       # idt limit = 0
    .word   0                       # idt base = 0L
    .word   0
    
.align 32
gdt_48:
    .word   0x18             # gdt limit=24,
                             # 3 GDT entries
    .long   (GRIDOS_LOADER_ADDR + gdt)

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

GRIDOS_BIOS_BOOTSECTOR_SEG := 0x07C0
GRIDOS_LOADER_SEG := 0x1000
GRIDOS_LOADER_ADDR := (GRIDOS_LOADER_SEG << 4)
GRIDOS_LOADER_SECTORS := ((loader_end-loader_start) >> 9)

cga_lastline := 0xb8f00
