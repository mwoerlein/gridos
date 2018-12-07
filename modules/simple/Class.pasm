/*[meta]
mimetype = text/x-pasm
description = class "/my/Class"
[pool]
version = 0.1.0
class = true
*/
// class Class
class_Class_desc:
    .long 0x15AC1A55
    .long 0
    .long class_Class_so_cn_Class
    .long (class_Class_inst_tpl - class_Class_desc)
    .long (class_Class_inst_tpl_end - class_Class_inst_tpl)
    .long (class_Class_inst_tpl_handle_Object - class_Class_inst_tpl)
    .long (class_Class_inst_tpl_handle_Class - class_Class_inst_tpl)

// class tab
_cClassVEObject := (class_Class_vtabs_entry_Object - class_Class_desc)
class_Class_vtabs_entry_Object:
    .long 0
    .long class_Class_so_cn_Object
    .long (class_Class_vtab_Object - class_Class_desc)
    .long (class_Class_inst_tpl_handle_Object - class_Class_inst_tpl)
_cClassVEClass := (class_Class_vtabs_entry_Class - class_Class_desc)
class_Class_vtabs_entry_Class:
    .long 0
    .long class_Class_so_cn_Class
    .long (class_Class_vtab_Class - class_Class_desc)
    .long (class_Class_inst_tpl_handle_Class - class_Class_inst_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
class_Class_vtab_Object:
    .long class_Object_mo_getClass
    .long _cClassVEObject
    .long class_Object_mo_hash
    .long _cClassVEObject
    .long class_Object_mo_equals
    .long _cClassVEObject
    .long class_Object_mo_rt
    .long _cClassVEObject
    .long class_Object_mo_setRt
    .long _cClassVEObject
class_Class_vtab_Class:
.global Class_m_getClass := (class_Class_vtab_Class_method_getClass - class_Class_vtab_Class)
class_Class_vtab_Class_method_getClass:
    .long class_Object_mo_getClass
    .long _cClassVEObject
.global Class_m_hash := (class_Class_vtab_Class_method_hash - class_Class_vtab_Class)
class_Class_vtab_Class_method_hash:
    .long class_Object_mo_hash
    .long _cClassVEObject
.global Class_m_equals := (class_Class_vtab_Class_method_equals - class_Class_vtab_Class)
class_Class_vtab_Class_method_equals:
    .long class_Object_mo_equals
    .long _cClassVEObject
.global Class_m_rt := (class_Class_vtab_Class_method_rt - class_Class_vtab_Class)
class_Class_vtab_Class_method_rt:
    .long class_Object_mo_rt
    .long _cClassVEObject
.global Class_m_setRt := (class_Class_vtab_Class_method_setRt - class_Class_vtab_Class)
class_Class_vtab_Class_method_setRt:
    .long class_Object_mo_setRt
    .long _cClassVEObject
.global Class_m_getDesc := (class_Class_vtab_Class_method_getDesc - class_Class_vtab_Class)
class_Class_vtab_Class_method_getDesc:
    .long class_Class_mo_getDesc
    .long _cClassVEClass
.global Class_m_setDesc := (class_Class_vtab_Class_method_setDesc - class_Class_vtab_Class)
class_Class_vtab_Class_method_setDesc:
    .long class_Class_mo_setDesc
    .long _cClassVEClass
.global Class_m_getName := (class_Class_vtab_Class_method_getName - class_Class_vtab_Class)
class_Class_vtab_Class_method_getName:
    .long class_Class_mo_getName
    .long _cClassVEClass

// constants
// class-name Object
class_Class_so_cn_Object := (class_Class_scn_Object - class_Class_desc)
class_Class_scn_Object:
    .asciz "/my/Object"

// class-name Class
class_Class_so_cn_Class := (class_Class_scn_Class - class_Class_desc)
class_Class_scn_Class:
    .asciz "/my/Class"

// instance template
class_Class_inst_tpl:
    .long 0
    .long 0
class_Class_inst_tpl_handle_Object:
    .long 0
    .long 0
    .long 0
class_Class_inst_tpl_handle_Object_vars_Object:
    .long (class_Class_inst_tpl_vars_Object - class_Class_inst_tpl)
class_Class_inst_tpl_handle_Class:
    .long 0
    .long 0
    .long 0
handle_Class_vars_Object := (class_Class_inst_tpl_handle_Class_vars_Object - class_Class_inst_tpl_handle_Class)
class_Class_inst_tpl_handle_Class_vars_Object:
    .long (class_Class_inst_tpl_vars_Object - class_Class_inst_tpl)
handle_Class_vars_Class := (class_Class_inst_tpl_handle_Class_vars_Class - class_Class_inst_tpl_handle_Class)
class_Class_inst_tpl_handle_Class_vars_Class:
    .long (class_Class_inst_tpl_vars_Class - class_Class_inst_tpl)
class_Class_inst_tpl_vars_Object:
// variable runtime
    .long 0
class_Class_inst_tpl_vars_Class:
// variable desc
.global Class_i_desc := (class_Class_inst_tpl_vars_Class_desc - class_Class_inst_tpl_vars_Class)
class_Class_inst_tpl_vars_Class_desc:
    .long 0
class_Class_inst_tpl_end:

// method definitions
// method getDesc
.global class_Class_mo_getDesc := (class_Class_method_getDesc - class_Class_desc)
class_Class_method_getDesc:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax                      // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx // inst vars offset (Class)
    addl 4(%eax), %ebx                       // @this.vars(Class)
    movl Class_i_desc(%ebx), %eax            // @class desc
    movl %eax, 16(%ebp)                      // return @class desc
    
    leave
    ret

// method setDesc
.global class_Class_mo_setDesc := (class_Class_method_setDesc - class_Class_desc)
class_Class_method_setDesc:
    pushl %ebp; movl %esp, %ebp
    
class_handle_offset := 0x4 //(class_Class_handle - class_Class_desc)
    movl 12(%ebp), %eax                      // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx // inst vars offset (Class)
    addl 4(%eax), %ebx                       // @this.vars(Class)
    movl 16(%ebp), %eax                      // param @class desc
    movl %eax, Class_i_desc(%ebx)            // store @class desc
    movl 12(%ebp), %ebx                      // @this (Type Class)
    movl %ebx, class_handle_offset(%eax)     // store @this (Type Class) in class desc
    
    leave
    ret

// method getName
.global class_Class_mo_getName := (class_Class_method_getName - class_Class_desc)
class_Class_method_getName:
    pushl %ebp; movl %esp, %ebp
    
class_name_offset := 0x8 //(class_Class_name - class_Class_desc)
    movl 12(%ebp), %eax                      // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx // inst vars offset (Class)
    addl 4(%eax), %ebx                       // @this.vars(Class)
    movl Class_i_desc(%ebx), %eax            // @class desc
    addl class_name_offset(%eax), %eax       // load reference to cstring
    movl %eax, 16(%ebp)                      // return cstring-ref
    
    leave
    ret
