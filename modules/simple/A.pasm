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

/* Static Instances */
handle_Class_A: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_A
    .long class_Class_vtab_Class
inst_Class_A:   // created on class loading
    .long (inst_Class_A_vars_Object - inst_Class_A) // @Super-Obj-Vars
    .long class_A_string_classname
inst_Class_A_vars_Object:    

// Obj-Handles
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

// Obj-Vars/Instances
inst_A_1_vars_A:
    .long (inst_A_1_vars_Object - inst_A_1_vars_A) // @Super-Obj-Vars
    .long 3 // column
    .long 2 // row
inst_A_1_vars_Object:
