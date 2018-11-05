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
/* *** Class-Desc unres. **
 * 31                     0
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Super1-classname-Offset
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | SuperN-classname-Offset
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 */
/* **** VTab unresolved ***
 * 31                     0
 * +----------------------+
 * | Meth 0 - Var Offset
 * +----------------------+
 * | Meth 0 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | Meth 1 - Var Offset
 * +----------------------+
 * | Meth 1 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ** Class-Desc resolved *
 * 31                     0
 * +----------------------+
 * | @Class-Handle
 * +----------------------+
 * | @Class-Desc
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | @Super1-Desc
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | @SuperN-Desc
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 */
/* ***** VTab resolved ****
 * 31                     0
 * +----------------------+
 * | Meth 0 - Var Offset
 * +----------------------+
 * | Meth 0 - @Method
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | Meth 1 - Var Offset
 * +----------------------+
 * | Meth 1 - @Method
 * +----------------------+
 * | Meth 1 - Class-Desc-Offset
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
 * | Super1-Obj-Vars-Offset
 * +----------------------+
 * | Super2-Obj-Vars-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | SuperN-Obj-Vars-Offset
 * +----------------------+
 * | This-Var1
 * +----------------------+
 * | This-Var4
 * +----------------------+
 * | This-Var2 | This-Var3
 * +----------------------+
 * | S1.-Super1-Obj-Vars-Offset
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

// CLASS A extends Object
class_A_desc:
    .long handle_Class_A     # (class_A_string_classname - class_A_desc) // filled/adjusted on class loading
    .long class_A_desc       # (class_A_string_classname - class_A_desc) // filled/adjusted on class loading
    .long (class_A_vtab_A - class_A_desc)
    .long class_Object_desc  # (class_A_string_super1 - class_A_desc) // filled/adjusted on class loading
    .long (class_A_vtab_Object - class_A_desc)
    .long 0
class_A_vtab_A:
    .long 12; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_rt - class_Object_desc); .long 12
    .long 0; .long (class_A_method_run - class_A_desc); .long 4
    .long 0; .long (class_A_method_test - class_A_desc); .long 4
    .long 0; .long (class_A_method_getRow - class_A_desc); .long 4
class_A_vtab_Object:
    .long 12; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_rt - class_Object_desc); .long 12
class_A_string_classname:
    .asciz "/my/A"
class_A_string_super1:
    .asciz "/my/Object"
// Method Offsets
A_m_getClass := (0 * 12)
A_m_hash     := (1 * 12)
A_m_equals   := (2 * 12)
A_m_rt       := (3 * 12)
A_m_run      := (4 * 12)
A_m_test     := (5 * 12)
A_m_getRow   := (6 * 12)
// Vars Offsets
A_i_column := 4
A_i_row    := 8
// Super Vars Offsets
A_vars_Object := 0

_text_run: .asciz " Run\n"
class_A_method_run:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx
    pushl %edx
    
    movl 12(%ebp), %ecx # this/A_1(Type A)

    addl -4, %esp  # return value of rt
    pushl %ecx; pushl A_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime(Type Runtime)
    
    pushl 0x40 // '@'
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 12, %esp
    
    movl handle_B_1_A, %eax # B_1(Type A)
    addl -4, %esp  # return value of getClass
    pushl %ecx; pushl A_m_getClass; call (%ecx)
    //pushl %eax; pushl A_m_getClass; call (%eax)
    //pushl %edx; pushl Runtime_m_getClass; call (%edx)
	addl 8, %esp
    popl %eax // handle_Class_(A|B|Runtime) (Type Class)
/*
    addl -4, %esp  # return value of getClass
    pushl %eax; pushl Class_m_getClass; call (%eax)
	addl 8, %esp
    popl %eax // handle_Class_Class (Type Class)
*/
    addl -4, %esp  # return value of getName
    pushl %eax; pushl Class_m_getName; call (%eax)
	addl 8, %esp
    popl %eax // name cstring ref
    
    pushl %eax
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 12, %esp
    
    pushl _text_run
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 12, %esp
    
    addl -4, %esp  # return value of equals
    //pushl handle_A_1_Object
    pushl handle_B_1_Object
    pushl %ecx; pushl A_m_equals; call (%ecx)
    addl 12, %esp
    popl %eax
    
    pushl %eax
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 12, %esp
    
    addl -4, %esp  # return value of allocate
    pushl 0x124
    pushl %edx; pushl Runtime_m_allocate; call (%edx)
	addl 12, %esp
    popl %esi

    pushl 0x20 // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 12, %esp
    
    pushl %esi 
    pushl %edx; pushl Runtime_m_printHex; call (%edx)
    addl 12, %esp
    
    pushl 0x20 // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 12, %esp
    
    pushl (%esi) 
    pushl %edx; pushl Runtime_m_printHex; call (%edx)
    addl 12, %esp
    
    pushl 0x20 // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 12, %esp
    
    pushl 4(%edx) 
    pushl %edx; pushl Runtime_m_printHex; call (%edx)
    addl 12, %esp
    
    pushl 0xa // '/n'
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 12, %esp
    
    pushl %esi 
    pushl %edx; pushl Runtime_m_free; call (%edx)
    addl 12, %esp
    
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

    movl 8(%ebp), %eax          // this.vars(A)
    movl A_i_column(%eax), %eax // column
    movl 16(%ebp), %ebx         // row
    
    movl  84, %ecx; call _print; add 1, %eax // 'T'
    movl 101, %ecx; call _print; add 1, %eax // 'e'
    movl 115, %ecx; call _print; add 1, %eax // 's'
    movl 116, %ecx; call _print; add 1, %eax // 't'
    
    popl %ecx
    leave
    ret

class_A_method_getRow:
    pushl %ebp; movl %esp, %ebp

    movl 8(%ebp), %eax       // this.vars(A)
    movl A_i_row(%eax), %eax // row
    movl %eax, 16(%ebp)      // return row
    
    leave
    ret

// CLASS B extends A
class_B_desc:
    .long handle_Class_B # (class_Class_string_classname - class_B_desc) // filled/adjusted on class loading
    .long class_B_desc   # (class_Class_string_classname - class_B_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Class - class_B_desc)
    .long class_A_desc  # (class_B_string_super1 - class_B_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_B_desc)
    .long class_Object_desc  # (class_B_string_super2 - class_B_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_B_desc)
    .long 0
class_B_vtabs: // filled/adjusted on class loading
class_B_vtab_B:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
    .long 8; .long (class_A_method_run - class_A_desc); .long 12
    .long 8; .long (class_A_method_test - class_A_desc); .long 12
    .long 0; .long (class_B_method_getRow - class_B_desc); .long 4
class_B_vtab_A:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
    .long 8; .long (class_A_method_run - class_A_desc); .long 12
    .long 8; .long (class_A_method_test - class_A_desc); .long 12
    .long 0; .long (class_B_method_getRow - class_B_desc); .long 4
class_B_vtab_Object:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
class_B_string_classname:
    .asciz "/my/B"
class_B_string_super1:
    .asciz "/my/A"
class_B_string_super2:
    .asciz "/my/Object"
// Method Offsets
B_m_getClass := (0 * 12)
B_m_hash     := (1 * 12)
B_m_equals   := (2 * 12)
B_m_rt       := (3 * 12)
B_m_run      := (4 * 12)
B_m_test     := (5 * 12)
B_m_getRow   := (6 * 12)
// Super Vars Offsets
B_vars_A      := 0
B_vars_Object := 4

class_B_method_getRow:
    pushl %ebp; movl %esp, %ebp

    movl 8(%ebp), %eax           // this.vars(B)
    addl B_vars_A(%eax), %eax    // this.vars(A)
    movl A_i_row(%eax), %eax     // row
    addl %eax, %eax              // *2
    movl %eax, 16(%ebp)          // return row*2
    
    leave
    ret


/* Obj-Handles */
handle_A_1_A:
    .long _call_entry_unresolved_vtab
    .long class_A_desc
    .long inst_A_1_vars_A
    .long class_A_vtab_A

handle_A_1_Object:
    .long _call_entry_unresolved_vtab
    .long class_A_desc
    .long inst_A_1_vars_A
    .long class_A_vtab_Object

handle_B_1_B:
    .long _call_entry_unresolved_vtab
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_B

handle_B_1_A:
    .long _call_entry_unresolved_vtab
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_A

handle_B_1_Object:
    .long _call_entry_unresolved_vtab
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_Object


/* Obj-Vars/Instances */
inst_A_1_vars_A:
    .long (inst_A_1_vars_Object - inst_A_1_vars_A) // @Super-Obj-Vars
    .long 3 // column
    .long 2 // row
inst_A_1_vars_Object:

inst_B_1_vars_B:
    .long (inst_B_1_vars_A - inst_B_1_vars_B)      // @Super-Obj-Vars
    .long (inst_B_1_vars_Object - inst_B_1_vars_B) // @Super-Obj-Vars
inst_B_1_vars_A:
    .long (inst_B_1_vars_Object - inst_B_1_vars_A) // @Super-Obj-Vars
    .long 10 // column
    .long 2 // row
inst_B_1_vars_Object:


// TODO: #9 improve/separate runtime injection
/* RUNTIME */
    
// CLASS Runtime extends Object
class_Runtime_desc:
    .long handle_Class_Runtime # (class_Runtime_string_classname - class_Runtime_desc) // filled/adjusted on class loading
    .long class_Runtime_desc   # (class_Runtime_string_classname - class_Runtime_desc) // filled/adjusted on class loading
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
    .long class_Object_desc    # (class_Runtime_string_super1 - class_Runtime_desc) // filled/adjusted on class loading
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
    .long 0
class_Runtime_vtab_Runtime:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
    .long 0; .long (class_Runtime_method_allocate - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_free - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printChar - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printString - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printInt - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printHex - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errChar - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errString - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errInt - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errHex - class_Runtime_desc); .long 4
class_Runtime_vtab_Object:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
class_Runtime_string_classname:
    .asciz "/my/Runtime"
class_Runtime_string_super1:
    .asciz "/my/Object"
// Method Offsets
Runtime_m_getClass    := ( 0 * 12)
Runtime_m_hash        := ( 1 * 12)
Runtime_m_equals      := ( 2 * 12)
Runtime_m_rt          := ( 3 * 12)
Runtime_m_allocate    := ( 4 * 12)
Runtime_m_free        := ( 5 * 12)
Runtime_m_printChar   := ( 6 * 12)
Runtime_m_printString := ( 7 * 12)
Runtime_m_printInt    := ( 8 * 12)
Runtime_m_printHex    := ( 9 * 12)
Runtime_m_errChar     := (10 * 12)
Runtime_m_errString   := (11 * 12)
Runtime_m_errInt      := (12 * 12)
Runtime_m_errHex      := (13 * 12)
// Vars Offsets
// Super Vars Offsets
Runtime_vars_Object := 0

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
    .long _call_entry_unresolved_vtab
    .long class_Runtime_desc
    .long inst_Runtime
    .long class_Runtime_vtab_Runtime
inst_Runtime:
    .long (inst_Runtime_vars_Object - inst_Runtime)
inst_Runtime_vars_Object:

// TODO: #9 improve/separate RTTI
/* Core/RTTI */
    
// Class Object
class_Object_desc:
    .long handle_Class_Object # (class_Object_string_classname - class_Object_desc) // filled/adjusted on class loading
    .long class_Object_desc   # (class_Object_string_classname - class_Object_desc) // filled/adjusted on class loading
    .long (class_Object_vtab_Object - class_Object_desc)
    .long 0
class_Object_vtab_Object:
    .long 0; .long (class_Object_method_getClass - class_Object_desc); .long 4
    .long 0; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 0; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 0; .long (class_Object_method_rt - class_Object_desc); .long 12
class_Object_string_classname:
    .asciz "/my/Object"
// Method Offsets
Object_m_getClass := (0 * 12)
Object_m_hash     := (1 * 12)
Object_m_equals   := (2 * 12)
Object_m_rt       := (3 * 12)
// Vars Offsets

class_Object_method_getClass:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this
    movl 4(%eax), %eax     // @class desc
    movl (%eax), %eax      // @class handle
    movl %eax, 16(%ebp)    // return @class handle
    
    leave
    ret

class_Object_method_hash:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this
    movl 8(%eax), %eax     // @this.vars(<class>)
    movl %eax, 16(%ebp)    // return obj vars as hash
    
    leave
    ret

class_Object_method_equals:
    pushl %ebp; movl %esp, %ebp;
    
    movl 0, 20(%ebp)       // default return: false

    movl 12(%ebp), %eax    // @this
    movl 8(%eax), %eax     // @this.vars(<class>)
    
    movl 16(%ebp), %ebx    // @obj
    movl 8(%ebx), %ebx     // @obj.vars(<class>)
    .byte 0x29; .byte 0xc3 #// subl %eax, %ebx
    
    jnz class_Object_method_equals_ret
    movl 1, 20(%ebp)       // return true
        
class_Object_method_equals_ret:    
    leave
    ret

class_Object_method_rt:
    pushl %ebp; movl %esp, %ebp;

// TODO: #9 improve/separate runtime injection
    movl handle_Runtime, 16(%ebp)    // return @runtime handle
    
    leave
    ret

// CLASS Class extends Object
class_Class_desc:
    .long handle_Class_Class # (class_Class_string_classname - class_Class_desc) // filled/adjusted on class loading
    .long class_Class_desc   # (class_Class_string_classname - class_Class_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Class - class_Class_desc)
    .long class_Object_desc  # (class_Class_string_super1 - class_Class_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_Class_desc)
    .long 0
class_Class_vtab_Class:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
    .long 0; .long (class_Class_method_getName - class_Class_desc); .long 4
class_Class_vtab_Object:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
class_Class_string_classname:
    .asciz "/my/Class"
class_Class_string_super1:
    .asciz "/my/Object"
    
// Method Offsets
Class_m_getClass   := (0 * 12)
Class_m_hash       := (1 * 12)
Class_m_equals     := (2 * 12)
Class_m_rt         := (3 * 12)
Class_m_getName    := (4 * 12)
// Vars Offsets
Class_i_name := 4
// Super Vars Offsets
Class_vars_Object := 0

class_Class_method_getName:
    pushl %ebp; movl %esp, %ebp;

    movl 8(%ebp), %eax            // this.vars(Class)
    movl Class_i_name(%eax), %eax // load reference to cstring-ref
    movl %eax, 16(%ebp)           // return cstring-ref
    
    leave
    ret

handle_Class_Object: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_Object
    .long class_Class_vtab_Class
inst_Class_Object:   // created on class loading
    .long (inst_Class_Object_vars_Object - inst_Class_Object) // @Super-Obj-Vars
    .long class_Object_string_classname
inst_Class_Object_vars_Object:    

handle_Class_Class: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_Class
    .long class_Class_vtab_Class
inst_Class_Class:   // created on class loading
    .long (inst_Class_Class_vars_Object - inst_Class_Class) // @Super-Obj-Vars
    .long class_Class_string_classname
inst_Class_Class_vars_Object:    

handle_Class_Runtime: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_Runtime
    .long class_Class_vtab_Class
inst_Class_Runtime:   // created on class loading
    .long (inst_Class_Runtime_vars_Object - inst_Class_Runtime) // @Super-Obj-Vars
    .long class_Runtime_string_classname
inst_Class_Runtime_vars_Object:    

handle_Class_A: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_A
    .long class_Class_vtab_Class
inst_Class_A:   // created on class loading
    .long (inst_Class_A_vars_Object - inst_Class_A) // @Super-Obj-Vars
    .long class_A_string_classname
inst_Class_A_vars_Object:    

handle_Class_B: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_B
    .long class_Class_vtab_Class
inst_Class_B:   // created on class loading
    .long (inst_Class_B_vars_Object - inst_Class_B) // @Super-Obj-Vars
    .long class_B_string_classname
inst_Class_B_vars_Object:    


/* STATIC HELPER */
_call_entry_resolved_vtab:
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%esp), %eax	        # get method-offset number
	addl 12(%ebx), %eax         # get vtab-entry
	movl 8(%ebx), %ebx          # load obj vars
	addl 0(%eax), %ebx          # add var offset
	movl %ebx, 4(%esp)          # store vars in stack
	jmp 4(%eax)                 # goto method

_call_entry_unresolved_vtab:
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%esp), %eax	        # get method-offset number
	addl 12(%ebx), %eax         # get vtab-entry
	
	movl 8(%ebx), %ebx          # load obj vars
	addl 0(%eax), %ebx          # add var offset
	movl %ebx, 4(%esp)          # store vars in stack
	
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%ebx), %ebx	        # get class-desc
	addl 8(%eax), %ebx          # get method-class-desc-addr
	movl (%ebx), %ebx           # get method-class-desc
	addl 4(%eax), %ebx          # compute method-addr
	jmp %ebx                    # goto method

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
