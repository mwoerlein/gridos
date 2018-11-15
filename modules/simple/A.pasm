// CLASS A extends Object
class_A_desc:
    .long 0                         # (class_A_string_classname - class_A_desc) // filled/adjusted on class loading
    .long class_A_string_classname  # (class_A_string_classname - class_A_desc) // filled/adjusted on class loading
    .long (class_A_inst_tpl_end - class_A_inst_tpl) // instance size
    .long (class_A_inst_tpl - class_A_desc)         // instance template offset
    .long (class_A_inst_tpl_handle_Object - class_A_inst_tpl)   // handle offset in instance 
    .long (class_A_inst_tpl_handle_A - class_A_inst_tpl)        // handle offset in instance 
class_A_vtabs:
class_A_vtabs_entry_A:
    .long class_A_desc   # (class_Class_string_classname - class_A_desc) // filled/adjusted on class loading
    .long (class_A_vtab_A - class_A_desc)
    .long (class_A_inst_tpl_handle_A - class_A_inst_tpl)                 // handle offset in instance 
class_A_vtabs_entry_Object:
    .long class_Object_desc  # (class_A_string_super1 - class_A_desc)    // filled/adjusted on class loading
    .long (class_A_vtab_Object - class_A_desc)
    .long (class_A_inst_tpl_handle_Object - class_A_inst_tpl)            // handle offset in instance 
class_A_vtab_end_entry:
    .long 0
    .long 0
    .long 0
class_A_vtab_A:
class_A_vtab_A_method_getClass:
    .long (class_Object_method_getClass - class_Object_desc); .long _cAVEObject
class_A_vtab_A_method_hash:
    .long (class_Object_method_hash - class_Object_desc); .long _cAVEObject
class_A_vtab_A_method_equals:
    .long (class_Object_method_equals - class_Object_desc); .long _cAVEObject
class_A_vtab_A_method_rt:
    .long (class_Object_method_rt - class_Object_desc); .long _cAVEObject
class_A_vtab_A_method_setRt:
    .long (class_Object_method_setRt - class_Object_desc); .long _cAVEObject
class_A_vtab_A_method_init:
    .long (class_A_method_init - class_A_desc); .long _cAVEA
class_A_vtab_A_method_getRow:
    .long (class_A_method_getRow - class_A_desc); .long _cAVEA
class_A_vtab_A_method_test:
    .long (class_A_method_test - class_A_desc); .long _cAVEA
class_A_vtab_Object:
    .long (class_Object_method_getClass - class_Object_desc); .long _cAVEObject
    .long (class_Object_method_hash - class_Object_desc); .long _cAVEObject
    .long (class_Object_method_equals - class_Object_desc); .long _cAVEObject
    .long (class_Object_method_rt - class_Object_desc); .long _cAVEObject
    .long (class_Object_method_setRt - class_Object_desc); .long _cAVEObject

_cAVEA := (class_A_vtabs_entry_A - class_A_desc)
_cAVEObject := (class_A_vtabs_entry_Object - class_A_desc)

class_A_inst_tpl:
    .long class_A_desc                      // filled/adjusted on class loading
    .long 0  // A_inst_meminfo              // filled during instatiation
class_A_inst_tpl_handle_A:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // A_inst                      // filled during instatiation
    .long (class_A_vtab_A - class_A_desc)
class_A_inst_tpl_handle_A_vars_Object:
    .long (class_A_inst_tpl_vars_Object - class_A_inst_tpl) // @Super-Obj-Vars
class_A_inst_tpl_handle_A_vars_A:
    .long (class_A_inst_tpl_vars_A - class_A_inst_tpl)      // @A-Obj-Vars
class_A_inst_tpl_handle_Object:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // A_inst                      // filled during instatiation
    .long (class_A_vtab_Object - class_A_desc)
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

    movl 12(%ebp), %eax               // @this (Type A)
    movl handle_A_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl A_i_column(%ebx), %eax // column
    movl 16(%ebp), %ebx         // row
    
    movl  84, %ecx; call _print; add 1, %eax // 'T'
    movl 101, %ecx; call _print; add 1, %eax // 'e'
    movl 115, %ecx; call _print; add 1, %eax // 's'
    movl 116, %ecx; call _print; add 1, %eax // 't'
    
    popl %ecx
    leave
    ret
