/*[meta]
mimetype = text/x-pasm
description = core class "Thread"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
class = true
*/
// CLASS Thread extends Object
class_Thread_desc:
    .long 0 // @class (Type Class) filled by class instantiation
    .long class_Thread_so_classname
    .long (class_Thread_inst_tpl_end - class_Thread_inst_tpl) // instance size
    .long (class_Thread_inst_tpl - class_Thread_desc)         // instance template offset
    .long (class_Thread_inst_tpl_handle_Object - class_Thread_inst_tpl) // handle offset in instance 
    .long (class_Thread_inst_tpl_handle_Thread - class_Thread_inst_tpl) // handle offset in instance 
    .long 0x15AC1A55
class_Thread_vtabs:
class_Thread_vtabs_entry_Thread:
    .long 0 // @class-desc filled on class loading
    .long class_Thread_so_classname
    .long (class_Thread_vtab_Thread - class_Thread_desc)
    .long (class_Thread_inst_tpl_handle_Thread - class_Thread_inst_tpl) // handle offset in instance 
class_Thread_vtabs_entry_Object:
    .long 0 // @class-desc filled on class loading
    .long class_Thread_so_super1
    .long (class_Thread_vtab_Object - class_Thread_desc)
    .long (class_Thread_inst_tpl_handle_Object - class_Thread_inst_tpl) // handle offset in instance 
class_Thread_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0
class_Thread_vtab_Thread:
class_Thread_vtab_Thread_method_getClass:
    .long class_Object_mo_getClass; .long _cThreadVEObject
class_Thread_vtab_Thread_method_hash:
    .long class_Object_mo_hash;     .long _cThreadVEObject
class_Thread_vtab_Thread_method_equals:
    .long class_Object_mo_equals;   .long _cThreadVEObject
class_Thread_vtab_Thread_method_rt:
    .long class_Object_mo_rt;       .long _cThreadVEObject
class_Thread_vtab_Thread_method_setRt:
    .long class_Object_mo_setRt;    .long _cThreadVEObject
class_Thread_vtab_Thread_method_run:
    .long class_Thread_mo_run;      .long _cThreadVEThread
class_Thread_vtab_Object:
    .long class_Object_mo_getClass; .long _cThreadVEObject
    .long class_Object_mo_hash;     .long _cThreadVEObject
    .long class_Object_mo_equals;   .long _cThreadVEObject
    .long class_Object_mo_rt;       .long _cThreadVEObject
    .long class_Object_mo_setRt;    .long _cThreadVEObject

_cThreadVEThread := (class_Thread_vtabs_entry_Thread - class_Thread_desc)
_cThreadVEObject := (class_Thread_vtabs_entry_Object - class_Thread_desc)

.global class_Thread_mo_run := 0 // virtual method

class_Thread_so_classname := (class_Thread_string_classname - class_Thread_desc)
class_Thread_so_super1 := (class_Thread_string_super1 - class_Thread_desc)

class_Thread_inst_tpl:
    .long 0  // @class-desc
    .long 0  // @meminfo
class_Thread_inst_tpl_handle_Thread:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Thread_inst_tpl_handle_Thread_vars_Object:
    .long (class_Thread_inst_tpl_vars_Object - class_Thread_inst_tpl) // @Super-Obj-Vars
class_Thread_inst_tpl_handle_Thread_vars_Thread:
    .long (class_Thread_inst_tpl_vars_Thread - class_Thread_inst_tpl) // @Thread-Obj-Vars
class_Thread_inst_tpl_handle_Object:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Thread_inst_tpl_handle_Object_vars_Object:
    .long (class_Thread_inst_tpl_vars_Object - class_Thread_inst_tpl) // @Object-Obj-Vars
class_Thread_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_Thread_inst_tpl_vars_Thread:
class_Thread_inst_tpl_end:

class_Thread_string_classname:
    .asciz "/my/Thread"
class_Thread_string_super1:
    .asciz "/my/Object"

// Method Offsets
.global Thread_m_getClass := (class_Thread_vtab_Thread_method_getClass - class_Thread_vtab_Thread)
.global Thread_m_hash     := (class_Thread_vtab_Thread_method_hash - class_Thread_vtab_Thread)
.global Thread_m_equals   := (class_Thread_vtab_Thread_method_equals - class_Thread_vtab_Thread)
.global Thread_m_rt       := (class_Thread_vtab_Thread_method_rt - class_Thread_vtab_Thread)
.global Thread_m_setRt    := (class_Thread_vtab_Thread_method_setRt - class_Thread_vtab_Thread)
.global Thread_m_run      := (class_Thread_vtab_Thread_method_run - class_Thread_vtab_Thread)
// Vars Offsets
// Super Vars Offsets
handle_Thread_vars_Thread := (class_Thread_inst_tpl_handle_Thread_vars_Thread - class_Thread_inst_tpl_handle_Thread)
handle_Thread_vars_Object := (class_Thread_inst_tpl_handle_Thread_vars_Object - class_Thread_inst_tpl_handle_Thread)

