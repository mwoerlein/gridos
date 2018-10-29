/* Code */
.code16
loader_start:
    cli
    .byte 0xea;              #//fjmpw    GRIDOS_BIOS_BOOTSECTOR_SEGMENT, loader_stage0
    .word loader_stage0
    .word GRIDOS_BIOS_BOOTSECTOR_SEGMENT

/* stage0 data */
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

/* stage0 data END */

/* prepare loader */
loader_stage0:
/* set up the REAL stack */
    movw 0, %ax
    movw %ax, %ss
    movw GRIDOS_STACK_ADDR, %sp
/* setup segment registers */
    movw GRIDOS_BIOS_BOOTSECTOR_SEGMENT, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    sti
    
    movw msg_loading, %ax
    call write_string
    movw disk_address_packet, %ax
    call load_sectors
    
/* setup segment registers */
    movw GRIDOS_LOADER_SEGMENT, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    
/* BIOS stores boot device in %dl => remember for later */    
    movb %dl, (boot_device)
    .byte 0xea;              #//fjmpw    GRIDOS_LOADER_SEGMENT, loader_stage1
    .word loader_stage1
    .word GRIDOS_LOADER_SEGMENT

/* stage0 functions/helper */
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

ls_chs_load:
    /* %si = dap address */
    movl 0, %edi
    addw 2(%si), %di              # segments to read
    jnz ls_chs_check_max
    popad
    ret
    
    /* determine allowed segments to read */
ls_chs_check_max:
    // maximal 127 segments
    .byte 0x81; .byte 0xff; .word 0x7f #// cmpw 127, %di
    jl ls_chs_check_offset
    movw 127, %di 
ls_chs_check_offset:
    // do not cross offset limit
    movw %di, %ax
    .byte 0xc1; .byte 0xe0; .byte 0x09 #// shlw 9, %ax
    addw 4(%si), %ax              # dest offset
    jnc ls_chs_convert
    .byte 0xc1; .byte 0xe8; .byte 0x09 #// shrw 9, %ax
    .byte 0x29; .byte 0xc7  #// subw %ax, %di

ls_chs_convert:
    /*
     * convert LBA to CHS
     *
     * Temp = LBA / (Sectors per Track)
     * Sector = (LBA % (Sectors per Track)) + 1
     * Head = Temp % (Number of Heads)
     * Cylinder = Temp / (Number of Heads)
     */
    movl 8(%si), %eax    # LBA
    movl 12(%si), %edx   # LBA
    
    .byte 0x66; .byte 0xf7; .byte 0x3e; .word bd_sectors  #// idiv (bd_sectors)
    addb 1, %dl
    movb %dl, %cl        # store sector
    .byte 0x66; .byte 0x99      #// cdq
    .byte 0x66; .byte 0xf7; .byte 0x3e; .word bd_heads    #// idiv (bd_heads)
    movb %al, %ch        # store cylinder
    movb %dl, %dh        # store head

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
    movw 6(%si), %bx              # dest segment
    movw %bx, %es
    movw 4(%si), %bx              # dest offset
    movw %di, %ax                 # segments to read
    movb 2, %ah
    movb (boot_device), %dl
    int 0x13
    jc  read_error
    addb 0, %ah
    jnz read_error
    
    /* draw "." */
    movb 0x2e, %al; call write_char
    
    /* step count/segment/lba in dap */
    .byte 0x29; .byte 0x7c; .byte 0x02 #// subw %di, 2(%si) // count
    addl %edi, 8(%si) // lba
    .byte 0xc1; .byte 0xe7; .byte 0x09 #// shlw 9, %di
    addw %di, 4(%si) // offset
    jnc ls_chs_load
    addw 0x1000, 6(%si) // segment
    jmp ls_chs_load

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

/* stage0 functions/helper END*/

.org GRIDOS_LOADER_MPT_START
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE

/* stage1 functions/helper */

/* stage1 functions/helper END */

/* prepare kernel/modules/multiboot information and switch to protected mode */
loader_stage1:
/* TODO: load dap-list instead of hardcoded startup/mod_text */
    movw startup_disk_address_packet, %ax
    call load_sectors
    
    movw mod_text_disk_address_packet, %ax
    call load_sectors

    /* draw newline */
    movb 0x0a, %al; call write_char; movb 0x0d, %al; call write_char
    
/* TODO: initialize mmap entries from bios */
    /* draw newline */
    movb 0x0a, %al; call write_char; movb 0x0d, %al; call write_char

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
    .byte 0x66; .byte 0xea;              #//fjmpl    0x08, (GRIDOS_LOADER_ADDR + loader_stage1_32)
    .long (GRIDOS_LOADER_ADDR + loader_stage1_32)
    .word 0x8
    
.code32
/* start kernel */
loader_stage1_32:
/* init segment-pointer */
    movl 0x10, %edx
    movw %dx, %ds
    movw %dx, %es
    movw %dx, %fs
    movw %dx, %gs
    movw %dx, %ss

/* jmp to kernel */
    movl GRIDOS_MULTIBOOT2_LOADER_MAGIC, %eax
    movl (GRIDOS_LOADER_ADDR + mbi), %ebx
    .byte 0xea;              #//fjmpl    0x08, STARTUP_ADDR
    .long STARTUP_ADDR
    .word 0x8

/* stop bootloader */
kernel_halt:
    hlt
    jmp kernel_halt

/* stage1 data */

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

/* TODO: load dap-list instead of hardcoded startup/mod_text */
.align 4
startup_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word STARTUP_SECTORS  # count
    .word STARTUP_OFFSET   # destination offset
    .word STARTUP_SEGMENT  # destination segment
    .long STARTUP_LBA      # lba block
    .long 0                # lba block
.align 4
mod_text_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word MOD_TEXT_SECTORS # count
    .word MOD_TEXT_OFFSET  # destination offset
    .word MOD_TEXT_SEGMENT # destination segment
    .long MOD_TEXT_LBA     # lba block
    .long 0                # lba block

/* mbi-structures */
.align MULTIBOOT_TAG_ALIGN
mbi:
mbi_size:
    .long   (mbi_end - mbi) # size (will be filled after memory-detection)
    .long   0 # reserved
mbi_tag_name:
    .long   MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME
    .long   (mbi_tag_name_end - mbi_tag_name)
    .asciz  "GridOS Loader 0.2" // GRIDOS_LOADER_NAME
.align MULTIBOOT_TAG_ALIGN
mbi_tag_name_end:
/* TODO: generate from load dap-list instead of hardcoded startup/mod_text */
mbi_tag_command_line:
    .long   MULTIBOOT_TAG_TYPE_CMDLINE
    .long   (mbi_tag_command_line_end - mbi_tag_command_line)
    .asciz  "--test = 0 --debug=2" // STARTUP_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_command_line_end:
mbi_tag_module_text:
    .long   MULTIBOOT_TAG_TYPE_MODULE
    .long   (mbi_tag_module_text_end - mbi_tag_module_text)
    .long   MOD_TEXT_ADDR
    .long   (MOD_TEXT_ADDR + MOD_TEXT_SIZE)
    .asciz  "kernel --debug=1" // MOD_TEXT_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_module_text_end:
mbi_tag_mmap:
    .long   MULTIBOOT_TAG_TYPE_MMAP
mbi_tag_mmap_size:
    .long   (mbi_tag_mmap_end-mbi_tag_mmap)  # size (will be filled after memory-detection)
    .long   24  # entry_size
    .long   0   # entry_version
/* TODO: initialize mmap entries from bios */
mbi_tag_mmap_entries:
    .long 0x01000000
    .long 0
    .long 0x01000000
    .long 0
    .long 1
    .long 0
.align MULTIBOOT_TAG_ALIGN
mbi_tag_mmap_end:
mbi_tag_end:
    .long   MULTIBOOT_TAG_TYPE_END
    .long   (mbi_tag_end_end - mbi_tag_end)
mbi_tag_end_end:
mbi_end:
/* stage1 data END*/

.align 512
loader_end:

// TODO: include constants via "header"
MULTIBOOT_TAG_ALIGN                  := 8
MULTIBOOT_TAG_TYPE_END               := 0
MULTIBOOT_TAG_TYPE_CMDLINE           := 1
MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME  := 2
MULTIBOOT_TAG_TYPE_MODULE            := 3
MULTIBOOT_TAG_TYPE_BASIC_MEMINFO     := 4
MULTIBOOT_TAG_TYPE_BOOTDEV           := 5
MULTIBOOT_TAG_TYPE_MMAP              := 6
MULTIBOOT_TAG_TYPE_VBE               := 7
MULTIBOOT_TAG_TYPE_FRAMEBUFFER       := 8

GRIDOS_MULTIBOOT2_HEADER_MAGIC := 0xe85250d6
GRIDOS_MULTIBOOT2_HEADER_ARCH_I386 := 0
GRIDOS_MULTIBOOT2_LOADER_MAGIC := 0x36d76289

//GRIDOS_LOADER_NAME := "GridOS Loader 0.2"
GRIDOS_LOADER_MBR_SIGNATURE := 0xaa55
GRIDOS_LOADER_MPT_START := 0x1be
GRIDOS_LOADER_MPT_END := 0x1fe
GRIDOS_STACK_ADDR := 0x7000

GRIDOS_BIOS_BOOTSECTOR_SEGMENT := 0x07C0
GRIDOS_LOADER_SEGMENT := 0x0800
GRIDOS_LOADER_OFFSET := 0x0000
GRIDOS_LOADER_ADDR := ((GRIDOS_LOADER_SEGMENT << 4) + GRIDOS_LOADER_OFFSET)
GRIDOS_LOADER_SECTORS := ((loader_end-loader_start) >> 9)
GRIDOS_BOOTSTRAP_STACK_SIZE := 0x3000

DISK_HEADS   := 2
DISK_TRACKS  := 80
DISK_SECTORS := 36

// TODO: inject dynamical
STARTUP_LBA      := GRIDOS_LOADER_SECTORS
STARTUP_SECTORS  := 913
STARTUP_SIZE     := (STARTUP_SECTORS << 9)
STARTUP_SEGMENT  := 0x2000
STARTUP_OFFSET   := 0x0000
STARTUP_ADDR     := ((STARTUP_SEGMENT << 4) + STARTUP_OFFSET)
//STARTUP_CMD      := "--test = 0 --debug=2"
BSS_TMP1         := ((STARTUP_SECTORS >> 3) << 8)
BSS_SEGMENT      := (STARTUP_SEGMENT + (BSS_TMP1 + 0x200))
BSS_SIZE         := (GRIDOS_BOOTSTRAP_STACK_SIZE + 0x100)

MOD_TEXT_LBA     := (STARTUP_LBA+STARTUP_SECTORS)
MOD_TEXT_SECTORS := 2
MOD_TEXT_SIZE    := (MOD_TEXT_SECTORS << 9)
MOD_TEXT_SEGMENT := (BSS_SEGMENT + (BSS_SIZE >> 4))
MOD_TEXT_OFFSET  := 0x0000
MOD_TEXT_ADDR    := ((MOD_TEXT_SEGMENT << 4) + MOD_TEXT_OFFSET)
//MOD_TEXT_CMD     := "kernel --debug=1"

cga_lastline := 0xb8f00
