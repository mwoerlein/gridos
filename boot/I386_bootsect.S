/*
 */

/* Konstanten */
#include "I386_bootsect_config.s"
BOOTSEG		= 0x07C0
INITSEG		= 0x7000

/* Code */
.global boot_start
.text
.data
.bss
.text

/* Bootsector erstmal in Sicherheit kopieren */
	.code16
boot_start:
    movb	%dl, boot_device        # BIOS stores boot device in %dl => remember for later
    movw    $BOOTSEG, %ax
    movw    %ax, %ds                # %ds = BOOTSEG
    movw    $INITSEG, %ax
    movw    %ax, %es                # %ax = %es = INITSEG
    movw    $256, %cx
    subw    %si, %si
    subw    %di, %di
    cld
    rep
    movsw
	ljmp    $INITSEG, $go

/* Der eigentliche Startupcode */
go:
	movw	$2048, %sp
    movb    $0x03, %ah              # read cursor pos
	xorb    %bh, %bh
    int     $0x10
	movw    $(loadmsgend-loadmsg), %cx
	movw    $0x07, %bx              # page 0, attribute 7 (normal)
	movw    $loadmsg, %bp
	movw    $0x1301, %ax            # write string, move cursor
	int     $0x10

/* JIT und Kernel-Text-Segment laden */
	xorb	%ah, %ah		# Reset d. Disketten-/Plattencontrollers
	movb	boot_device, %dl
	int	$0x13

	movb	boot_device, %dl
	movb	$JIT_HEAD, %dh
	movb	$JIT_TRACK, %ch
	movb	$JIT_SECTOR, %cl
	movw	$JIT_SEGMENT, %si
	movw	$JIT_OFFSET, %bx
	movw	$JIT_BLOCKS, %ax
	call	load_segment

#	movw	$0x0e20, %ax            # ein Leerzeichen zeichen
#	int	$0x10                   #
	
	movb	$TEXT_HEAD, %dh
	movb	$TEXT_TRACK, %ch
	movb	$TEXT_SECTOR, %cl
	movw	$TEXT_SEGMENT, %si
	movw	$TEXT_OFFSET, %bx
	movw	$TEXT_BLOCKS, %ax
	call	load_segment

	movw	$0x0e0a, %ax            # neue Zeile
	int	$0x10                   #
	movw	$0x0e0d, %ax            # neue Zeile
	int	$0x10                   #

	inb	$0x92, %al	# A20-Gate aktivieren
	orb	$2, %al
	outb	%al, $0x92

/* Interrupts abschalten */
	cli
	movb	$0x80,%al	# NMI verbieten
	outb	%al, $0x70
	
/* IDT und GDT setzen */
	lidtl	idt_48
	lgdtl	gdt_48
	
/* in den richtigen Modus wechseln */
    movw    $1, %ax                         # protected mode (PE) bit
    lmsw    %ax                             # This is it!
	jmpl    $0x08, $(INITSEG*0x10+flush_instr)

	.code32
flush_instr:
/* Segment- und Stackpointer richtig setzen */
	movl	$0x10, %eax
	movw	%ax, %ds
	movw	%ax, %es
#	movw	%ax, %fs
#	movw	%ax, %gs
	movw	%ax, %ss
	movl	$(TEXT_SEGMENT*0x10+STACK_SIZE), %ebp
	movl	%ebp, %esp

/* memlist übergeben */
	movl	$(INITSEG*0x10+memlist), %eax
/* JIT starten */
	jmpl    $0x08, $(JIT_SEGMENT*0x10)

/* loading %ax sectors from device %dh to Offset %bx in Segment %si */
	.code16
load_segment:
	movb	%dh, curr_head
	movb	%ch, curr_track
	movb	%cl, curr_sector
	movw	%si, curr_segment
	movw	%bx, curr_offset
	movw	%ax, to_load
load_next_part:
	movb	curr_head, %al
	movb	%al, last_head
	movb	curr_track, %al
	movb	%al, last_track
	movb	curr_sector, %al
	movb	%al, last_sector
	movw	curr_segment, %ax
	movw	%ax, last_segment
	movw	curr_offset, %ax
	movw	%ax, last_offset
	movw	$0, %ax
	
load_loop:
	call	step
	
	movb	curr_sector, %bl
	cmpb	$0x01, %bl
	je	load_now
	movw	curr_offset, %bx
	cmpw	$0x0000, %bx
	je	load_now
	movw	to_load, %bx
	cmpb	%bl, %al
	jne	load_loop

load_now:
	push	%ax
	movb	last_head, %dh
	movb	last_track, %ch
	movb	last_sector, %cl
	movw	last_segment, %bx
	movw	%bx, %es
	movw	last_offset, %bx
	movb	$0x02, %ah			# read sectors
	int	$0x13
	
	movw    $0x0e2e, %ax            # draw dot
	int     $0x10                   #
	pop	%ax
	
	movb	$0x00, %ah
	subw	%ax, to_load
	movw	to_load, %bx
	cmpw	$0, %bx
	jne	load_next_part
	
	ret
	
/* steps the curr_variables */
step:
	addb	$1, %al
	
	movb	curr_sector, %bl
	addb	$1, %bl
	movb	%bl, curr_sector
	cmpb	disk_sectors, %bl
	jle	step_memory
	movb	$1, %bl
	movb	%bl, curr_sector
	
	movb	curr_head, %bl
	addb	$1, %bl
	movb	%bl, curr_head
	cmpb	disk_heads, %bl
	jne	step_memory
	movb	$0, %bl
	movb	%bl, curr_head
	
	movb	curr_track, %bl
	addb	$1, %bl
	movb	%bl, curr_track
	
step_memory:
	movw	curr_offset, %bx
	addw	$0x0200, %bx
	movw	%bx, curr_offset
	cmpw	$0x0000, %bx
	jne	step_end
	movw	curr_segment, %bx
	addw	$0x1000, %bx
	movw	%bx, curr_segment

step_end:
	ret

/* Messages */
loadmsg:	.ascii LOADMESSAGE
loadmsgend:

/* Speicherplatz */
boot_device:      .byte 0
to_load:	.word 0

curr_track:	.byte 0
curr_head:	.byte 0
curr_sector:	.byte 0
curr_segment:	.word 0
curr_offset:	.word 0

last_track:	.byte 0
last_head:	.byte 0
last_sector:	.byte 0
last_segment:	.word 0
last_offset:	.word 0

/* werden irgendwann mal automatisch bestimmt */
disk_heads:	.byte DISK_HEADS
disk_tracks:	.byte DISK_TRACKS
disk_sectors:	.byte DISK_SECTORS

/* Speichernutzungstabelle memlist */
memlist:
	.long	4
	.long	INITSEG*0x10+mems
mems:
#hier liegt der JIT-Code
	.long	JIT_SEGMENT*0x10+JIT_OFFSET
	.long	JIT_SIZE

#hier liegt der Kernel-Code
	.long	TEXT_SEGMENT*0x10+TEXT_OFFSET
	.long	TEXT_SIZE
	
#hier liegt der Stack
	.long	TEXT_SEGMENT*0x10+TEXT_OFFSET+TEXT_SIZE
	.long	STACK_SIZE-TEXT_SIZE

#hierhin soll der JIT den kompilierten Kernel schreiben
	.long	JIT_SEGMENT*0x10+JIT_OFFSET+JIT_SIZE
	.long	0x10000

#hier liegt der BootSector
#	.long	INITSEG*0x10
#	.long	0x200
	
	.p2align 5
/* Descriptor-Tabellen */
gdt:
idt_48:
        .word   0, 0, 0, 0                      # dummy & idt limit = 0, idt base = 0L
	
        .word   0xFFFF                          # 4Gb - (0x100000*0x1000 = 4Gb)
        .word   0x0000                          # base address = 0
        .byte   0, 0x9A                         # code read/exec
        .byte   0xCF, 0                         # granularity = 4096, 386
                                                #  (+5th nibble of limit)

        .word   0xFFFF                          # 4Gb - (0x100000*0x1000 = 4Gb)
        .word   0x0000                          # base address = 0
        .byte   0, 0x92                         # data read/write
        .byte   0xCF, 0                         # granularity = 4096, 386
                                                #  (+5th nibble of limit)
#idt_48:
#        .word   0                               # idt limit = 0
#        .word   0, 0                            # idt base = 0L

#	.p2align 5
gdt_48:
        .word   0x18                            # gdt limit=32,
                                                #  4 GDT entries
        .long   INITSEG*0x10+gdt                # gdt base (filled in later)

.org 510
boot_flag:	.word 0xAA55
