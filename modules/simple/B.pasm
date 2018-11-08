// CLASS B extends A
class_B_desc:
    .long inst_Class_B_handle_Class # (class_Class_string_classname - class_B_desc) // filled/adjusted on class loading
    .long (class_B_inst_tpl_end - class_B_inst_tpl) // instance size
    .long (class_B_inst_tpl - class_B_desc)         // instance template offset
    .long (class_B_inst_tpl_handle_Object - class_B_inst_tpl)   // handle offset in instance 
class_B_vtabs:
class_B_vtabs_entry_B:
    .long class_B_desc   # (class_Class_string_classname - class_B_desc) // filled/adjusted on class loading
    .long (class_B_vtab_B - class_B_desc)
class_B_handle_B:
    .long (class_B_inst_tpl_handle_B - class_B_inst_tpl)        // handle offset in instance 
class_B_vtabs_entry_A:
    .long class_A_desc  # (class_B_string_super1 - class_B_desc) // filled/adjusted on class loading
    .long (class_B_vtab_A - class_B_desc)
class_B_handle_A:
    .long (class_B_inst_tpl_handle_A - class_B_inst_tpl)        // handle offset in instance 
class_B_vtabs_entry_Object:
    .long class_Object_desc  # (class_B_string_super2 - class_B_desc) // filled/adjusted on class loading
    .long (class_B_vtab_Object - class_B_desc)
class_B_handle_Object:
    .long (class_B_inst_tpl_handle_Object - class_B_inst_tpl)   // handle offset in instance 
class_B_vtab_end_entry:
    .long 0
    .long 0
    .long 0
class_B_vtab_B:
class_B_vtab_B_method_getClass:
    .long (class_Object_method_getClass - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
class_B_vtab_B_method_hash:
    .long (class_Object_method_hash - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
class_B_vtab_B_method_equals:
    .long (class_Object_method_equals - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
class_B_vtab_B_method_rt:
    .long (class_Object_method_rt - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
class_B_vtab_B_method_init:
    .long (class_A_method_init - class_A_desc); .long (class_B_vtabs_entry_A - class_B_desc)
class_B_vtab_B_method_test:
    .long (class_A_method_test - class_A_desc); .long (class_B_vtabs_entry_A - class_B_desc)
class_B_vtab_B_method_getRow:
    .long (class_B_method_getRow - class_B_desc); .long (class_B_vtabs_entry_B - class_B_desc)
class_B_vtab_B_method_run:
    .long (class_B_method_run - class_B_desc); .long (class_B_vtabs_entry_B - class_B_desc)
class_B_vtab_A:
    .long (class_Object_method_getClass - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_Object_method_hash - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_Object_method_equals - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_Object_method_rt - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_A_method_init - class_A_desc); .long (class_B_vtabs_entry_A - class_B_desc)
    .long (class_A_method_test - class_A_desc); .long (class_B_vtabs_entry_A - class_B_desc)
    .long (class_B_method_getRow - class_B_desc); .long (class_B_vtabs_entry_B - class_B_desc)
class_B_vtab_Object:
    .long (class_Object_method_getClass - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_Object_method_hash - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_Object_method_equals - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)
    .long (class_Object_method_rt - class_Object_desc); .long (class_B_vtabs_entry_Object - class_B_desc)

class_B_inst_tpl:
    .long class_B_desc                      // filled/adjusted on class loading
    .long 0  // B_inst_meminfo              // filled during instatiation
class_B_inst_tpl_handle_B:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // B_inst                      // filled during instatiation
    .long (class_B_vtab_B - class_B_desc)
class_B_inst_tpl_handle_B_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl) // @Super-Obj-Vars
class_B_inst_tpl_handle_B_vars_A:
    .long (class_B_inst_tpl_vars_A - class_B_inst_tpl)      // @Super-Obj-Vars
class_B_inst_tpl_handle_B_vars_B:
    .long (class_B_inst_tpl_vars_B - class_B_inst_tpl)      // @B-Obj-Vars
class_B_inst_tpl_handle_A:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // B_inst                      // filled during instatiation
    .long (class_B_vtab_A - class_B_desc)
class_B_inst_tpl_handle_A_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl) // @Super-Obj-Vars
class_B_inst_tpl_handle_A_vars_A:
    .long (class_B_inst_tpl_vars_A - class_B_inst_tpl)      // @A-Obj-Vars
class_B_inst_tpl_handle_Object:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // B_inst                      // filled during instatiation
    .long (class_B_vtab_Object - class_B_desc)
class_B_inst_tpl_handle_Object_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl) // @Object-Obj-Vars
class_B_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_B_inst_tpl_vars_A:
    .long 0 // column
    .long 0 // row
class_B_inst_tpl_vars_B:
class_B_inst_tpl_end:

class_B_string_classname:
    .asciz "/my/B"
class_B_string_super1:
    .asciz "/my/A"
class_B_string_super2:
    .asciz "/my/Object"
// Method Offsets
B_m_getClass := (class_B_vtab_B_method_getClass - class_B_vtab_B)
B_m_hash     := (class_B_vtab_B_method_hash - class_B_vtab_B)
B_m_equals   := (class_B_vtab_B_method_equals - class_B_vtab_B)
B_m_rt       := (class_B_vtab_B_method_rt - class_B_vtab_B)
B_m_init     := (class_B_vtab_B_method_init - class_B_vtab_B)
B_m_test     := (class_B_vtab_B_method_test - class_B_vtab_B)
B_m_getRow   := (class_B_vtab_B_method_getRow - class_B_vtab_B)
B_m_run      := (class_B_vtab_B_method_run - class_B_vtab_B)
// Vars Offsets
// Super Vars Offsets
handle_B_vars_B      := (class_B_inst_tpl_handle_B_vars_B - class_B_inst_tpl_handle_B)
handle_B_vars_A      := (class_B_inst_tpl_handle_B_vars_A - class_B_inst_tpl_handle_B)
handle_B_vars_Object := (class_B_inst_tpl_handle_B_vars_Object - class_B_inst_tpl_handle_B)

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
    
    movl inst_A_1_handle_A, %eax # A_1(Type A)
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
    pushl inst_A_1_handle_Object
    //pushl inst_B_1_handle_Object
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
    
    pushl 4(%esi) 
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

    movl inst_A_1_handle_A, %ecx # A_1(Type A)
	
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

    movl 12(%ebp), %eax               // @this (Type B)
    movl handle_B_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl A_i_row(%ebx), %eax     // row
    addl %eax, %eax              // *2
    movl %eax, 16(%ebp)          // return row*2
    
    leave
    ret

/* Static Instances */
inst_Class_B_meminfo: // created on class loading
    .long inst_Class_B
    .long (inst_Class_B_end - inst_Class_B)
inst_Class_B:
    .long class_Class_desc
    .long inst_Class_B_meminfo
inst_Class_B_handle_Class:
    .long _call_entry_unresolved_vtab
    .long inst_Class_B
    .long (class_Class_vtab_Class - class_Class_desc)
inst_Class_B_handle_Class_vars_Object:
    .long (inst_Class_B_vars_Object - inst_Class_B) // @Super-Obj-Vars
inst_Class_B_handle_Class_vars_Class:
    .long (inst_Class_B_vars_Class - inst_Class_B)  // @Class-Obj-Vars
inst_Class_B_handle_Object:
    .long _call_entry_unresolved_vtab
    .long inst_Class_B
    .long (class_Class_vtab_Object - class_Class_desc)
inst_Class_B_handle_Object_vars_Object:
    .long (inst_Class_B_vars_Object - inst_Class_B) // @Object-Obj-Vars
inst_Class_B_vars_Object:
    .long inst_Runtime_handle_Runtime  // Runtime-handle
inst_Class_B_vars_Class:
    .long class_B_string_classname // classname
inst_Class_B_end:

// Obj-Instances
inst_B_1_meminfo:
    .long inst_B_1
    .long (inst_B_1_end - inst_B_1)
inst_B_1:
    .long class_B_desc
    .long inst_B_1_meminfo
inst_B_1_handle_B:
    .long _call_entry_unresolved_vtab
    .long inst_B_1
    .long (class_B_vtab_B - class_B_desc)
    .long (inst_B_1_vars_Object - inst_B_1) // @Super-Obj-Vars
    .long (inst_B_1_vars_A - inst_B_1)      // @Super-Obj-Vars
    .long (inst_B_1_vars_B - inst_B_1)      // @B-Obj-Vars
inst_B_1_handle_A:
    .long _call_entry_unresolved_vtab
    .long inst_B_1
    .long (class_B_vtab_A - class_B_desc)
    .long (inst_B_1_vars_Object - inst_B_1) // @Super-Obj-Vars
    .long (inst_B_1_vars_A - inst_B_1)      // @A-Obj-Vars
inst_B_1_handle_Object:
    .long _call_entry_unresolved_vtab
    .long inst_B_1
    .long (class_B_vtab_Object - class_B_desc)
    .long (inst_B_1_vars_Object - inst_B_1) // @Object-Obj-Vars
inst_B_1_vars_Object:
    .long inst_Runtime_handle_Runtime  // Runtime-handle
inst_B_1_vars_A:
    .long 0 // column
    .long 0 // row
inst_B_1_vars_B:
inst_B_1_end:
