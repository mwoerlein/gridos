/*[meta]
mimetype = text/x-pasm
description = class "/my/Object"
[pool]
version = 0.1.0
class = true
*/
// class Object
class_Object_desc:
    .long 0x15AC1A55
    .long 0
    .long class_Object_so_cn_Object
    .long (class_Object_cts - class_Object_desc)
    .long (class_Object_mts - class_Object_desc)
    .long (class_Object_inst_tpl - class_Object_desc)
    .long (class_Object_inst_tpl_end - class_Object_inst_tpl)
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)

// class tab
class_Object_cts:
_cObjectVEObject := (class_Object_vtabs_entry_Object - class_Object_desc)
class_Object_vtabs_entry_Object:
    .long 0
    .long class_Object_so_cn_Object
    .long (class_Object_vtab_Object - class_Object_desc)
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
class_Object_mts:
class_Object_vtab_Object:
.global Object_m_getClass := (class_Object_vtab_Object_method_getClass - class_Object_vtab_Object)
class_Object_vtab_Object_method_getClass:
    .long class_Object_mo_getClass
    .long _cObjectVEObject
.global Object_m_hash := (class_Object_vtab_Object_method_hash - class_Object_vtab_Object)
class_Object_vtab_Object_method_hash:
    .long class_Object_mo_hash
    .long _cObjectVEObject
.global Object_m_equals := (class_Object_vtab_Object_method_equals - class_Object_vtab_Object)
class_Object_vtab_Object_method_equals:
    .long class_Object_mo_equals
    .long _cObjectVEObject
.global Object_m_rt := (class_Object_vtab_Object_method_rt - class_Object_vtab_Object)
class_Object_vtab_Object_method_rt:
    .long class_Object_mo_rt
    .long _cObjectVEObject
.global Object_m_setRt := (class_Object_vtab_Object_method_setRt - class_Object_vtab_Object)
class_Object_vtab_Object_method_setRt:
    .long class_Object_mo_setRt
    .long _cObjectVEObject

// constants
// int ch_inst_handle
class_Object_ict_ch_inst_handle := 4

// class-name Object
class_Object_so_cn_Object := (class_Object_scn_Object - class_Object_desc)
class_Object_scn_Object:
    .asciz "/my/Object"

// instance template
class_Object_inst_tpl:
    .long 0
    .long 0
class_Object_inst_tpl_handle_Object:
    .long 0
    .long 0
    .long 0
handle_Object_vars_Object := (class_Object_inst_tpl_handle_Object_vars_Object - class_Object_inst_tpl_handle_Object)
class_Object_inst_tpl_handle_Object_vars_Object:
    .long (class_Object_inst_tpl_vars_Object - class_Object_inst_tpl)
class_Object_inst_tpl_vars_Object:
// variable runtime
.global Object_i_runtime := (class_Object_inst_tpl_vars_Object_runtime - class_Object_inst_tpl_vars_Object)
class_Object_inst_tpl_vars_Object_runtime:
    .long 0
class_Object_inst_tpl_end:

// method definitions
// method getClass
.global class_Object_mo_getClass := (class_Object_method_getClass - class_Object_desc)
class_Object_method_getClass:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl (%eax), %eax      // @class desc
    movl class_Object_ict_ch_inst_handle(%eax), %eax // @class handle
    movl %eax, 16(%ebp)    // return @class handle
    
    leave
    ret

// method hash
.global class_Object_mo_hash := (class_Object_method_hash - class_Object_desc)
class_Object_method_hash:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl %eax, 16(%ebp)    // return @this as hash
    
    leave
    ret

// method equals
.global class_Object_mo_equals := (class_Object_method_equals - class_Object_desc)
class_Object_method_equals:
    pushl %ebp; movl %esp, %ebp
    
    movl 0, 20(%ebp)       // default return: false
    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl 16(%ebp), %ebx    // @obj (Type ANY)
    movl 4(%ebx), %ebx     // @obj
    cmpl %eax, %ebx
    jne _come_ret
    movl 1, 20(%ebp)       // return true
_come_ret:
    
    leave
    ret

// method rt
.global class_Object_mo_rt := (class_Object_method_rt - class_Object_desc)
class_Object_method_rt:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax                         // @this (Type Object)
    movl handle_Object_vars_Object(%eax), %ebx  // inst vars offset (Object)
    addl 4(%eax), %ebx                          // @this.vars(Object)
    movl Object_i_runtime(%ebx), %eax           // load @runtime (Type Runtime)
    movl %eax, 16(%ebp)                         // return @runtime (Type Runtime)
    
    leave
    ret

// method setRt
.global class_Object_mo_setRt := (class_Object_method_setRt - class_Object_desc)
class_Object_method_setRt:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax                         // @this (Type Object)
    movl handle_Object_vars_Object(%eax), %ebx  // inst vars offset (Object)
    addl 4(%eax), %ebx                          // @this.vars(Object)
    movl 16(%ebp), %eax                         // arg @runtime (Type Runtime)
    movl %eax, Object_i_runtime(%ebx)           // store @runtime (Type Runtime)
    
    leave
    ret
