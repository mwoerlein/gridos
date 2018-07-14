#define ASM_FILE
#include "../include/multiboot2/multiboot2.h"
#include "I386_loader.h"
#include "I386_loader_config.s"

/* Print message string */
#define MSG(x)  movw $x, %si; call message
#define ERR(x)  movw $x, %si; jmp error_message
#define SPACE() movw $0x07, %bx; movw $0x0e20, %ax; int $0x10
#define DOT()   movw $0x07, %bx; movw $0x0e2e, %ax; int $0x10
#define NL()    movw $0x07, %bx; movw $0x0e0a, %ax; int $0x10; movw $0x0e0d, %ax; int $0x10

/* Code */
.global loader_start
.text

.code16
loader_start:
/* set up the REAL stack */
    movw    $GRIDOS_STACK_ADDR, %sp
/* BIOS stores boot device in %dl => remember for later */
    pushw   %dx
    
/* move bootsector to loader segment */
    movw    $GRIDOS_BIOS_BOOTSECTOR_SEG, %ax
    movw    %ax, %ds                # %ds = BOOTSEG
    movw    $GRIDOS_LOADER_SEG, %ax
    movw    %ax, %es                # %ax = %es = INITSEG
    movw    $0x100, %cx
    subw    %si, %si
    subw    %di, %di
    cld
    rep
    movsw
/* Segment- und Stackpointer richtig setzen */
    movw    $GRIDOS_LOADER_SEG, %ax
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %fs
    movw    %ax, %gs
    movw    %ax, %ss
    ljmp    $GRIDOS_LOADER_SEG, $loader_stage0
    
/* stage0 variables/constants */
.align 4
/* loader-sectors */
loader_sectors:
    .byte 2 # sector
    .byte 0 # track
    .byte GRIDOS_LOADER_SECTORS - 1 # count
    .byte 0 # head
    .word GRIDOS_LOADER_SEG # destination segment
    .word 0x200 # destination offset

boot_device: .byte 0
loadmsg:    .asciz "Loading "
readerr:    .asciz "read error"
memerr:     .asciz "mem error"
.align 4

loader_stage0:
/* restore boot_device */
    popw    %dx
    movb    %dl, boot_device
    
    MSG(loadmsg)
    
/* load and run next stages */
    movw    $loader_sectors, %ax
    call    load_sectors
    jmp loader_stage1
    
/* display helper methods */
write_hex:
    movw %ax, %cx
    movw $0x07, %bx; movw $0x0e30, %ax; int $0x10   # 0
    movw $0x07, %bx; movw $0x0e78, %ax; int $0x10   # x
    movw %cx, %ax; shrw $12, %ax; call write_number # ?
    movw %cx, %ax; shrw $8, %ax; call write_number  # ?
    movw %cx, %ax; shrw $4, %ax; call write_number  # ?
    movw %cx, %ax; call write_number                # ?
    ret
    
write_number:
    andw    $0xf, %ax
    cmpw    $10, %ax
    jle write_number_1
    addw    $(65-48-10), %ax
write_number_1:
    addw    $48, %ax
    movw    $0x07, %bx
    movb    $0x0e, %ah
    int $0x10
    ret
    
write_char:
    movw    $0x07, %bx  # page 0, attribute 7 (normal)
    movb    $0xe, %ah
    int $0x10           # display a byte
message:
    lodsb
    cmpb    $0, %al
    jne write_char /* if not end of string, write next char */
    ret
    
read_error:
    ERR(readerr)
memory_error:
    ERR(memerr)
error_message:
    call    message
/* tell the BIOS a boot failure, which may result in no effect */
    int $0x18
    
/* stop bootloader */
halt:
    hlt
    jmp halt
    
/* load sectors via CHS int 13 */
load_sectors:
    movw    %ax, %bx
    movw    (%bx), %cx
    movw    2(%bx), %dx
    movw    4(%bx), %ax
    movw    %ax, %es
    movw    6(%bx), %bx
    movb    %dl, %al
    movb    boot_device, %dl
    movb    $0x02, %ah            # read sectors
    int $0x13
    jc  read_error
    DOT()
    ret
    
.org GRIDOS_LOADER_MPT_START
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE
    
/* stage1 variables/constants */

/* kernel-sectors */
kernel_sectors:
    .byte JIT_SECTOR    # sector
    .byte JIT_TRACK     # track
    .byte JIT_BLOCKS    # count
    .byte JIT_HEAD      # head
    .word JIT_SEGMENT   # destination segment
    .word JIT_OFFSET    # destination offset
    
/* modules-sectors */
modules_sectors:
    .byte TEXT_SECTOR   # sector
    .byte TEXT_TRACK    # track
    .byte TEXT_BLOCKS   # count
    .byte TEXT_HEAD     # head
    .word TEXT_SEGMENT  # destination segment
    .word TEXT_OFFSET   # destination offset
    
.align 4
.code16
loader_stage1:
/* load kernel */
    movw $kernel_sectors, %ax
    call load_sectors
    
/* load modules */
    movw $modules_sectors, %ax
    call load_sectors
    
    NL()
    
/* initialize mmap entries from bios */
    movw    %ds, %ax
    movw    %ax, %es
    movw    $mbi_tag_mmap_entries, %di
    
    xorl    %ebx, %ebx
    movl    $0x0534D4150, %edx
    
e820_read:
    movl    $0xe820, %eax
    movl    $1, 20(%di)
    movl    $24,    %ecx
    int $0x15
    jc  memory_error
    movl    $0x0534D4150, %edx
    cmpl    %eax, %edx
    jne memory_error
    
    cmpl    $20, %ecx
    jbe e820_valid
    testl   $1, 20(%di)
    je  e820_ignore
    
e820_valid:
    movl    12(%di), %eax
    orl     8(%di), %eax
    cmpl    $0, %eax
    je  e820_ignore
/* keep valid, non-empty entry */   
    addw    $24, %di
    
e820_ignore:
    cmpl    $0, %ebx
    jne e820_read
    
/* adjust mbi_tag_mmap_size */
    xorl    %eax, %eax
    movw    %di, %ax
    subw    $mbi_tag_mmap, %ax
    movl    %eax, mbi_tag_mmap_size
    
/* generate new end tag */
    movl    $MULTIBOOT_TAG_TYPE_END, (%di)
    movl    $8, 4(%di)
    addw    $8, %di
    
/* adjust mbi_size */
    movw    %di, %ax
    subw    $mbi, %ax
    movl    %eax, mbi_size
    
/* activate A20 gate */
    inb $0x92, %al
    orb $2, %al
    outb    %al, $0x92
    
/* disable interrupts */
    cli
    
/* disable NMI */
    movb    $0x80,%al
    outb    %al, $0x70
    
/* initialize IDT and GDT*/
    lidtl   idt_48
    lgdtl   gdt_48
    
/* real to prod */
    movw    $1, %ax # protected mode (PE) bit
    lmsw    %ax     # This is it!
    jmpl    $0x08, $(GRIDOS_LOADER_ADDR+loader_stage2)
    
.code32
loader_stage2:
/* init segment-pointer */
    movl    $0x10, %edx
    movw    %dx, %ds
    movw    %dx, %es
    movw    %dx, %fs
    movw    %dx, %gs
    movw    %dx, %ss
    
    movl    $MULTIBOOT2_BOOTLOADER_MAGIC, %eax
    movl    $(GRIDOS_LOADER_ADDR+mbi), %ebx
    
/* jmp to kernel */
    jmpl    $0x08, $(JIT_SEGMENT*0x10)
    
/* descriptor tables */
.p2align 5
gdt:
    .word   0, 0, 0, 0              # dummy
    
    .word   0xFFFF                  # 4Gb - (0x100000*0x1000 = 4Gb)
    .word   0x0000                  # base address = 0
    .byte   0, 0x9A                 # code read/exec
    .byte   0xCF, 0                 # granularity = 4096, 386
                                    #  (+5th nibble of limit)
    
    .word   0xFFFF                  # 4Gb - (0x100000*0x1000 = 4Gb)
    .word   0x0000                  # base address = 0
    .byte   0, 0x92                 # data read/write
    .byte   0xCF, 0                 # granularity = 4096, 386
                                    #  (+5th nibble of limit)
idt_48:
    .word   0                       # idt limit = 0
    .word   0, 0                    # idt base = 0L
    
.p2align 5
gdt_48:
    .word   0x18                    # gdt limit=32,
                                    #  4 GDT entries
    .long   GRIDOS_LOADER_ADDR+gdt  # gdt base (filled in later)
    
/* mbi-structures */
.align MULTIBOOT_TAG_ALIGN
mbi:
mbi_size:
    .long   0 # size (will be filled after memory-detection)
    .long   0 #reserved
mbi_tag_name:
    .long   MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME
    .long   mbi_tag_name_end - mbi_tag_name
    .asciz  GRIDOS_LOADER_NAME
.align MULTIBOOT_TAG_ALIGN
mbi_tag_name_end:
mbi_tag_command_line:
    .long   MULTIBOOT_TAG_TYPE_CMDLINE
    .long   mbi_tag_command_line_end - mbi_tag_command_line
    .asciz  "jit.i386"
.align MULTIBOOT_TAG_ALIGN
mbi_tag_command_line_end:
mbi_tag_modules:
    .long   MULTIBOOT_TAG_TYPE_MODULE
    .long   mbi_tag_modules_end - mbi_tag_modules
    .long   TEXT_ADDR
    .long   TEXT_ADDR + TEXT_SIZE
    .asciz  "kernel.pool"
.align MULTIBOOT_TAG_ALIGN
mbi_tag_modules_end:
mbi_tag_mmap:
    .long   MULTIBOOT_TAG_TYPE_MMAP
mbi_tag_mmap_size:
    .long   0   # size (will be filled after memory-detection)
    .long   24  # entry_size
    .long   0   # entry_version
mbi_tag_mmap_entries:
    
.align 512
loader_end:
