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
class_B_vtab_B:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
    .long 8; .long (class_A_method_init - class_A_desc); .long 12
    .long 8; .long (class_A_method_test - class_A_desc); .long 12
    .long 0; .long (class_B_method_getRow - class_B_desc); .long 4
    .long 0; .long (class_B_method_run - class_B_desc); .long 4
class_B_vtab_A:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
    .long 8; .long (class_A_method_init - class_A_desc); .long 12
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
B_m_init     := (4 * 12)
B_m_test     := (5 * 12)
B_m_getRow   := (6 * 12)
B_m_run      := (7 * 12)
// Super Vars Offsets
B_vars_A      := 0
B_vars_Object := 4

_text_run: .asciz " Run\n"
class_B_method_run:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx
    pushl %edx
    
    movl 12(%ebp), %ecx # this/B_1(Type B)

    addl -4, %esp  # return value of rt
    pushl %ecx; pushl B_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime(Type Runtime)
    
    pushl 0x40 // '@'
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 12, %esp
    
    movl handle_A_1_A, %eax # A_1(Type A)
    addl -4, %esp  # return value of getClass
    pushl %ecx; pushl B_m_getClass; call (%ecx)
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
    pushl handle_A_1_Object
    //pushl handle_B_1_Object
    pushl %ecx; pushl B_m_equals; call (%ecx)
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
    pushl %ecx; pushl B_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl B_m_test; call (%ecx)
	addl 12, %esp

    movl handle_A_1_A, %ecx # A_1(Type A)
	
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
    
class_B_method_getRow:
    pushl %ebp; movl %esp, %ebp

    movl 8(%ebp), %eax           // this.vars(B)
    addl B_vars_A(%eax), %eax    // this.vars(A)
    movl A_i_row(%eax), %eax     // row
    addl %eax, %eax              // *2
    movl %eax, 16(%ebp)          // return row*2
    
    leave
    ret

/* Static Instances */
handle_Class_B: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_B
    .long class_Class_vtab_Class
inst_Class_B:   // created on class loading
    .long (inst_Class_B_vars_Object - inst_Class_B) // @Super-Obj-Vars
    .long class_B_string_classname
inst_Class_B_vars_Object:
    
// Obj-Handles
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

// Obj-Vars/Instances
inst_B_1_vars_B:
    .long (inst_B_1_vars_A - inst_B_1_vars_B)      // @Super-Obj-Vars
    .long (inst_B_1_vars_Object - inst_B_1_vars_B) // @Super-Obj-Vars
inst_B_1_vars_A:
    .long (inst_B_1_vars_Object - inst_B_1_vars_A) // @Super-Obj-Vars
    .long 0 // column
    .long 0 // row
inst_B_1_vars_Object:
