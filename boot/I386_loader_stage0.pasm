.code16
loader_start:
    cli
    .byte 0xea;              #//fjmpw    BIOS_BOOTSECTOR_SEGMENT, loader_stage0
    .word loader_stage0
    .word BIOS_BOOTSECTOR_SEGMENT

/* prepare loader */
loader_stage0:
/* set up the REAL stack */
    movw 0, %ax
    movw %ax, %ss
    movw LOADER_STACK_ADDR, %sp
/* setup segment registers */
    movw BIOS_BOOTSECTOR_SEGMENT, %ax
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
    movw LOADER_SEGMENT, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    
/* BIOS stores boot device in %dl => remember for later */    
    movb %dl, (boot_device)
    .byte 0xea;              #//fjmpw    LOADER_SEGMENT, loader_stage1
    .word loader_stage1
    .word LOADER_SEGMENT

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
    pushw %es
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
    popw %es
    popad
    ret

ls_chs_load:
    /* %si = dap address */
    movl 0, %edi
    addw 2(%si), %di              # segments to read
    jnz ls_chs_check_max
    popw %es
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

/* stage0 data */
.align 4
disk_address_packet:
    .byte 0x10
    .byte 0x0
    .word LOADER_SECTORS  # count
    .word LOADER_OFFSET   # destination offset
    .word LOADER_SEGMENT  # destination segment
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

.org LOADER_MPT_START
.org LOADER_MPT_END
    .word LOADER_MBR_SIGNATURE
