// TODO: cdq, idiv, cmp, and/or, shr/shl, sub/mul/..., fjmp, lmsw, lidt/lgdt
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
    .long 0            # lba block
    .long 0            # lba block

boot_device:
    .byte 0
bd_cylinders:
    .long DISK_TRACKS
bd_heads:
    .long DISK_HEADS
bd_sectors:
    .long DISK_SECTORS
    
msg_loading:       .asciz "Loading "
msg_read:          .asciz "read"
msg_memory:        .asciz "memory"
msg_general_error: .asciz " error\r\n"

/* prepare loader */
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

/*
 * load_sectors (%ax)
 *
 * loads sectors according to disk address packet referenced by %ax via BIOS interrupt 0x13
 * uses LBA extension, if available, otherwise CHS according to boot device geometry 
 */
load_sectors:
    pushad
    /* store dap address in %si */
    movw %ax, %si
    
    /* test if LBA is available */
    movw 0x55aa, %bx
    movb 0x41, %ah
    movb (boot_device), %dl
    int 0x13
    jc ls_chs_load // no LBA => use CHS
    .byte 0x81; .byte 0xfb; .word 0xaa55 #// cmpw 0xaa55, %bx
	jne ls_chs_load // no LBA => use CHS
    .byte 0x83; .byte 0xe1; .byte 0x01 #// andw 1, %cx
	jz ls_chs_load // no LBA => use CHS

ls_lba_load:
    /* load via LBA extension */
/*
 * BIOS call "INT 0x13 Function 0x42" to read sectors from disk into memory
 *	Call with	%ah = 0x42
 *			%dl = drive number
 *			%ds:%si = segment:offset of disk address packet
 *	Return:
 *			%al = 0x0 on success; err code on failure
 */
    movb 0x42, %ah
    movb (boot_device), %dl
    int 0x13
    jc ls_chs_load // no LBA => use CHS
    addb 0, %ah
    jnz read_error
    
    /* draw "." */
    movb 0x2e, %al; call write_char
    popad
    ret

ls_chs_load: // TODO: split and loop sectors, to fit into segments and heads 
    /* %si = dap address */
    movl 8(%si), %eax             # src segment (lba)
    movl 12(%si), %edx            # src segment (lba)
    
    # convert %edx:%eax to CHS
    # Temp = LBA / (Sectors per Track)
    # Sector = (LBA % (Sectors per Track)) + 1
    .byte 0x66; .byte 0xf7; .byte 0x3e; .word bd_sectors  #// idiv (bd_sectors)
    addb 1, %dl
    movb %dl, %cl     # store sector
    # Head = Temp % (Number of Heads)
    # Cylinder = Temp / (Number of Heads)
    .byte 0x66; .byte 0x99      #// cdq
    .byte 0x66; .byte 0xf7; .byte 0x3e; .word bd_heads    #// idiv (bd_heads)
    movb %al, %ch     # store cylinder
    movb %dl, %dh     # store head
    
/*
 * BIOS call "INT 0x13 Function 0x2" to read sectors from disk into memory
 *	Call with	%ah = 0x2
 *			%al = number of sectors
 *			%ch = cylinder
 *			%cl = sector (bits 6-7 are high bits of "cylinder")
 *			%dh = head
 *			%dl = drive (0x80 for hard disk, 0x0 for floppy disk)
 *			%es:%bx = segment:offset of buffer
 *	Return:
 *			%al = 0x0 on success; err code on failure
 */
    movw 6(%si), %ax              # dest segment
    movw %ax, %es
    movw 2(%si), %ax              # segments to read
    movw 4(%si), %bx              # dest offset
    movb 2, %ah
    movb (boot_device), %dl
    int 0x13
    jc  read_error
    addb 0, %ah
    jnz read_error
    /* draw "." */
    movb 0x2e, %al; call write_char
    popad
    ret

/*
 * write_char (%al)
 *
 * writes the ascii char in %al via BIOS interrupt 0x10
 */
write_char:
    pusha
wc_write:
    movw 0x07, %bx
    movb 0x0e, %ah
    int 0x10
    popa
    ret
    
/*
 * write_string (%ax)
 *
 * writes the asciz string by %ax via BIOS interrupt 0x10
 */
write_string:
    pusha
    movw %ax, %si
    jmp wm_load_char
wm_write_char:
    movw 0x07, %bx  # page 0, attribute 7 (normal)
    movb 0xe, %ah
    int 0x10        # display a byte
wm_load_char:
    lodsb
    addb 0, %al     # test for \0
    jnz wm_write_char /* if not end of string, write next char */
    popa
    ret

/*
write_digit:
    pusha
wd_write:
    .byte 0x83; .byte 0xe0; .byte 0x0f #// andw 0xf, %ax
    addw 48, %ax
    .byte 0x83; .byte 0xf8; .byte 0x3a #// cmpw 58, %ax
    jl wc_write
    addw 7, %ax
    jmp wc_write
*/

/*
write_hex:
    pusha
    movw %ax, %bx
    movb 0x20, %al; call write_char
    movb 0x30, %al; call write_char
    movb 0x78, %al; call write_char
    movw %bx, %ax; .byte 0xc1; .byte 0xe8; .byte 0x0c; #// shrw 12, %ax;
       call write_digit
    movw %bx, %ax; .byte 0xc1; .byte 0xe8; .byte 0x08; #// shrw 8, %ax;
       call write_digit
    movw %bx, %ax; .byte 0xc1; .byte 0xe8; .byte 0x04; #// shrw 4, %ax;
       call write_digit
    movw %bx, %ax
    jmp wd_write
*/

/*
write_reg:
    pusha
    call write_char
    movb 0x3A, %al; call write_char
    movw %bx, %ax;  call write_hex
    movb 0x0a, %al; call write_char
    movb 0x0d, %al;
    jmp wc_write
*/

/*
write_regs:
    pusha
    pushw %bx
    movw %ax, %bx; movb 0x61, %al; call write_reg
    popw %bx; movb 0x62, %al; call write_reg
    movw %cx, %bx; movb 0x63, %al; call write_reg
    movw %dx, %bx; movb 0x64, %al; call write_reg
    movw %es, %bx; movb 0x65, %al; call write_reg
    movw %si, %bx; movb 0x66, %al; call write_reg
    popa
    ret
*/

.org GRIDOS_LOADER_MPT_START
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE

/* prepare kernel/modules/multiboot information and switch to protected mode */
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
    
/* initialize IDT and GDT - no more bios interrupts possible! */
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
/* start kernel */
loader_stage2:
/* init segment-pointer */
    movl    0x10, %edx
    movw    %dx, %ds
    movw    %dx, %es
    movw    %dx, %fs
    movw    %dx, %gs
    movw    %dx, %ss

/* TODO: jmp to kernel */
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
