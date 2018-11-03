/*[meta]
mimetype = text/x-pasm
description = Dies ist ein erster Test mit Klassen
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
*/
/* ********* ABI **********
 * caller-saved: %eax, %ebx
 * callee-saved: others
 * Stack-Frame:
 * | caller prepared                                                                | call         | callee prepared                          :
 * |Ret N|...|Ret 2|Ret 1|Param N|...|Param 2|Param 1|@Obj-Handle|Method #/@Obj-Vars|@caller return|caller %ebp|Local 1|Local 2|...|saved regs|tmp-data/further frames
 *                                                                                                             ^callee %ebp                   ^callee %esp
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
 * | Super1-VTab
 * +----------------------+
 * | ...
 * +----------------------+
 * | SuperN-VTab
 * +----------------------+
 */
/* ********* VTab *********
 * 31                     0
 * +----------------------+
 * | Meth 0 - Var Offset
 * +----------------------+
 * | Meth 0 - @Method
 * +----------------------+
 * | Meth 1 - Var Offset
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
 */
/* ******* Obj-Vars *******
 * +----------------------+
 * | @Super1-Obj-Vars
 * +----------------------+
 * | @Super2-Obj-Vars
 * +----------------------+
 * | ...
 * +----------------------+
 * | @SuperN-Obj-Vars
 * +----------------------+
 * | This-Var1
 * +----------------------+
 * | This-Var4
 * +----------------------+
 * | This-Var2 | This-Var3
 * +----------------------+
 * | @S1.-Super1-Obj-Vars
 * +----------------------+
 * | Super1-Var1
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

// CLASS A
class_A_name: .asciz "/my/A"
class_A_desc:
    .long class_A_name
    .long class_A_vtabs
class_A_vtabs:
class_A_vtab_A:
    .long 0; .long class_A_method_run
    .long 0; .long class_A_method_test
    .long 0; .long class_A_method_getRow

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
    
    movl 12(%ebp), %ecx # this/A_1(Type A)
    
    addl -4, %esp  # return value of getRow
    pushl %ecx; pushl 2; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl 1; call (%ecx)
	addl 12, %esp

    movl handle_B_1_A, %ecx # B_1(Type A)
	
    addl -4, %esp  # return value of getRow
    pushl %ecx; pushl 2; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl 1; call (%ecx)
	addl 12, %esp
	
    popl %ecx
    .byte 0xc9 #// leave
    ret

class_A_method_test:
    pushl %ebp
    movl %esp, %ebp
    pushl %ecx

    movl 8(%ebp), %ecx   // this.vars(A)
    movl (%ecx), %edx    // column
    
    movl %edx, %eax      // column
    movl 16(%ebp), %ebx  // row
    movl 84, %ecx        // 'T'
    call _print
    add 1, %edx
    
    movl %edx, %eax      // column
    movl 16(%ebp), %ebx  // row
    movl 101, %ecx       // 'e'
    call _print
    add 1, %edx
    
    movl %edx, %eax      // column
    movl 16(%ebp), %ebx  // row
    movl 115, %ecx       // 's'
    call _print
    add 1, %edx
    
    movl %edx, %eax      // column
    movl 16(%ebp), %ebx  // row
    movl 116, %ecx       // 't'
    call _print
    add 1, %edx
    
    popl %ecx
    .byte 0xc9 #// leave
    ret

class_A_method_getRow:
    pushl %ebp
    movl %esp, %ebp
    push %ecx

    movl 8(%ebp), %ecx   // this.vars(A)
    
    movl 4(%ecx), %eax   // row
    movl %eax, 16(%ebp)  // return
    
    pop %ecx
    .byte 0xc9 #// leave
    ret

// CLASS B
class_B_name: .asciz "/my/B" // extends Dummy, A
class_B_desc:
    .long class_B_name
    .long class_B_vtabs
class_B_vtabs:
class_B_vtab_B:
    .long 8; .long class_A_method_run
    .long 8; .long class_A_method_test
    .long 0; .long class_B_method_getRow
class_B_vtab_Dummy:
class_B_vtab_A:
    .long 8; .long class_A_method_run
    .long 8; .long class_A_method_test
    .long 0; .long class_B_method_getRow

class_B_method_getRow:
    pushl %ebp
    movl %esp, %ebp
    push %ecx

    movl 8(%ebp), %ecx   // this.vars(B)
    movl (%ecx), %ecx    // this.vars(A)
    
    movl 4(%ecx), %eax   // row
    addl %eax, %eax      // *2
    movl %eax, 16(%ebp)  // return
    
    pop %ecx
    .byte 0xc9 #// leave
    ret
    
// CLASS Dummy
class_Dummy_name: .asciz "/my/Dummy"
class_Dummy_desc:
    .long class_Dummy_name
    .long class_Dummy_vtabs
class_Dummy_vtabs:


/* Obj-Handles */
handle_A_1_A:
    .long _call_entry
    .long class_A_desc
    .long inst_A_1_vars_A
    .long class_A_vtab_A

handle_B_1_B:
    .long _call_entry
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_B

handle_B_1_A:
    .long _call_entry
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_A


/* Obj-Vars/Instances */
inst_A_1_vars_A:
    .long 3 // column
    .long 2 // row

inst_B_1_vars_B:
    .long inst_B_1_vars_Dummy // @Super-Obj-Vars
    .long inst_B_1_vars_A     // @Super-Obj-Vars
inst_B_1_vars_Dummy:
inst_B_1_vars_A:
    .long 10 // column
    .long 2 // row


/* STATIC HELPER */
_call_entry:
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%esp), %eax	        # get method number
	.byte 0x6b; .byte 0xc0; .byte 0x08 #// imull 8, %eax
	addl 12(%ebx), %eax         # get vtab-entry
	movl 8(%ebx), %ebx          # load obj vars
	addl 0(%eax), %ebx          # add var offset
	movl %ebx, 4(%esp)          # store vars in stack
	jmp 4(%eax)                 # goto method

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
test_row := 10
cga_testline  := (print_cga_buffer + (test_row * print_line_offset))
