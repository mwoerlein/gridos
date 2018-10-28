/* Code */
.code16
loader_start:
    cli
    .byte 0xea;              #//fjmpw    GRIDOS_BIOS_BOOTSECTOR_SEGMENT, loader_stage0
    .word loader_stage0
    .word GRIDOS_BIOS_BOOTSECTOR_SEGMENT

/* loader-sectors */
.align 4
disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word GRIDOS_LOADER_SECTORS  # count
    .word GRIDOS_LOADER_OFFSET   # destination offset
    .word GRIDOS_LOADER_SEGMENT  # destination segment
    .long 1            # lba block
    .long 0            # lba block

/* TODO: use stack or registers for dap => chs conversion */
.align 4
chs_buffer:
dap_fb_sector:
    .byte 1   # sector
dap_fb_track:
    .byte 0   # track
dap_fb_count:
    .byte 1   # count
dap_fb_head:
    .byte 0   # head
dap_fb_segment:
    .word 0   # destination segment
dap_fb_offset:
    .word 0   # destination offset

boot_device:
    .byte 0
bd_cylinders:
    .byte DISK_TRACKS
bd_heads:
    .byte DISK_HEADS
bd_sectors:
    .byte DISK_SECTORS
    
msg_loading:       .asciz "Loading "
msg_read:          .asciz "read"
msg_memory:        .asciz "memory"
msg_general_error: .asciz " error\r\n"

loader_stage0:
/* set up the REAL stack */
    movw 0, %ax
    movw %ax, %ss
    movw GRIDOS_STACK_ADDR, %sp
/* setup segment registers */
    movw    GRIDOS_BIOS_BOOTSECTOR_SEGMENT, %ax
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %fs
    movw    %ax, %gs
    sti
    
    movw msg_loading, %ax
    call write_string
    movw disk_address_packet, %ax
    call load_sectors
    
/* setup segment registers */
    movw    GRIDOS_LOADER_SEGMENT, %ax
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %fs
    movw    %ax, %gs
    
/* BIOS stores boot device in %dl => remember for later */    
    movb %dl, (boot_device)
    .byte 0xea;              #//fjmpw    GRIDOS_LOADER_SEGMENT, loader_stage1
    .word loader_stage1
    .word GRIDOS_LOADER_SEGMENT

read_error:
    movw msg_read, %ax
    jmp error_message
memory_error:
    movw msg_memory, %ax
    jmp error_message
error_message:
    call write_string
    movw msg_general_error, %ax
    call write_string
/* tell the BIOS a boot failure, which may result in no effect */
    int 0x18
    
/* stop bootloader */
loader_halt:
    hlt
    jmp loader_halt

load_sectors:
    pusha
/* vvv TODO: load segment instead of move BIOS segment */
    movw    GRIDOS_BIOS_BOOTSECTOR_SEGMENT, %ax
    movw    %ax, %ds                # %ds = BOOTSEG
    movw    GRIDOS_LOADER_SEGMENT, %ax
    movw    %ax, %es                # %ax = %es = INITSEG
    movw    0x100, %cx
    movw    0, %si
    movw    0, %di
    cld
    .byte 0xf3; .byte 0xa5;  #//rep movsw
/* ^^^ */
    popa
    ret

write_char:
    pusha
    movw    0x07, %bx  # page 0, attribute 7 (normal)
    movb    0xe, %ah
    int 0x10           # display a byte
    popa
    ret
    
write_string:
    pusha
    movw %ax, %si
    jmp wm_load_char
wm_write_char:
    movw    0x07, %bx  # page 0, attribute 7 (normal)
    movb    0xe, %ah
    int 0x10           # display a byte
wm_load_char:
    lodsb
    addb    0, %al     # test for \0
    jnz wm_write_char /* if not end of string, write next char */
    popa
    ret

loader_stage1:
/* TODO: load kernel/modules */
    movb 0x0a, %al; call write_char
    movb 0x0d, %al; call write_char
    
/* TODO: initialize mmap entries from bios */
    movb 0x2e, %al; call write_char
    movb 0x40, %al; call write_char

/* activate A20 gate */
    inb 0x92, %al
    .byte 0x0c; .byte 0x02   #// orb 2, %al
    outb %al, 0x92
    
/* disable interrupts */
    cli
    
/* disable NMI */
    movb 0x80, %al
    outb %al, 0x70
    
/* initialize IDT and GDT - no more bios interrupts possible!*/
    .byte 0x66; .byte 0x0f; .byte 0x01; .byte 0x1e   #//lidtl idt_48
    .word idt_48
    .byte 0x66; .byte 0x0f; .byte 0x01; .byte 0x16   #//lgdtl gdt_48
    .word gdt_48
    
/* real to prod */
    movw 1, %ax # protected mode (PE) bit
    .byte 0x0f; .byte 0x01; .byte 0xf0   #//lmsw    %ax     # This is it!
    .byte 0x66; .byte 0xea;              #//fjmpl    0x08, (GRIDOS_LOADER_ADDR + loader_stage2)
    .long (GRIDOS_LOADER_ADDR + loader_stage2)
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
kernel_halt:
    hlt
    jmp kernel_halt

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
    .long   0                       # idt base = 0L
    
.align 32
gdt_48:
    .word   0x18             # gdt limit=24, 3 GDT entries
    .long   (GRIDOS_LOADER_ADDR + gdt)

.org GRIDOS_LOADER_MPT_START
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE

//TODO: move stage 1 and 2 after MPT, if load_sectors works correctly

.align 512
loader_end:

// TODO: include constants via "header"
GRIDOS_LOADER_MBR_SIGNATURE := 0xaa55
GRIDOS_LOADER_MPT_START := 0x1be
GRIDOS_LOADER_MPT_END := 0x1fe
GRIDOS_STACK_ADDR := 0x7000

GRIDOS_BIOS_BOOTSECTOR_SEGMENT := 0x07C0
GRIDOS_LOADER_SEGMENT := 0x0800
GRIDOS_LOADER_OFFSET := 0x0000
GRIDOS_LOADER_ADDR := ((GRIDOS_LOADER_SEGMENT << 4) + GRIDOS_LOADER_OFFSET)
GRIDOS_LOADER_SECTORS := ((loader_end-loader_start) >> 9)

DISK_HEADS   := 2
DISK_TRACKS  := 80
DISK_SECTORS := 36

cga_lastline := 0xb8f00
