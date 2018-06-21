#define ASM_FILE
#include "../include/multiboot2/multiboot2.h"
#include "I386_loader.h"
#define GRIDOS_BOOTSTRAP_STACK_SIZE 0x4000

.extern bootstrap
.text
.global bootstrap_start, stack, multiboot_header_address_tag, multiboot_header_entry_address_tag

.code32
bootstrap_start:
    jmp bootstrap_entry
    
/* multiboot header */
.align MULTIBOOT_TAG_ALIGN
multiboot_header:
    .long MULTIBOOT2_HEADER_MAGIC
    .long MULTIBOOT_ARCHITECTURE_I386
    .long multiboot_header_end - multiboot_header
    .long -(MULTIBOOT2_HEADER_MAGIC + MULTIBOOT_ARCHITECTURE_I386 + (multiboot_header_end - multiboot_header))

.align MULTIBOOT_TAG_ALIGN
multiboot_header_address_tag:
     .short MULTIBOOT_HEADER_TAG_ADDRESS
     .short MULTIBOOT_HEADER_TAG_OPTIONAL
     .long multiboot_header_address_tag_end - multiboot_header_address_tag
     .long   multiboot_header
     .long   bootstrap_start
     .long   _edata
     .long   _end
multiboot_header_address_tag_end:

.align MULTIBOOT_TAG_ALIGN
multiboot_header_entry_address_tag:
     .short MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS
     .short MULTIBOOT_HEADER_TAG_OPTIONAL
     .long multiboot_header_entry_address_tag_end - multiboot_header_entry_address_tag
     .long bootstrap_entry
multiboot_header_entry_address_tag_end:

.align MULTIBOOT_TAG_ALIGN
multiboot_header_tag_end:
    .short MULTIBOOT_HEADER_TAG_END
    .short 0
    .long 8
multiboot_header_end:
    
bootstrap_entry:
/* initialize IDT and GDT*/
# TODO: why does this fail?
#    lidtl   idt_48
#    lgdtl   gdt_48

/* init segment- and stack-pointer */
    movl    $0x10, %edx
    movw    %dx, %ds
    movw    %dx, %es
    movw    %dx, %fs
    movw    %dx, %gs
    movw    %dx, %ss
    movl    $(stack + GRIDOS_BOOTSTRAP_STACK_SIZE), %esp
    movl    %esp, %ebp
    
/*  Reset EFLAGS. */
    pushl   $0
    popf
    
    movl $stack, 16(%ecx)
    movl $GRIDOS_BOOTSTRAP_STACK_SIZE, 20(%ecx)

    pushl $multiboot_header # arg *mbh
    pushl %ebx              # arg *mbi
    pushl %eax              # arg magic
	pushl %ecx              # arg *memlist
	call bootstrap
_halt:
	hlt
	jmp _halt
	
/* bootstrap descriptor tables */
.p2align 5
gdt_48:
    .word   0x18        # gdt limit=32,
                        #  3 GDT entries
    .long   gdt         # gdt base (filled in later)
.p2align 5
gdt:
    .word   0, 0, 0, 0  # dummy
    
    .word   0xFFFF      # 4Gb - (0x100000*0x1000 = 4Gb)
    .word   0x0000      # base address = 0
    .byte   0, 0x9A     # code read/exec
    .byte   0xCF, 0     # granularity = 4096, 386
                        #  (+5th nibble of limit)
    
    .word   0xFFFF      # 4Gb - (0x100000*0x1000 = 4Gb)
    .word   0x0000      # base address = 0
    .byte   0, 0x92     # data read/write
    .byte   0xCF, 0     # granularity = 4096, 386
                        #  (+5th nibble of limit)
idt_48:
    .word   0           # idt limit = 0
    .word   0, 0        # idt base = 0L
    
    
    /*  bootstrap stack area. */
    .comm   stack, GRIDOS_BOOTSTRAP_STACK_SIZE
