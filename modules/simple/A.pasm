// CLASS A extends Object
class_A_desc:
    .long 0 // @class (Type Class) filled by class instantiation
    .long class_A_so_classname
    .long (class_A_inst_tpl_end - class_A_inst_tpl) // instance size
    .long (class_A_inst_tpl - class_A_desc)         // instance template offset
    .long (class_A_inst_tpl_handle_Object - class_A_inst_tpl)   // handle offset in instance 
    .long (class_A_inst_tpl_handle_A - class_A_inst_tpl)        // handle offset in instance 
class_A_vtabs:
class_A_vtabs_entry_A:
    .long class_A_desc // @class-desc filled on class loading
    .long class_A_so_classname
    .long (class_A_vtab_A - class_A_desc)
    .long (class_A_inst_tpl_handle_A - class_A_inst_tpl)                 // handle offset in instance 
class_A_vtabs_entry_Object:
    .long class_Object_desc // @class-desc filled on class loading
    .long class_A_so_super1
    .long (class_A_vtab_Object - class_A_desc)
    .long (class_A_inst_tpl_handle_Object - class_A_inst_tpl)            // handle offset in instance 
class_A_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0
class_A_vtab_A:
class_A_vtab_A_method_getClass:
    .long class_Object_mo_getClass; .long _cAVEObject
class_A_vtab_A_method_hash:
    .long class_Object_mo_hash;     .long _cAVEObject
class_A_vtab_A_method_equals:
    .long class_Object_mo_equals;   .long _cAVEObject
class_A_vtab_A_method_rt:
    .long class_Object_mo_rt;       .long _cAVEObject
class_A_vtab_A_method_setRt:
    .long class_Object_mo_setRt;    .long _cAVEObject
class_A_vtab_A_method_init:
    .long class_A_mo_init;          .long _cAVEA
class_A_vtab_A_method_getRow:
    .long class_A_mo_getRow;        .long _cAVEA
class_A_vtab_A_method_test:
    .long class_A_mo_test ;         .long _cAVEA
class_A_vtab_Object:
    .long class_Object_mo_getClass; .long _cAVEObject
    .long class_Object_mo_hash;     .long _cAVEObject
    .long class_Object_mo_equals;   .long _cAVEObject
    .long class_Object_mo_rt;       .long _cAVEObject
    .long class_Object_mo_setRt;    .long _cAVEObject

_cAVEA := (class_A_vtabs_entry_A - class_A_desc)
_cAVEObject := (class_A_vtabs_entry_Object - class_A_desc)

class_A_mo_init   := (class_A_method_init - class_A_desc)
class_A_mo_getRow := (class_A_method_getRow - class_A_desc)
class_A_mo_test   := (class_A_method_test - class_A_desc)

class_A_so_classname := (class_A_string_classname - class_A_desc)
class_A_so_super1 := (class_A_string_super1 - class_A_desc)
class_A_so_test := (class_A_string_test - class_A_desc)

class_A_inst_tpl:
    .long 0  // @class-desc
    .long 0  // @meminfo
class_A_inst_tpl_handle_A:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_A_inst_tpl_handle_A_vars_Object:
    .long (class_A_inst_tpl_vars_Object - class_A_inst_tpl) // @Super-Obj-Vars
class_A_inst_tpl_handle_A_vars_A:
    .long (class_A_inst_tpl_vars_A - class_A_inst_tpl)      // @A-Obj-Vars
class_A_inst_tpl_handle_Object:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_A_inst_tpl_handle_Object_vars_Object:
    .long (class_A_inst_tpl_vars_Object - class_A_inst_tpl) // @Object-Obj-Vars
class_A_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_A_inst_tpl_vars_A:
class_A_inst_tpl_vars_A_column:
    .long 0 // column
class_A_inst_tpl_vars_A_row:
    .long 0 // row
class_A_inst_tpl_end:

class_A_string_classname:
    .asciz "/my/A"
class_A_string_super1:
    .asciz "/my/Object"
class_A_string_test:
    .asciz " Test\n"

// Method Offsets
A_m_getClass := (class_A_vtab_A_method_getClass - class_A_vtab_A)
A_m_hash     := (class_A_vtab_A_method_hash - class_A_vtab_A)
A_m_equals   := (class_A_vtab_A_method_equals - class_A_vtab_A)
A_m_rt       := (class_A_vtab_A_method_rt - class_A_vtab_A)
A_m_setRt    := (class_A_vtab_A_method_setRt - class_A_vtab_A)
A_m_init     := (class_A_vtab_A_method_init - class_A_vtab_A)
A_m_getRow   := (class_A_vtab_A_method_getRow - class_A_vtab_A)
A_m_test     := (class_A_vtab_A_method_test - class_A_vtab_A)
// Vars Offsets
A_i_column := (class_A_inst_tpl_vars_A_column - class_A_inst_tpl_vars_A)
A_i_row    := (class_A_inst_tpl_vars_A_row - class_A_inst_tpl_vars_A)
// Super Vars Offsets
handle_A_vars_A      := (class_A_inst_tpl_handle_A_vars_A - class_A_inst_tpl_handle_A)
handle_A_vars_Object := (class_A_inst_tpl_handle_A_vars_Object - class_A_inst_tpl_handle_A)

class_A_method_init:
    pushl %ebp; movl %esp, %ebp

    movl 12(%ebp), %eax               // @this (Type A)
    movl handle_A_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)

    movl 16(%esp), %eax         // param row
    movl %eax, A_i_row(%ebx)    // set this.row
    movl 20(%esp), %eax         // param column
    movl %eax, A_i_column(%ebx) // set this.column
    
    leave
    ret

class_A_method_getRow:
    pushl %ebp; movl %esp, %ebp

    movl 12(%ebp), %eax               // @this (Type A)
    movl handle_A_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl A_i_row(%ebx), %eax // row
    movl %eax, 16(%ebp)      // return row
    
    leave
    ret

class_A_method_test:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx
    pushl %edx

    movl 12(%ebp), %ecx               // @this (Type A)

    addl -4, %esp  # return value of rt
    pushl %ecx; pushl A_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime (Type Runtime)

    addl -4, %esp  # return value of getClass
    pushl %ecx; pushl A_m_getClass; call (%ecx)
	addl 8, %esp
    popl %eax // handle_Class_(A|B) (Type Class)
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

    pushl %eax; pushl 0
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl 0 // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    movl handle_A_vars_A(%ecx), %ebx  // inst vars offset (A)
    addl 4(%ecx), %ebx                // @this.vars(A)
    push A_i_column(%ebx); pushl 0 // column
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl 0 // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl 16(%ebp); pushl 0 // row
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    movl 8(%ebp), %eax      // @class-desc "A"
    addl class_A_so_test, %eax
    pushl %eax; pushl 0
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    popl %ecx
    leave
    ret
