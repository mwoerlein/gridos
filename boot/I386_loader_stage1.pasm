.code16
/* prepare kernel/modules/multiboot information and switch to protected mode */
loader_stage1:
/* TODO: load dap-list instead of hardcoded startup/mod_text */
    movw startup_disk_address_packet, %ax
    call load_sectors
    
    movw mod_kernel_disk_address_packet, %ax
    call load_sectors
    
    movw mod_store_disk_address_packet, %ax
    call load_sectors
    
    /* draw newline */
    movb 0x0a, %al; call write_char; movb 0x0d, %al; call write_char
    
    
/* initialize mmap entries from bios */
    movw mbi_static_end, %si
    call mb2_generate_mmap_tag
    
    // step over mmap_tag
    addw 4(%si), %si
    movw mbi, %bx
    call mb2_finalize_mbi
    
/* activate A20 gate */
    inb 0x92, %al
    orb 2, %al
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
    .byte 0x66; .byte 0xea;              #//fjmpl    0x08, (LOADER_ADDR + loader_stage1_32)
    .long (LOADER_ADDR + loader_stage1_32)
    .word 0x8
    
/* stage1 functions/helper */

/*
 * mb2_generate_mmap_tag (%si)
 *
 * generates the multiboot 2 mmap tag at %si
 */
mb2_generate_mmap_tag:
    pusha
    movl %esi, %edi // current end
    
    movl MULTIBOOT_TAG_TYPE_MMAP, (%di)
    movl 24, 8(%di) # entry_size
    movl 0, 12(%di) # entry_version
    addw 16, %di
    
    movl 0, %ebx
    movl BIOS_INT15_E820_SIGNATURE, %edx
    
mb2mmap_e820_read:
/*
 * BIOS call "INT 0x15 Function 0xe820" to query system address map
 *	Call with	%eax = 0xe820
 *			%ebx = continuation or 0 (at start)
 *			%ecx = buffer size (20)
 *			%edx = signature ('SMAP')
 *			%es:%di = segment:offset of buffer
 *	Return:
 *          CF on error
 *			%eax = signature ('SMAP') to verify correct BIOS revision.
 *			%ebx = continuation or 0 (if last)
 *			%ecx = bytes written to buffer
 */
    movl 0xe820, %eax
    movl 1, 20(%di)
    movl 24, %ecx
    int 0x15
    jc memory_error
    movl BIOS_INT15_E820_SIGNATURE, %edx
    cmpl %edx, %eax
    jne memory_error
    
    addl -20, %ecx
    jbe mb2mmap_e820_valid
    movl 20(%di), %eax; addl -1, %eax #// testl 1, 20(%di)
    jz  mb2mmap_e820_ignore
    
mb2mmap_e820_valid:
    movl 12(%di), %eax
    orl 8(%di), %eax
    addl 0, %eax
    jz  mb2mmap_e820_ignore
/* keep valid, non-empty entry */   
    addw 24, %di
    
mb2mmap_e820_ignore:
    addl 0, %ebx
    jnz mb2mmap_e820_read
    
/* adjust mbi_tag_mmap_size */
    movw %di, %ax
    subl %esi, %edi
    movl %edi, 4(%si)
    popa
    ret

/*
 * mb2_finalize_mbi (%si, %bx)
 *
 * generates a multiboot 2 end tag at %si and adjusts mbi size of mbi at %bx
 */
mb2_finalize_mbi:
    pusha
/* generate new end tag */
    movl MULTIBOOT_TAG_TYPE_END, (%si)
    movl 8, 4(%si)
    addw 8, %si
    
/* adjust mbi_size */
    subw %bx, %si
    movl %esi, (%bx)
    popa
    ret

/* stage1 functions/helper END */

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
    movl MULTIBOOT2_BOOTLOADER_MAGIC, %eax
    movl (LOADER_ADDR + mbi), %ebx
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
    .long   (LOADER_ADDR + gdt)

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
mod_kernel_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word MOD_KERNEL_SECTORS # count
    .word MOD_KERNEL_OFFSET  # destination offset
    .word MOD_KERNEL_SEGMENT # destination segment
    .long MOD_KERNEL_LBA     # lba block
    .long 0                  # lba block
.align 4
mod_store_disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word MOD_STORE_SECTORS # count
    .word MOD_STORE_OFFSET  # destination offset
    .word MOD_STORE_SEGMENT # destination segment
    .long MOD_STORE_LBA     # lba block
    .long 0             # lba block

/* mbi-structures */
.align MULTIBOOT_TAG_ALIGN
mbi:
    .long   0 # size (will be filled after memory-detection)
    .long   0 # reserved
mbi_tag_name:
    .long   MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME
    .long   (mbi_tag_name_end - mbi_tag_name)
    .asciz  "GridOS Loader 0.2" // LOADER_NAME
.align MULTIBOOT_TAG_ALIGN
mbi_tag_name_end:
/* TODO: generate from load dap-list instead of static startup/mod_kernel */
mbi_tag_command_line:
    .long   MULTIBOOT_TAG_TYPE_CMDLINE
    .long   (mbi_tag_command_line_end - mbi_tag_command_line)
    .asciz  "--test = 0 --debug=2 --mainThread=my::B" // STARTUP_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_command_line_end:
mbi_tag_mod_kernel:
    .long   MULTIBOOT_TAG_TYPE_MODULE
    .long   (mbi_tag_mod_kernel_end - mbi_tag_mod_kernel)
    .long   MOD_KERNEL_ADDR
    .long   (MOD_KERNEL_ADDR + MOD_KERNEL_SIZE)
    .asciz  "kernel --debug=1" // MOD_KERNEL_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_mod_kernel_end:
mbi_tag_mod_store:
    .long   MULTIBOOT_TAG_TYPE_MODULE
    .long   (mbi_tag_mod_store_end - mbi_tag_mod_store)
    .long   MOD_STORE_ADDR
    .long   (MOD_STORE_ADDR + MOD_STORE_SIZE)
    .asciz  "store --debug=1" // MOD_STORE_CMD
.align MULTIBOOT_TAG_ALIGN
mbi_tag_mod_store_end:
mbi_static_end:
/* further mb2 tags will be generated here */

/* stage1 data END*/

.align 512
loader_end:
