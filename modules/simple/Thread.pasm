/*[meta]
mimetype = text/x-pasm
description = class "/my/Thread"
[pool]
version = 0.1.0
class = true
*/
// class Thread
class_Thread_desc:
    .long 0
    .long class_Thread_so_cn_Thread
    .long (class_Thread_inst_tpl_end - class_Thread_inst_tpl)
    .long (class_Thread_inst_tpl - class_Thread_desc)
    .long (class_Thread_inst_tpl_handle_Object - class_Thread_inst_tpl)
    .long (class_Thread_inst_tpl_handle_Thread - class_Thread_inst_tpl)
    .long 0x15AC1A55

class_Thread_vtabs:
class_Thread_vtabs_entry_Object:
    .long 0
    .long class_Thread_so_cn_Object
    .long (class_Thread_vtab_Object - class_Thread_desc)
    .long (class_Thread_inst_tpl_handle_Object - class_Thread_inst_tpl)
class_Thread_vtabs_entry_Thread:
    .long 0
    .long class_Thread_so_cn_Thread
    .long (class_Thread_vtab_Thread - class_Thread_desc)
    .long (class_Thread_inst_tpl_handle_Thread - class_Thread_inst_tpl)
class_Thread_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0

_cThreadVEObject := (class_Thread_vtabs_entry_Object - class_Thread_desc)
_cThreadVEThread := (class_Thread_vtabs_entry_Thread - class_Thread_desc)
class_Thread_vtab_Object:
    .long class_Object_mo_getClass
    .long _cThreadVEObject
    .long class_Object_mo_hash
    .long _cThreadVEObject
    .long class_Object_mo_equals
    .long _cThreadVEObject
    .long class_Object_mo_rt
    .long _cThreadVEObject
    .long class_Object_mo_setRt
    .long _cThreadVEObject
class_Thread_vtab_Thread:
.global Thread_m_getClass := (class_Thread_vtab_Thread_method_getClass - class_Thread_vtab_Thread)
class_Thread_vtab_Thread_method_getClass:
    .long class_Object_mo_getClass
    .long _cThreadVEObject
.global Thread_m_hash := (class_Thread_vtab_Thread_method_hash - class_Thread_vtab_Thread)
class_Thread_vtab_Thread_method_hash:
    .long class_Object_mo_hash
    .long _cThreadVEObject
.global Thread_m_equals := (class_Thread_vtab_Thread_method_equals - class_Thread_vtab_Thread)
class_Thread_vtab_Thread_method_equals:
    .long class_Object_mo_equals
    .long _cThreadVEObject
.global Thread_m_rt := (class_Thread_vtab_Thread_method_rt - class_Thread_vtab_Thread)
class_Thread_vtab_Thread_method_rt:
    .long class_Object_mo_rt
    .long _cThreadVEObject
.global Thread_m_setRt := (class_Thread_vtab_Thread_method_setRt - class_Thread_vtab_Thread)
class_Thread_vtab_Thread_method_setRt:
    .long class_Object_mo_setRt
    .long _cThreadVEObject
.global Thread_m_run := (class_Thread_vtab_Thread_method_run - class_Thread_vtab_Thread)
class_Thread_vtab_Thread_method_run:
    .long class_Thread_mo_run
    .long _cThreadVEThread

class_Thread_so_cn_Object := (class_Thread_string_cn_Object - class_Thread_desc)
class_Thread_string_cn_Object:
    .asciz "/my/Object"

class_Thread_so_cn_Thread := (class_Thread_string_cn_Thread - class_Thread_desc)
class_Thread_string_cn_Thread:
    .asciz "/my/Thread"

class_Thread_inst_tpl:
    .long 0
    .long 0
class_Thread_inst_tpl_handle_Object:
    .long 0
    .long 0
    .long 0
class_Thread_inst_tpl_handle_Object_vars_Object:
    .long (class_Thread_inst_tpl_vars_Object - class_Thread_inst_tpl)
class_Thread_inst_tpl_handle_Thread:
    .long 0
    .long 0
    .long 0
handle_Thread_vars_Object := (class_Thread_inst_tpl_handle_Thread_vars_Object - class_Thread_inst_tpl_handle_Thread)
class_Thread_inst_tpl_handle_Thread_vars_Object:
    .long (class_Thread_inst_tpl_vars_Object - class_Thread_inst_tpl)
handle_Thread_vars_Thread := (class_Thread_inst_tpl_handle_Thread_vars_Thread - class_Thread_inst_tpl_handle_Thread)
class_Thread_inst_tpl_handle_Thread_vars_Thread:
    .long (class_Thread_inst_tpl_vars_Thread - class_Thread_inst_tpl)
class_Thread_inst_tpl_vars_Object:
    .long 0 // runtime
class_Thread_inst_tpl_vars_Thread:
class_Thread_inst_tpl_end:

// method-def run
.global class_Thread_mo_run := 0 // virtual method


