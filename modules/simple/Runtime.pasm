/*[meta]
mimetype = text/x-pasm
description = core class "Runtime"
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
class = true
bootstrapOffset = class_Runtime_mo_bootstrap
*/
// CLASS Runtime extends Object
class_Runtime_desc:
    .long 0 // @class (Type Class) filled by class instantiation
    .long class_Runtime_so_classname
    .long (class_Runtime_inst_tpl_end - class_Runtime_inst_tpl) // instance size
    .long (class_Runtime_inst_tpl - class_Runtime_desc)         // instance template offset
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)               // handle offset in instance 
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)              // handle offset in instance 
    .long 0x15AC1A55
class_Runtime_vtabs:
class_Runtime_vtabs_entry_Runtime:
    .long 0 // @class-desc filled on class loading
    .long class_Runtime_so_classname
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)              // handle offset in instance 
class_Runtime_vtabs_entry_Object:
    .long 0 // @class-desc filled on class loading
    .long class_Runtime_so_super1
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)               // handle offset in instance 
class_Runtime_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0
class_Runtime_vtab_Runtime:
class_Runtime_vtab_Runtime_method_getClass:
    .long class_Object_mo_getClass; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_hash:
    .long class_Object_mo_hash; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_equals:
    .long class_Object_mo_equals; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_rt:
    .long class_Object_mo_rt; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_setRt:
    .long class_Object_mo_setRt; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_bootstrap:
    .long class_Runtime_mo_bootstrap; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_initSysCall:
    .long class_Runtime_mo_initSysCall; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_getClassDesc:
    .long class_Runtime_mo_getClassDesc; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_createInstance:
    .long class_Runtime_mo_createInstance; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_destroyInstance:
    .long class_Runtime_mo_destroyInstance; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_allocate:
    .long class_Runtime_mo_allocate; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_free:
    .long class_Runtime_mo_free; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printChar:
    .long class_Runtime_mo_printChar; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printString:
    .long class_Runtime_mo_printString; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printInt:
    .long class_Runtime_mo_printInt; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printHex:
    .long class_Runtime_mo_printHex; .long _cRuntimeVERuntime
class_Runtime_vtab_Object:
    .long class_Object_mo_getClass; .long _cRuntimeVEObject
    .long class_Object_mo_hash; .long _cRuntimeVEObject
    .long class_Object_mo_equals; .long _cRuntimeVEObject
    .long class_Object_mo_rt; .long _cRuntimeVEObject
    .long class_Object_mo_setRt; .long _cRuntimeVEObject

_cRuntimeVEObject := (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
_cRuntimeVERuntime := (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)

.global class_Runtime_mo_bootstrap       := (class_Runtime_method_bootstrap - class_Runtime_desc)
.global class_Runtime_mo_initSysCall     := (class_Runtime_method_initSysCall - class_Runtime_desc)
.global class_Runtime_mo_getClassDesc    := (class_Runtime_method_getClassDesc - class_Runtime_desc)
.global class_Runtime_mo_createInstance  := (class_Runtime_method_createInstance - class_Runtime_desc)
.global class_Runtime_mo_destroyInstance := (class_Runtime_method_destroyInstance - class_Runtime_desc)
.global class_Runtime_mo_allocate        := (class_Runtime_method_allocate - class_Runtime_desc)
.global class_Runtime_mo_free            := (class_Runtime_method_free - class_Runtime_desc)
.global class_Runtime_mo_printChar       := (class_Runtime_method_printChar - class_Runtime_desc)
.global class_Runtime_mo_printString     := (class_Runtime_method_printString - class_Runtime_desc)
.global class_Runtime_mo_printInt        := (class_Runtime_method_printInt - class_Runtime_desc)
.global class_Runtime_mo_printHex        := (class_Runtime_method_printHex - class_Runtime_desc)

class_Runtime_so_classname := (class_Runtime_string_classname - class_Runtime_desc)
class_Runtime_so_super1 := (class_Runtime_string_super1 - class_Runtime_desc)
class_Runtime_so_class := (class_Runtime_string_class - class_Runtime_desc)

class_Runtime_inst_tpl:
    .long 0  // @class-desc
    .long 0  // @meminfo
class_Runtime_inst_tpl_handle_Runtime:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Runtime_inst_tpl_handle_Runtime_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)  // @Super-Obj-Vars
class_Runtime_inst_tpl_handle_Runtime_vars_Runtime:
    .long (class_Runtime_inst_tpl_vars_Runtime - class_Runtime_inst_tpl) // @Runtime-Obj-Vars
class_Runtime_inst_tpl_handle_Object:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Runtime_inst_tpl_handle_Object_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)  // @Object-Obj-Vars
class_Runtime_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_Runtime_inst_tpl_vars_Runtime:
class_Runtime_inst_tpl_vars_Runtime_syscall_entry:
    .long 0  // @syscall-entry
class_Runtime_inst_tpl_vars_Runtime_syscall_runtime:
    .long 0  // @syscall-runtime
class_Runtime_inst_tpl_end:

class_Runtime_string_classname:
    .asciz "/my/Runtime"
class_Runtime_string_super1:
    .asciz "/my/Object"
class_Runtime_string_class:
    .asciz "/my/Class"

// Method Offsets
.global Runtime_m_getClass        := (class_Runtime_vtab_Runtime_method_getClass - class_Runtime_vtab_Runtime)
.global Runtime_m_hash            := (class_Runtime_vtab_Runtime_method_hash - class_Runtime_vtab_Runtime)
.global Runtime_m_equals          := (class_Runtime_vtab_Runtime_method_equals - class_Runtime_vtab_Runtime)
.global Runtime_m_rt              := (class_Runtime_vtab_Runtime_method_rt - class_Runtime_vtab_Runtime)
.global Runtime_m_setRt           := (class_Runtime_vtab_Runtime_method_setRt - class_Runtime_vtab_Runtime)
.global Runtime_m_bootstrap       := (class_Runtime_vtab_Runtime_method_bootstrap - class_Runtime_vtab_Runtime)
.global Runtime_m_initSysCall     := (class_Runtime_vtab_Runtime_method_initSysCall - class_Runtime_vtab_Runtime)
.global Runtime_m_getClassDesc    := (class_Runtime_vtab_Runtime_method_getClassDesc - class_Runtime_vtab_Runtime)
.global Runtime_m_createInstance  := (class_Runtime_vtab_Runtime_method_createInstance - class_Runtime_vtab_Runtime)
.global Runtime_m_destroyInstance := (class_Runtime_vtab_Runtime_method_destroyInstance - class_Runtime_vtab_Runtime)
.global Runtime_m_allocate        := (class_Runtime_vtab_Runtime_method_allocate - class_Runtime_vtab_Runtime)
.global Runtime_m_free            := (class_Runtime_vtab_Runtime_method_free - class_Runtime_vtab_Runtime)
.global Runtime_m_printChar       := (class_Runtime_vtab_Runtime_method_printChar - class_Runtime_vtab_Runtime)
.global Runtime_m_printString     := (class_Runtime_vtab_Runtime_method_printString - class_Runtime_vtab_Runtime)
.global Runtime_m_printInt        := (class_Runtime_vtab_Runtime_method_printInt - class_Runtime_vtab_Runtime)
.global Runtime_m_printHex        := (class_Runtime_vtab_Runtime_method_printHex - class_Runtime_vtab_Runtime)
// Vars Offsets
.global Runtime_i_syscall_entry   := (class_Runtime_inst_tpl_vars_Runtime_syscall_entry - class_Runtime_inst_tpl_vars_Runtime)
.global Runtime_i_syscall_runtime := (class_Runtime_inst_tpl_vars_Runtime_syscall_runtime - class_Runtime_inst_tpl_vars_Runtime)
// Super Vars Offsets
handle_Runtime_vars_Runtime := (class_Runtime_inst_tpl_handle_Runtime_vars_Runtime - class_Runtime_inst_tpl_handle_Runtime)
handle_Runtime_vars_Object  := (class_Runtime_inst_tpl_handle_Runtime_vars_Object - class_Runtime_inst_tpl_handle_Runtime)
// print* constants
.global _out := _sps_out
.global _err := _sps_err

class_Runtime_method_bootstrap:
    pushl %ebp; movl %esp, %ebp; subl 12, %esp; pushad
    movl 0x0, 24(%ebp) // default result: NULL
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_class, %eax
    
    pushl 0 // desc
    pushl %eax        // "Class"
    pushl SysCall_find_class
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl -12(%ebp)  // store @class desc
    
    movl -12(%ebp), %edx
    pushl 0     // info
    pushl class_instance_size_offset(%edx) // instance size
    pushl SysCall_allocate;
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl %eax   // return info
    addl 0, %eax; jz _bs_return  // return NULL on allocate error
    
    movl -12(%ebp), %edx
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
	movl %edi, -8(%ebp) // store @Class (Type Object)
	
    pushl -12(%ebp)
    pushl %esi; pushl Class_m_setDesc; call (%esi)
	addl 12, %esp
	
    movl 8(%ebp), %edx      // @class-desc "Runtime"
    pushl 0     // info
    pushl class_instance_size_offset(%edx) // instance size
    pushl SysCall_allocate;
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl %eax   // return info
    addl 0, %eax; jz _bs_return  // return NULL on allocate error
    
    movl 8(%ebp), %edx      // @class-desc "Runtime"
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    
    pushl %esi
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
    
    pushl 20(%ebp) // @syscall-entry
    pushl 16(%ebp) // @syscall-runtime
    pushl %esi; pushl Runtime_m_initSysCall; call (%esi)
	addl 16, %esp
	
	movl -8(%ebp), %edi // load @Class (Type Object)
    pushl %esi
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_class, %eax
    subl 4, %esp  # return value of createInstance
    pushl %eax // @classname
    pushl %esi; pushl Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %eax   // @class (Type Class)
    addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
    
    pushl 8(%ebp)      // @class-desc "Runtime"
    pushl %eax; pushl Class_m_setDesc; call (%eax)
	addl 12, %esp
	
    movl %esi, 24(%ebp) // store @runtime (Type Runtime) as result
_bs_return:
    popad; leave
    ret

class_Runtime_method_initSysCall:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    movl 16(%ebp), %eax                           // arg @syscall-runtime
    movl %eax, Runtime_i_syscall_runtime(%ebx)    // store @syscall-runtime
    movl 20(%ebp), %eax                           // arg @syscall-entry
    movl %eax, Runtime_i_syscall_entry(%ebx)      // store @syscall-entry
    
    leave
    ret

class_Runtime_method_getClassDesc:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 0         // desc
    pushl 16(%ebp)  // @classname
    pushl SysCall_find_class;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 16, %esp
    popl 20(%ebp)   // return @class desc
    
    popad; leave
    ret
    
class_Runtime_method_allocate:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 0         // info
    pushl 16(%ebp)  // param size
    pushl SysCall_allocate;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 16, %esp
    popl 20(%ebp)   // return info
    
    popad; leave
    ret

class_Runtime_method_free:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 16(%ebp)  // param info
    pushl 0         // size
    pushl SysCall_free;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 20, %esp
    
    popad; leave
    ret

class_Runtime_method_printChar:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param c
    pushl _spk_char // kind
    pushl 16(%ebp)  // param stream
    pushl SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad; leave
    ret

class_Runtime_method_printString:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)    // param s
    pushl _spk_string // kind
    pushl 16(%ebp)    // param stream
    pushl SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad; leave
    ret

class_Runtime_method_printInt:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param i
    pushl _spk_int  // kind
    pushl 16(%ebp)  // param stream
    pushl SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad; leave
    ret

class_Runtime_method_printHex:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param i
    pushl _spk_hex  // kind
    pushl 16(%ebp)  // param stream
    pushl SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad; leave
    ret
    
class_Runtime_method_destroyInstance:
    pushl %ebp; movl %esp, %ebp

    movl 16(%ebp), %eax       // @obj (Type ANY)
    movl 4(%eax), %eax        // @obj
    movl 12(%ebp), %ebx       // @this (Type Runtime)

    pushl 4(%eax)             // @obj meminfo
    pushl %ebx; pushl Runtime_m_free; call (%ebx)
    addl 12, %esp
    
    leave
    ret

class_Runtime_method_createInstance:
    pushl %ebp; movl %esp, %ebp; pushad
_crmci_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %esi       // @this (Type Runtime)
    
    subl 4, %esp  # return value of getClassDesc
    pushl 16(%ebp)  // param @classname
    pushl %esi; pushl Runtime_m_getClassDesc; call (%esi)
	addl 12, %esp
    popl %edx       // @class-desc
    addl 0, %edx; jz _crmci_return  // return NULL if class not exists
    
    cmpl 0, (%edx)
    jnz _crmci_instantiate // class already initialized
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_class, %eax
    subl 4, %esp  # return value of createInstance
    pushl %eax // @classname
    pushl %esi; pushl Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %eax   // @class (Type Class)
    addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
    
    pushl %edx                      // @class-desc
    pushl %eax; pushl Class_m_setDesc; call (%eax)
	addl 12, %esp
    
_crmci_instantiate:
    movl class_instance_size_offset(%edx), %eax // instance size
    
    subl 4, %esp  # return value of allocate
    pushl %eax
    pushl %esi; pushl Runtime_m_allocate; call (%esi)
	addl 12, %esp
    popl %eax                       // @object-meminfo
    addl 0, %eax; jz _crmci_return
    
    pushl %esi // @Runtime for later setRt
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
    
    addl 0, %esi; jz _crmci_return  // return NULL if instance could not be generated
    movl %esi, 20(%ebp)             // return correct handle
    
_crmci_return:
    popad; leave
    ret

_crh_instantiate: // %eax: @object-meminfo %ebx: @_call_entry %edx: @Class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl (%eax), %edi   // @object
    movl %edx, %esi
    addl class_instance_tpl_offset_offset(%edx), %esi // @instance tpl
    movl class_instance_size_offset(%edx), %ecx // instance size
    .byte 0xf3; .byte 0xa4 #// rep movsb // copy template to object
    
    movl (%eax), %edi   // @object
    movl %edx, (%edi)   // store @class desc in instance 
    movl %eax, 4(%edi)  // store @meminfo in instance
    
    movl %edx, %eax                 // @obj-class desc
    addl class_vtabs_offset, %eax   // @obj-class vtabs entry
_crhi_loop:
    movl _cvte_ho(%eax), %esi
    movl _cvte_vto(%eax), %ecx
    movl %ebx, (%edi, %esi)         // store @call-entry in handle
    movl %edi, 4(%edi, %esi)        // store @object in handle
    movl %ecx, 8(%edi, %esi)        // store vtab-offset in handle
    addl _cvte_size, %eax
    cmpl 0, (%eax)
    jne _crhi_loop
    
    movl %edi, %esi
    addl class_instance_Object_handle_offset(%edx), %edi // @object (Type Object)
    addl class_instance_class_handle_offset(%edx), %esi // @object (Type <class>)
    ret

_cr_mo_call_entry := (_call_entry - class_Runtime_desc)
_call_entry:
	pushl %ecx
	movl 12(%esp), %ebx	        # load object handle
	movl 4(%ebx), %ecx	        # get object
	movl 0(%ecx), %eax          # get class-desc
	addl 8(%ebx), %eax          # get vtab
	addl 8(%esp), %eax	        # get vtab-entry by adding method-offset number
	movl 0(%ecx), %ebx	        # get class-desc
	addl 4(%eax), %ebx          # get method-vtabs-entry
	addl _cvte_ho(%ebx), %ecx   # compute method-@this
	movl %ecx, 12(%esp)         # store method-@this
	movl _cvte_cdo(%ebx), %ebx  # get method-class-desc
	movl %ebx, 8(%esp)          # store method-class-desc
	addl 0(%eax), %ebx          # compute method-addr
	popl %ecx
	jmp %ebx                    # goto method

SysCall_allocate   := 1
SysCall_free       := 2
SysCall_find_class := 3
SysCall_print      := 4

_spk_char   := 0
_spk_int    := 1
_spk_hex    := 2
_spk_string := 3

_sps_out := 0
_sps_err := 1
