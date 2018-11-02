/*[meta]
mimetype = text/x-pasm
description = Dies ist ein erster Test mit einfacher Klasse
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
*/
/* ********* ABI **********
 * caller-saved: %eax, %ebx
 * callee-saved: Rest
 * Stack-Frame:
 * | caller prepared                                                      | call          | callee prepared                           :
 * |Ret N|...|Ret 2|Ret 1|Param N|...|Param 2|Param 1|@Obj-Handle|Method #|@caller return |caller %ebp|Local 1|Local 2|...|stored regs|further Frames
 *                                                                                                    ^callee %ebp                    ^callee %esp
 */
/* ****** Class-Desc ******
 * 31                     0
 * +----------------------+
 * | @Class-Name
 * +----------------------+
 * | @VTabs
 * +----------------------+
 * | Class-VTab
 * +----------------------+
 * | Parent1-VTab
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ********* VTab *********
 * 31                     0
 * +----------------------+
 * | Meth 0 - @Method
 * +----------------------+
 * | Meth 1 - @Method
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ****** Obj-Handle ******
 * +----------------------+
 * | @Call-Entry
 * +----------------------+
 * | @Obj-Class-Desc
 * +----------------------+
 * | @Obj-Class-Vars
 * +----------------------+
 * | @Ref-Class-VTab
 * +----------------------+
 * | @Ref-Obj-Vars
 * +----------------------+
 */
/* ******* Obj-Vars *******
 * +----------------------+
 * | @Parent-Obj-Vars|0
 * +----------------------+
 * | @Next-Obj-Vars|0
 * +----------------------+
 * | This-Var1
 * +----------------------+
 * | This-Var4
 * +----------------------+
 * | This-Var2 | This-Var3
 * +----------------------+
 * | @P.-Parent-Obj-Vars|0
 * +----------------------+
 * | @P.-Next-Obj-Vars|0
 * +----------------------+
 * | Parent-Var1
 * +----------------------+
 * | ...
 * +----------------------+
 */
 
/* STARTUP */
entry:
    movw 0xc40, (cga_testline)
    
    // load init object handle
	movl handle_A_1_A, %ecx
	// call "run"
    pushl %ecx
	pushl 0        # method number
	call (%ecx)
	addl 8, %esp

    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt


/* CLASSES */
class_A_name: .asciz "/my/A"
class_A_desc:
    .long class_A_name
    .long class_A_vtabs
class_A_vtabs:
class_A_vtab_A:
    .long class_A_method_run
    .long class_A_method_test
    .long class_A_method_getRow

class_A_method_run:
    pushl %ebp
    movl %esp, %ebp
    pushl %ecx
    
    movl 0, %eax  // column 0
    movl 0, %ebx  // row 0
    movl 82, %ecx // 'R'
    call _print
    
    movl 1, %eax  // column 1
    movl 0, %ebx  // row 0
    movl 117, %ecx // 'u'
    call _print
    
    movl 2, %eax  // column 1
    movl 0, %ebx  // row 0
    movl 110, %ecx // 'n'
    call _print
    
    addl -4, %esp  # return value of getRow
    movl 12(%ebp), %ecx
    pushl %ecx     # this
	pushl 2        # method number
	call (%ecx)
	addl 8, %esp
    
    popl %eax
    
    pushl %eax     # row
    movl 12(%ebp), %ecx
    pushl %ecx     # this
	pushl 1        # method number
	call (%ecx)
	addl 12, %esp
    
    popl %ecx
    .byte 0xc9 #// leave
    ret

class_A_method_test:
    pushl %ebp
    movl %esp, %ebp
    pushl %ecx
    
    movl 0, %eax  // column 0
    movl 16(%ebp), %ebx  // row
    movl 84, %ecx // 'T'
    call _print
    
    movl 1, %eax  // column 1
    movl 16(%ebp), %ebx  // row
    movl 101, %ecx // 'e'
    call _print
    
    movl 2, %eax  // column 1
    movl 16(%ebp), %ebx  // row
    movl 115, %ecx // 's'
    call _print
    
    movl 3, %eax  // column 1
    movl 16(%ebp), %ebx  // row
    movl 116, %ecx // 't'
    call _print
    
    popl %ecx
    .byte 0xc9 #// leave
    ret

class_A_method_getRow:
    pushl %ebp
    movl %esp, %ebp
    
    movl 8, %eax  # row
    movl %eax, 16(%ebp)
    
    .byte 0xc9 #// leave
    ret

/* Obj-Handles */
handle_A_1_A:
    .long _call_entry
    .long class_A_desc
    .long inst_A_1_vars
    .long class_A_vtab_A
    .long inst_A_1_vars

/* Obj-Vars/Instances */
inst_A_1_vars:
    .long 0 // @Parent-Obj-Vars
    .long 0 // @Next-Obj-Vars

/* STATIC HELPER */
_call_entry:
	movl 4(%esp), %ebx	# get method number
	movl 8(%esp), %eax	# load object handle
	movl 12(%eax), %eax	# get vtab
	jmp (%eax, %ebx, 4)

_print: # %eax:column, %ebx:row, %cl:character
    pushl %ebx
    pushl %ecx
	.byte 0x69; .byte 0xdb; .long print_line_offset #// imull print_line_offset, %ebx
	movb print_cga_color, %ch
	movw %cx, print_cga_buffer(%ebx,%eax,2)
	popl %ecx
	popl %ebx
	ret
	
print_cga_buffer  := 0xB8000
print_line_offset := 160
print_cga_color   := 15

cga_testline  := (print_cga_buffer + (10*print_line_offset))
