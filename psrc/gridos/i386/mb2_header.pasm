.code32
__mb2_file_start:
    jmp __mb2_code_start
    
/* multiboot header */
.align MULTIBOOT_TAG_ALIGN
__mb2_hdr:
    .long MULTIBOOT2_HEADER_MAGIC
    .long MULTIBOOT_ARCHITECTURE_I386
    .long __mb2_hdr_len
    .long (0 - __mb2_hdr_checksum)
__mb2_hdr_len := (__mb2_hdr_end - __mb2_hdr)
__mb2_hdr_checksum := ((MULTIBOOT2_HEADER_MAGIC + MULTIBOOT_ARCHITECTURE_I386) + __mb2_hdr_len)

.align MULTIBOOT_TAG_ALIGN
__mb2_hdr_address_tag:
     .word MULTIBOOT_HEADER_TAG_ADDRESS
     .word MULTIBOOT_HEADER_TAG_OPTIONAL
     .long (__mb2_hdr_address_tag_end - __mb2_hdr_address_tag)
     .long __mb2_hdr
     .long __mb2_code_start
     .long __mb2_file_end
     .long (__mb2_file_end + GRIDOS_STARTUP_STACK_SIZE)
__mb2_hdr_address_tag_end:

.align MULTIBOOT_TAG_ALIGN
__mb2_hdr_entry_address_tag:
     .word MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS
     .word MULTIBOOT_HEADER_TAG_OPTIONAL
     .long (__mb2_hdr_entry_address_tag_end - __mb2_hdr_entry_address_tag)
     .long __mb2_code_start
__mb2_hdr_entry_address_tag_end:

.align MULTIBOOT_TAG_ALIGN
__mb2_hdr_tag_end:
    .word MULTIBOOT_HEADER_TAG_END
    .word 0
    .long 8
__mb2_hdr_end:

__mb2_code_start:
/* initialize IDT and GDT*/
    .byte 0x0f; .byte 0x01; .byte 0x1d  #//lidtl __mb2_idt_48
    .long __mb2_idt_48
    .byte 0x0f; .byte 0x01; .byte 0x15  #//lgdtl __mb2_gdt_48
    .long __mb2_gdt_48

/* init segment-register */
    .byte 0xea;                         #//fjmpl    0x08, __mb2_init_cs
    .long __mb2_init_cs
    .word 0x8
__mb2_init_cs:    
    movl    0x10, %edx
    movw    %dx, %ds
    movw    %dx, %es
    movw    %dx, %fs
    movw    %dx, %gs
    movw    %dx, %ss

/* init stack */
    movl    (__mb2_file_end + GRIDOS_STARTUP_STACK_SIZE), %esp
    movl    %esp, %ebp
    
/*  reset EFLAGS. */
    pushl   0
    popf
    
/*  call startup */
    pushl __mb2_hdr # arg *mbh
    pushl %ebx      # arg *mbi
    pushl %eax      # arg magic
    pushl 0; pushl _entry_class_desc; call _entry_global_func # call global func
    addl 20, %esp

/*  halt */
_halt:
	hlt
	jmp _halt
	
/* startup descriptor tables */
.align 32
__mb2_gdt_48:
    .word   0x18        # gdt limit=32,
                        #  3 GDT entries
    .long   __mb2_gdt   # gdt base (filled in later)
.align 32
__mb2_gdt:
    .long 0; .long 0    # dummy
    
    .word 0xFFFF        #  4Gb - (0x100000*0x1000 = 4Gb)
    .word 0x0000        # base address = 0
    .byte 0; .byte 0x9A # code read/exec
    .byte 0xCF; .byte 0 # granularity = 4096, 386
                        #  (+5th nibble of limit)
    
    .word 0xFFFF        # 4Gb - (0x100000*0x1000 = 4Gb)
    .word 0x0000        # base address = 0
    .byte 0; .byte 0x92 # code read/exec
    .byte 0xCF; .byte 0 # granularity = 4096, 386
                        #  (+5th nibble of limit)
__mb2_idt_48:
    .word 0             # idt limit = 0
    .long 0             # idt base = 0L

// TODO: extract and inject constants
GRIDOS_STARTUP_STACK_SIZE := 0x3000
MULTIBOOT_TAG_ALIGN := 8
MULTIBOOT2_HEADER_MAGIC := 0xe85250d6
MULTIBOOT_ARCHITECTURE_I386 := 0
MULTIBOOT_HEADER_TAG_ADDRESS := 2
MULTIBOOT_HEADER_TAG_OPTIONAL := 1
MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS := 3
MULTIBOOT_HEADER_TAG_END := 0

__classes_start:
