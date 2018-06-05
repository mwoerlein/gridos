#include "I386_loader.h"
#define GRIDOS_BOOTSTRAP_STACK_SIZE 0x4000

.extern bootstrap
.text
.global bootstrap_start

.code32
bootstrap_start:
    jmp bootstrap_entry
    
/* multiboot header */
.align 8
multiboot_header:
    .long GRIDOS_MULTIBOOT2_HEADER_MAGIC
    .long GRIDOS_MULTIBOOT2_HEADER_ARCH_I386
    .long multiboot_header_end - multiboot_header
    .long -(GRIDOS_MULTIBOOT2_HEADER_MAGIC + GRIDOS_MULTIBOOT2_HEADER_ARCH_I386 + (multiboot_header_end - multiboot_header))
multiboot_header_end:
    
bootstrap_entry:
    pushl $multiboot_header # arg *mbh
    pushl %ebx              # arg *mbi
    pushl %eax              # arg magic
	pushl %ecx              # arg *memlist
	call bootstrap
_halt:
	hlt
	jmp _halt
