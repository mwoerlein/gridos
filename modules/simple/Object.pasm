/*[meta]
mimetype = text/x-pasm
description = core class "Object"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
*/
// Class Object
class_Object_desc:
    .long 0 // @class (Type Class) filled by class instantiation
    .long class_Object_so_classname
    .long (class_Object_inst_tpl_end - class_Object_inst_tpl) // instance size
    .long (class_Object_inst_tpl - class_Object_desc)         // instance template offset
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)             // handle offset in instance 
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)             // handle offset in instance 
    .long 0x15AC1A55
class_Object_vtabs:
class_Object_vtabs_entry_Object:
    .long 0 // @class-desc filled on class loading
    .long class_Object_so_classname
    .long (class_Object_vtab_Object - class_Object_desc)
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)             // handle offset in instance 
class_Object_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0
class_Object_vtab_Object:
class_Object_vtab_Object_method_getClass:
    .long class_Object_mo_getClass; .long _cObjectVEObject
class_Object_vtab_Object_method_hash:
    .long class_Object_mo_hash;     .long _cObjectVEObject
class_Object_vtab_Object_method_equals:
    .long class_Object_mo_equals;   .long _cObjectVEObject
class_Object_vtab_Object_method_rt:
    .long class_Object_mo_rt;       .long _cObjectVEObject
class_Object_vtab_Object_method_setRt:
    .long class_Object_mo_setRt;    .long _cObjectVEObject

_cObjectVEObject := (class_Object_vtabs_entry_Object - class_Object_desc)

.global class_Object_mo_getClass := (class_Object_method_getClass - class_Object_desc)
.global class_Object_mo_hash     := (class_Object_method_hash - class_Object_desc)
.global class_Object_mo_equals   := (class_Object_method_equals - class_Object_desc)
.global class_Object_mo_rt       := (class_Object_method_rt - class_Object_desc)
.global class_Object_mo_setRt    := (class_Object_method_setRt - class_Object_desc)

class_Object_so_classname := (class_Object_string_classname - class_Object_desc)

class_Object_inst_tpl:
    .long 0  // @class-desc
    .long 0  // @meminfo
class_Object_inst_tpl_handle_Object:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Object_inst_tpl_handle_Object_vars_Object:
    .long (class_Object_inst_tpl_vars_Object - class_Object_inst_tpl) // @Super-Obj-Vars
class_Object_inst_tpl_vars_Object:
class_Object_inst_tpl_vars_Object_runtime:
    .long 0  // Runtime-handle
class_Object_inst_tpl_end:

class_Object_string_classname:
    .asciz "/my/Object"
// Method Offsets
.global Object_m_getClass := (class_Object_vtab_Object_method_getClass - class_Object_vtab_Object)
.global Object_m_hash     := (class_Object_vtab_Object_method_hash - class_Object_vtab_Object)
.global Object_m_equals   := (class_Object_vtab_Object_method_equals - class_Object_vtab_Object)
.global Object_m_rt       := (class_Object_vtab_Object_method_rt - class_Object_vtab_Object)
.global Object_m_setRt    := (class_Object_vtab_Object_method_setRt - class_Object_vtab_Object)
// Vars Offsets
.global Object_i_runtime  := (class_Object_inst_tpl_vars_Object_runtime - class_Object_inst_tpl_vars_Object)
// Super Vars Offsets
handle_Object_vars_Object := (class_Object_inst_tpl_handle_Object_vars_Object - class_Object_inst_tpl_handle_Object)

class_Object_method_getClass:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl (%eax), %eax      // @class desc
    movl (%eax), %eax      // @class handle
    movl %eax, 16(%ebp)    // return @class handle
    
    leave
    ret

class_Object_method_hash:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl %eax, 16(%ebp)    // return @this as hash
    
    leave
    ret

class_Object_method_equals:
    pushl %ebp; movl %esp, %ebp;
    
    movl 0, 20(%ebp)       // default return: false

    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    
    movl 16(%ebp), %ebx    // @obj (Type ANY)
    movl 4(%ebx), %ebx     // @obj
    
    cmpl %eax, %ebx
    jne class_Object_method_equals_ret
    movl 1, 20(%ebp)       // return true
        
class_Object_method_equals_ret:    
    leave
    ret

class_Object_method_rt:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                         // @this (Type Object)
    movl handle_Object_vars_Object(%eax), %ebx  // inst vars offset (Object)
    addl 4(%eax), %ebx                          // @this.vars(Object)
    movl Object_i_runtime(%ebx), %eax           // load @runtime (Type Runtime)
    movl %eax, 16(%ebp)                         // return @runtime (Type Runtime)
    
    leave
    ret

class_Object_method_setRt:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                         // @this (Type Object)
    movl handle_Object_vars_Object(%eax), %ebx  // inst vars offset (Object)
    addl 4(%eax), %ebx                          // @this.vars(Object)
    movl 16(%ebp), %eax                         // arg @runtime (Type Runtime)
    movl %eax, Object_i_runtime(%ebx)           // store @runtime (Type Runtime)
    
    leave
    ret

