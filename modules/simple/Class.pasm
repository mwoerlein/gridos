/*[meta]
mimetype = text/x-pasm
description = core class "Class"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
class = true
*/
// CLASS Class extends Object
class_Class_desc:
    .long 0 // @class (Type Class) filled by class instantiation
class_Class_name:
    .long class_Class_so_classname
class_Class_instance_size:
    .long (class_Class_inst_tpl_end - class_Class_inst_tpl) // instance size
class_Class_instance_tpl_offset:
    .long (class_Class_inst_tpl - class_Class_desc)         // instance template offset
class_Class_instance_Object_handle_offset:
    .long (class_Class_inst_tpl_handle_Object - class_Class_inst_tpl)            // handle offset in instance 
class_Class_instance_class_handle_offset:
    .long (class_Class_inst_tpl_handle_Class - class_Class_inst_tpl)             // handle offset in instance 
    .long 0x15AC1A55
class_Class_vtabs:
class_Class_vtabs_entry_Class:
class_Class_vtabs_entry_class_desc:
    .long 0 // @class-desc filled on class loading
class_Class_vtabs_entry_class_name:
    .long class_Class_so_classname 
class_Class_vtabs_entry_vtab_offset:
    .long (class_Class_vtab_Class - class_Class_desc)
class_Class_vtabs_entry_handle:
    .long (class_Class_inst_tpl_handle_Class - class_Class_inst_tpl)             // handle offset in instance 
class_Class_vtabs_entry_Object:
    .long 0 // @class-desc filled on class loading
    .long class_Class_so_super1
    .long (class_Class_vtab_Object - class_Class_desc)
    .long (class_Class_inst_tpl_handle_Object - class_Class_inst_tpl)            // handle offset in instance 
class_Class_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0
class_Class_vtab_Class:
class_Class_vtab_Class_method_getClass:
    .long class_Object_mo_getClass; .long _cClassVEObject
class_Class_vtab_Class_method_hash:
    .long class_Object_mo_hash;     .long _cClassVEObject
class_Class_vtab_Class_method_equals:
    .long class_Object_mo_equals;   .long _cClassVEObject
class_Class_vtab_Class_method_rt:
    .long class_Object_mo_rt;       .long _cClassVEObject
class_Class_vtab_Class_method_setRt:
    .long class_Object_mo_setRt;    .long _cClassVEObject
class_Class_vtab_Class_method_getDesc:
    .long class_Class_mo_getDesc;   .long _cClassVEClass
class_Class_vtab_Class_method_setDesc:
    .long class_Class_mo_setDesc;   .long _cClassVEClass
class_Class_vtab_Class_method_getName:
    .long class_Class_mo_getName;   .long _cClassVEClass
class_Class_vtab_Class_method_cast:
    .long class_Class_mo_cast;      .long _cClassVEClass
class_Class_vtab_Object:
    .long class_Object_mo_getClass; .long _cClassVEObject
    .long class_Object_mo_hash;     .long _cClassVEObject
    .long class_Object_mo_equals;   .long _cClassVEObject
    .long class_Object_mo_rt;       .long _cClassVEObject
    .long class_Object_mo_setRt;    .long _cClassVEObject

_cClassVEObject := (class_Class_vtabs_entry_Object - class_Class_desc)
_cClassVEClass := (class_Class_vtabs_entry_Class - class_Class_desc)

.global class_Class_mo_getDesc := (class_Class_method_getDesc - class_Class_desc)
.global class_Class_mo_setDesc := (class_Class_method_setDesc - class_Class_desc)
.global class_Class_mo_getName := (class_Class_method_getName - class_Class_desc)
.global class_Class_mo_cast    := (class_Class_method_cast - class_Class_desc)

class_Class_so_classname := (class_Class_string_classname - class_Class_desc)
class_Class_so_super1 := (class_Class_string_super1 - class_Class_desc)

class_Class_inst_tpl:
    .long 0  // @class-desc
    .long 0  // @meminfo
class_Class_inst_tpl_handle_Class:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Class_inst_tpl_handle_Class_vars_Object:
    .long (class_Class_inst_tpl_vars_Object - class_Class_inst_tpl) // @Super-Obj-Vars
class_Class_inst_tpl_handle_Class_vars_Class:
    .long (class_Class_inst_tpl_vars_Class - class_Class_inst_tpl)  // @Class-Obj-Vars
class_Class_inst_tpl_handle_Object:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Class_inst_tpl_handle_Object_vars_Object:
    .long (class_Class_inst_tpl_vars_Object - class_Class_inst_tpl) // @Object-Obj-Vars
class_Class_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_Class_inst_tpl_vars_Class:
class_Class_inst_tpl_vars_Class_desc:
    .long 0  // class desc
class_Class_inst_tpl_end:

class_Class_string_classname:
    .asciz "/my/Class"
class_Class_string_super1:
    .asciz "/my/Object"
    
.global class_vtabs_offset := (class_Class_vtabs - class_Class_desc)
.global _cvte_size := (class_Class_vtabs_entry_Object - class_Class_vtabs_entry_Class)
.global _cvte_cno  := (class_Class_vtabs_entry_class_name - class_Class_vtabs_entry_Class)
.global _cvte_cdo  := (class_Class_vtabs_entry_class_desc - class_Class_vtabs_entry_Class)
.global _cvte_vto  := (class_Class_vtabs_entry_vtab_offset - class_Class_vtabs_entry_Class)
.global _cvte_ho   := (class_Class_vtabs_entry_handle - class_Class_vtabs_entry_Class)
.global class_name_offset := (class_Class_name - class_Class_desc)
.global class_instance_size_offset := (class_Class_instance_size - class_Class_desc)
.global class_instance_tpl_offset_offset := (class_Class_instance_tpl_offset - class_Class_desc)
.global class_instance_Object_handle_offset := (class_Class_instance_Object_handle_offset - class_Class_desc)
.global class_instance_class_handle_offset := (class_Class_instance_class_handle_offset - class_Class_desc)
    
// Method Offsets
.global Class_m_getClass    := (class_Class_vtab_Class_method_getClass - class_Class_vtab_Class)
.global Class_m_hash        := (class_Class_vtab_Class_method_hash - class_Class_vtab_Class)
.global Class_m_equals      := (class_Class_vtab_Class_method_equals - class_Class_vtab_Class)
.global Class_m_rt          := (class_Class_vtab_Class_method_rt - class_Class_vtab_Class)
.global Class_m_setRt       := (class_Class_vtab_Class_method_setRt - class_Class_vtab_Class)
.global Class_m_getDesc     := (class_Class_vtab_Class_method_getDesc - class_Class_vtab_Class)
.global Class_m_setDesc     := (class_Class_vtab_Class_method_setDesc - class_Class_vtab_Class)
.global Class_m_getName     := (class_Class_vtab_Class_method_getName - class_Class_vtab_Class)
.global Class_m_cast        := (class_Class_vtab_Class_method_cast - class_Class_vtab_Class)
// Vars Offsets
.global Class_i_desc := (class_Class_inst_tpl_vars_Class_desc - class_Class_inst_tpl_vars_Class)
// Super Vars Offsets
handle_Class_vars_Class  := (class_Class_inst_tpl_handle_Class_vars_Class - class_Class_inst_tpl_handle_Class)
handle_Class_vars_Object := (class_Class_inst_tpl_handle_Class_vars_Object - class_Class_inst_tpl_handle_Class)

class_Class_method_getDesc:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                       // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx                        // @this.vars(Class)
    movl Class_i_desc(%ebx), %eax // @class desc
    movl %eax, 16(%ebp)           // return @class desc
    
    leave
    ret

class_Class_method_setDesc:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                       // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx                        // @this.vars(Class)
    movl 16(%ebp), %eax           // param @class desc
    movl %eax, Class_i_desc(%ebx) // store @class desc
    movl 12(%ebp), %ebx           // @this (Type Class)
    movl %ebx, (%eax)             // store @this (Type Class) in class desc
    
    leave
    ret

class_Class_method_getName:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                       // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx                        // @this.vars(Class)
    movl Class_i_desc(%ebx), %eax             // @class desc
    addl class_name_offset(%eax), %eax        // load reference to cstring
    movl %eax, 16(%ebp)                       // return cstring-ref
    
    leave
    ret

class_Class_method_cast:
    pushl %ebp; movl %esp, %ebp;
    pushl %ecx
_ccmc_start:
    movl 0, 20(%ebp)                // not-found default handle: NULL
    movl 12(%ebp), %eax             // @class (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx              // @this.vars(Class)
    movl Class_i_desc(%ebx), %ecx   // @class desc
    movl 16(%ebp), %eax             // @obj (Type ANY)
    movl 4(%eax), %ebx              // @obj
    movl (%ebx), %eax               // @obj-class desc
    addl class_vtabs_offset, %eax   // @obj-class vtabs
_ccmc_loop:
    cmpl (%eax), %ecx
    je _ccmc_found
    addl _cvte_size, %eax
    cmpl 0, (%eax)
    je _ccmc_return
    jmp _ccmc_loop
_ccmc_found:
    addl _cvte_ho(%eax), %ebx
    movl %ebx, 20(%ebp)     // return correct handle
_ccmc_return:
    popl %ecx
    leave
    ret
