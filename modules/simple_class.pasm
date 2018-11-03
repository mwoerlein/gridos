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
    pushl %ecx; pushl A_m_run; call (%ecx)
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
// Method IDs
A_m_run    := 0
A_m_test   := 1
A_m_getRow := 2
// Vars IDs
A_i_column := 0
A_i_row    := 4

_text_run: .asciz "Run\n"
class_A_method_run:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx
    pushl %edx
    
    movl handle_Runtime, %ecx # Runtime(Type Runtime)
    
    pushl 0x40 // '@'
    pushl %ecx; pushl Runtime_m_printChar; call (%ecx)
    addl 12, %esp
    
    pushl _text_run
    pushl %ecx; pushl Runtime_m_printString; call (%ecx)
    addl 12, %esp

    addl -4, %esp  # return value of allocate
    pushl 0x124
    pushl %ecx; pushl Runtime_m_allocate; call (%ecx)
	addl 12, %esp
    popl %edx
    
    pushl %edx 
    pushl %ecx; pushl Runtime_m_printHex; call (%ecx)
    addl 12, %esp
    
    pushl 0x20 // ' '
    pushl %ecx; pushl Runtime_m_printChar; call (%ecx)
    addl 12, %esp
    
    pushl (%edx) 
    pushl %ecx; pushl Runtime_m_printHex; call (%ecx)
    addl 12, %esp
    
    pushl 0x20 // ' '
    pushl %ecx; pushl Runtime_m_printChar; call (%ecx)
    addl 12, %esp
    
    pushl 4(%edx) 
    pushl %ecx; pushl Runtime_m_printHex; call (%ecx)
    addl 12, %esp
    
    pushl 0xa // '/n'
    pushl %ecx; pushl Runtime_m_printChar; call (%ecx)
    addl 12, %esp
    
    pushl %edx 
    pushl %ecx; pushl Runtime_m_free; call (%ecx)
    addl 12, %esp
    
    movl 12(%ebp), %ecx # this/A_1(Type A)
    
    addl -4, %esp  # return value of getRow
    pushl %ecx; pushl A_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl A_m_test; call (%ecx)
	addl 12, %esp

    movl handle_B_1_A, %ecx # B_1(Type A)
	
    addl -4, %esp  # return value of getRow
    pushl %ecx; pushl A_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl A_m_test; call (%ecx)
	addl 12, %esp
	
    popl %edx
    popl %ecx
    leave
    ret

class_A_method_test:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx

    movl 8(%ebp), %ecx   // this.vars(A)
    movl A_i_column(%ecx), %edx
    
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
    leave
    ret

class_A_method_getRow:
    pushl %ebp; movl %esp, %ebp
    push %ecx

    movl 8(%ebp), %ecx   // this.vars(A)
    
    movl A_i_row(%ecx), %eax
    movl %eax, 16(%ebp)  // return
    
    pop %ecx
    leave
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
// Method IDs
B_m_run    := 0
B_m_test   := 1
B_m_getRow := 2
// Super Vars Offsets
B_vars_Dummy := 0
B_vars_A     := 0

class_B_method_getRow:
    pushl %ebp; movl %esp, %ebp
    push %ecx

    movl 8(%ebp), %ecx   // this.vars(B)
    movl B_vars_A(%ecx), %ecx    // this.vars(A)
    
    movl A_i_row(%ecx), %eax
    addl %eax, %eax      // *2
    movl %eax, 16(%ebp)  // return
    
    pop %ecx
    leave
    ret
    
// CLASS Dummy
class_Dummy_name: .asciz "/my/Dummy"
class_Dummy_desc:
    .long class_Dummy_name
    .long class_Dummy_vtabs
class_Dummy_vtabs:
// Method IDs


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


// TODO: #9 improve/separate runtime injection
/* RUNTIME */
    
// CLASS Runtime
class_Runtime_name: .asciz "/my/Runtime"
class_Runtime_desc:
    .long class_Runtime_name
    .long class_Runtime_vtabs
class_Runtime_vtabs:
class_Runtime_vtab_Runtime:
    .long 0; .long class_Runtime_method_allocate
    .long 0; .long class_Runtime_method_free
    .long 0; .long class_Runtime_method_printChar
    .long 0; .long class_Runtime_method_printString
    .long 0; .long class_Runtime_method_printInt
    .long 0; .long class_Runtime_method_printHex
    .long 0; .long class_Runtime_method_errChar
    .long 0; .long class_Runtime_method_errString
    .long 0; .long class_Runtime_method_errInt
    .long 0; .long class_Runtime_method_errHex
// Method IDs
Runtime_m_allocate    := 0
Runtime_m_free        := 1
Runtime_m_printChar   := 2
Runtime_m_printString := 3
Runtime_m_printInt    := 4
Runtime_m_printHex    := 5
Runtime_m_errChar     := 6
Runtime_m_errString   := 7
Runtime_m_errInt      := 8
Runtime_m_errHex      := 9

class_Runtime_method_allocate:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param size
    pushl _env_allocator; call _allocator_allocate
    addl 8, %esp
    movl %eax, 20(%ebp)  // return info
    
    popad; leave
    ret

class_Runtime_method_free:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param info
    pushl _env_allocator; call _allocator_free
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printChar:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param c
    pushl _env_out; call _ostream_print_char
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printString:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param s
    pushl _env_out; call _ostream_print_string
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printInt:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_out; call _ostream_print_int
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printHex:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_out; call _ostream_print_hex
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errChar:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param c
    pushl _env_err; call _ostream_print_char
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errString:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param s
    pushl _env_err; call _ostream_print_string
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errInt:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_err; call _ostream_print_int
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errHex:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_err; call _ostream_print_hex
    addl 8, %esp
    
    popad; leave
    ret

handle_Runtime:
    .long _call_entry
    .long class_Runtime_desc
    .long inst_Runtime
    .long class_Runtime_vtab_Runtime
inst_Runtime:


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
