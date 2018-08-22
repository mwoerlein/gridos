#define ASM_FILE
#include "../include/multiboot2/multiboot2.h"
#include "I386_loader.h"
#include "I386_loader_config.s"

/* Print message string */
#define MSG(x)  movw $x, %si; call message
#define ERR(x)  movw $x, %si; jmp error_message
#define SPACE() movw $0x07, %bx; movw $0x0e20, %ax; int $0x10
#define DOT()   movw $0x07, %bx; movw $0x0e2e, %ax; int $0x10
#define AT()    movw $0x07, %bx; movw $0x0e40, %ax; int $0x10
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
/* Segmentpointer richtig setzen */
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

boot_device:
    .byte 0
bd_cylinders:
    .byte DISK_TRACKS
bd_heads:
    .byte DISK_HEADS
bd_sectors:
    .byte DISK_SECTORS
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
    pushw   %ax
    pushw   %bx
    pushw   %cx
    movw %ax, %cx
    movw $0x07, %bx; movw $0x0e20, %ax; int $0x10   # ' '
    movw $0x07, %bx; movw $0x0e30, %ax; int $0x10   # 0
    movw $0x07, %bx; movw $0x0e78, %ax; int $0x10   # x
    movw %cx, %ax; shrw $12, %ax; call write_number # ?
    movw %cx, %ax; shrw $8, %ax; call write_number  # ?
    movw %cx, %ax; shrw $4, %ax; call write_number  # ?
    movw %cx, %ax; call write_number                # ?
    popw    %cx
    popw    %bx
    popw    %ax
    ret
    
write_number:
    andw    $0xf, %ax
    cmpw    $10, %ax
    jl write_number_1
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
//    int $0x18
    
/* stop bootloader */
halt:
    hlt
    jmp halt
    
/* load sectors via CHS int 13 */
load_sectors:
    pushw   %ax
    pushw   %bx
    pushw   %cx
    pushw   %dx
    pushw   %es
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
    testb   %ah, %ah
    jnz read_error
    DOT()
    popw    %es
    popw    %dx
    popw    %cx
    popw    %bx
    popw    %ax
    ret
    
.org GRIDOS_LOADER_MPT_START
.org GRIDOS_LOADER_MPT_END
    .word GRIDOS_LOADER_MBR_SIGNATURE
    
/* stage1 variables/constants */

/* kernel disk address packet */
kernel_dap:
    .byte 0x10
    .byte 0x0
    .word JIT_BLOCKS   # count
    .word JIT_OFFSET   # destination offset
    .word JIT_SEGMENT  # destination segment
    .long JIT_LBA      # lba block
    .long 0            # lba block
    
/* modules disk address packet */
modules_dap:
    .byte 0x10
    .byte 0x0
    .word TEXT_BLOCKS  # count
    .word TEXT_OFFSET  # destination offset
    .word TEXT_SEGMENT # destination segment
    .long TEXT_LBA     # lba block
    .long 0            # lba block

/* dap-fallback-sectors */
dap_fb_sectors:
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
    
.align 4
.code16
load_via_dap:
    pushl   %eax
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %esi
    movw    %ax, %si
    
    movw    $0x55aa, %bx
    movb    boot_device, %dl
    movb    $0x41, %ah            # check lba read is available
    int $0x13
    jc  dap_fb_load
    
dap_lba_load:                     # %si contains address of dap
    movb    $0x42, %ah            # read dap
    int $0x13
    jc  read_error
    testb   %ah, %ah
    jnz read_error
    DOT()
    jmp load_dap_return
    
dap_fb_load:                      # %si contains address of dap
    movw 6(%si), %ax
    movw %ax, dap_fb_segment
    movl 8(%si), %ebx             # src segment (lba)
    movw 2(%si), %cx              # segments to read
    movw 4(%si), %dx              # dest segment offset
    
dab_fb_loop:
    test %cx, %cx
    jz load_dap_return
    
    movw $dap_fb_sectors, %ax
    call lba_to_chs
    
    movw %dx, dap_fb_offset
    call load_sectors
    
    # step counters
    inc %ebx
    dec %cx
    addw $0x200, %dx
    jnc dab_fb_loop
    
    # step destination segment
    movw dap_fb_segment, %ax
    addw $0x1000, %ax
    movw %ax, dap_fb_segment
    jmp dab_fb_loop

load_dap_return:
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret

lba_to_chs:
    pushl   %eax
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %edi

    # convert %ebx to CHS at %ax
    movw    %ax, %di
    # Temp = LBA / (Sectors per Track)
    # Sector = (LBA % (Sectors per Track)) + 1
    movl    %ebx, %eax
    cdq
    xorl %ebx, %ebx
    movb bd_sectors, %bl
    idiv %ebx
    addb $1, %dl
    movb %dl, (%di)     # store sector
    # Head = Temp % (Number of Heads)
    # Cylinder = Temp / (Number of Heads)
    cdq
    movb bd_heads, %bl
    idiv %ebx
    movb %al, 1(%di)     # store cylinder
    movb %dl, 3(%di)     # store head
      
    popl    %edi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
    

loader_stage1:
/* load kernel */
    movw $kernel_dap, %ax
    call load_via_dap
/* load modules */
    movw $modules_dap, %ax
    call load_via_dap
    
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
    
/* jmp to kernel */
    movl    $MULTIBOOT2_BOOTLOADER_MAGIC, %eax
    movl    $(GRIDOS_LOADER_ADDR+mbi), %ebx
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
    .long   0 # reserved
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
