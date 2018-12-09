/*[meta]
mimetype = text/x-pasm
description = class "/my/Runtime"
[pool]
version = 0.1.0
class = true
bootstrapOffset = class_Runtime_mo_bootstrap
*/
// class Runtime
class_Runtime_desc:
    .long 0x15AC1A55
    .long 0
    .long class_Runtime_so_cn_Runtime
    .long (class_Runtime_cts - class_Runtime_desc)
    .long (class_Runtime_mts - class_Runtime_desc)
    .long (class_Runtime_inst_tpl - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_end - class_Runtime_inst_tpl)
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)

// class tab
class_Runtime_cts:
_cRuntimeVEObject := (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
class_Runtime_vtabs_entry_Object:
    .long 0
    .long class_Runtime_so_cn_Object
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)
_cRuntimeVERuntime := (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtabs_entry_Runtime:
    .long 0
    .long class_Runtime_so_cn_Runtime
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
class_Runtime_mts:
class_Runtime_vtab_Object:
    .long class_Object_mo_getClass
    .long _cRuntimeVEObject
    .long class_Object_mo_hash
    .long _cRuntimeVEObject
    .long class_Object_mo_equals
    .long _cRuntimeVEObject
    .long class_Object_mo_rt
    .long _cRuntimeVEObject
    .long class_Object_mo_setRt
    .long _cRuntimeVEObject
class_Runtime_vtab_Runtime:
.global Runtime_m_getClass := (class_Runtime_vtab_Runtime_method_getClass - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_getClass:
    .long class_Object_mo_getClass
    .long _cRuntimeVEObject
.global Runtime_m_hash := (class_Runtime_vtab_Runtime_method_hash - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_hash:
    .long class_Object_mo_hash
    .long _cRuntimeVEObject
.global Runtime_m_equals := (class_Runtime_vtab_Runtime_method_equals - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_equals:
    .long class_Object_mo_equals
    .long _cRuntimeVEObject
.global Runtime_m_rt := (class_Runtime_vtab_Runtime_method_rt - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_rt:
    .long class_Object_mo_rt
    .long _cRuntimeVEObject
.global Runtime_m_setRt := (class_Runtime_vtab_Runtime_method_setRt - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_setRt:
    .long class_Object_mo_setRt
    .long _cRuntimeVEObject
.global Runtime_m_bootstrap := (class_Runtime_vtab_Runtime_method_bootstrap - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_bootstrap:
    .long class_Runtime_mo_bootstrap
    .long _cRuntimeVERuntime
.global Runtime_m_initSysCall := (class_Runtime_vtab_Runtime_method_initSysCall - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_initSysCall:
    .long class_Runtime_mo_initSysCall
    .long _cRuntimeVERuntime
.global Runtime_m_getClassDesc := (class_Runtime_vtab_Runtime_method_getClassDesc - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_getClassDesc:
    .long class_Runtime_mo_getClassDesc
    .long _cRuntimeVERuntime
.global Runtime_m_allocate := (class_Runtime_vtab_Runtime_method_allocate - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_allocate:
    .long class_Runtime_mo_allocate
    .long _cRuntimeVERuntime
.global Runtime_m_free := (class_Runtime_vtab_Runtime_method_free - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_free:
    .long class_Runtime_mo_free
    .long _cRuntimeVERuntime
.global Runtime_m_printChar := (class_Runtime_vtab_Runtime_method_printChar - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_printChar:
    .long class_Runtime_mo_printChar
    .long _cRuntimeVERuntime
.global Runtime_m_printString := (class_Runtime_vtab_Runtime_method_printString - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_printString:
    .long class_Runtime_mo_printString
    .long _cRuntimeVERuntime
.global Runtime_m_printInt := (class_Runtime_vtab_Runtime_method_printInt - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_printInt:
    .long class_Runtime_mo_printInt
    .long _cRuntimeVERuntime
.global Runtime_m_printHex := (class_Runtime_vtab_Runtime_method_printHex - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_printHex:
    .long class_Runtime_mo_printHex
    .long _cRuntimeVERuntime
.global Runtime_m_destroyInstance := (class_Runtime_vtab_Runtime_method_destroyInstance - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_destroyInstance:
    .long class_Runtime_mo_destroyInstance
    .long _cRuntimeVERuntime
.global Runtime_m_as := (class_Runtime_vtab_Runtime_method_as - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_as:
    .long class_Runtime_mo_as
    .long _cRuntimeVERuntime
.global Runtime_m_createThread := (class_Runtime_vtab_Runtime_method_createThread - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_createThread:
    .long class_Runtime_mo_createThread
    .long _cRuntimeVERuntime
.global Runtime_m_createInstance := (class_Runtime_vtab_Runtime_method_createInstance - class_Runtime_vtab_Runtime)
class_Runtime_vtab_Runtime_method_createInstance:
    .long class_Runtime_mo_createInstance
    .long _cRuntimeVERuntime

// constants
// string class
class_Runtime_so_ct_class := (class_Runtime_sct_class - class_Runtime_desc)
class_Runtime_sct_class:
    .asciz "/my/Class"

// string thread
class_Runtime_so_ct_thread := (class_Runtime_sct_thread - class_Runtime_desc)
class_Runtime_sct_thread:
    .asciz "/my/Thread"

// int out
.global Runtime_c_out := 0

// int err
.global Runtime_c_err := 1

// int SysCall_allocate
class_Runtime_ict_SysCall_allocate := 1

// int SysCall_free
class_Runtime_ict_SysCall_free := 2

// int SysCall_find_class
class_Runtime_ict_SysCall_find_class := 3

// int SysCall_print
class_Runtime_ict_SysCall_print := 4

// int spk_char
class_Runtime_ict_spk_char := 0

// int spk_int
class_Runtime_ict_spk_int := 1

// int spk_hex
class_Runtime_ict_spk_hex := 2

// int spk_string
class_Runtime_ict_spk_string := 3

// int sps_out
class_Runtime_ict_sps_out := 0

// int sps_err
class_Runtime_ict_sps_err := 1

// int ch_inst_handle
class_Runtime_ict_ch_inst_handle := 4

// int ch_cts
class_Runtime_ict_ch_cts := 12

// int ch_tpl
class_Runtime_ict_ch_tpl := 20

// int ch_tpl_size
class_Runtime_ict_ch_tpl_size := 24

// int ch_tpl_obj_handle
class_Runtime_ict_ch_tpl_obj_handle := 28

// int ch_tpl_cls_handle
class_Runtime_ict_ch_tpl_cls_handle := 32

// int cts_cdo
class_Runtime_ict_cts_cdo := 0

// int cts_vto
class_Runtime_ict_cts_vto := 8

// int cts_ho
class_Runtime_ict_cts_ho := 12

// int cts_size
class_Runtime_ict_cts_size := 16

// class-name Object
class_Runtime_so_cn_Object := (class_Runtime_scn_Object - class_Runtime_desc)
class_Runtime_scn_Object:
    .asciz "/my/Object"

// class-name Runtime
class_Runtime_so_cn_Runtime := (class_Runtime_scn_Runtime - class_Runtime_desc)
class_Runtime_scn_Runtime:
    .asciz "/my/Runtime"

// instance template
class_Runtime_inst_tpl:
    .long 0
    .long 0
class_Runtime_inst_tpl_handle_Object:
    .long 0
    .long 0
    .long 0
class_Runtime_inst_tpl_handle_Object_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)
class_Runtime_inst_tpl_handle_Runtime:
    .long 0
    .long 0
    .long 0
handle_Runtime_vars_Object := (class_Runtime_inst_tpl_handle_Runtime_vars_Object - class_Runtime_inst_tpl_handle_Runtime)
class_Runtime_inst_tpl_handle_Runtime_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)
handle_Runtime_vars_Runtime := (class_Runtime_inst_tpl_handle_Runtime_vars_Runtime - class_Runtime_inst_tpl_handle_Runtime)
class_Runtime_inst_tpl_handle_Runtime_vars_Runtime:
    .long (class_Runtime_inst_tpl_vars_Runtime - class_Runtime_inst_tpl)
class_Runtime_inst_tpl_vars_Object:
// variable runtime
    .long 0
class_Runtime_inst_tpl_vars_Runtime:
// variable syscall_runtime
.global Runtime_i_syscall_runtime := (class_Runtime_inst_tpl_vars_Runtime_syscall_runtime - class_Runtime_inst_tpl_vars_Runtime)
class_Runtime_inst_tpl_vars_Runtime_syscall_runtime:
    .long 0
// variable syscall_entry
.global Runtime_i_syscall_entry := (class_Runtime_inst_tpl_vars_Runtime_syscall_entry - class_Runtime_inst_tpl_vars_Runtime)
class_Runtime_inst_tpl_vars_Runtime_syscall_entry:
    .long 0
class_Runtime_inst_tpl_end:

// method definitions
// method bootstrap
.global class_Runtime_mo_bootstrap := (class_Runtime_method_bootstrap - class_Runtime_desc)
class_Runtime_method_bootstrap:
    pushl %ebp; movl %esp, %ebp
    
    subl 12, %esp
    pushad
    
    movl 0x0, 24(%ebp) // default result: NULL
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_ct_class, %eax
    
    pushl 0 // desc
    pushl %eax        // "Class"
    pushl class_Runtime_ict_SysCall_find_class
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl -12(%ebp)  // store @class desc
    
    movl -12(%ebp), %edx
    pushl 0     // info
    pushl class_Runtime_ict_ch_tpl_size(%edx) // instance size
    pushl class_Runtime_ict_SysCall_allocate;
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl %eax   // return info
    addl 0, %eax; jz _bs_return  // return NULL on allocate error
    
    movl -12(%ebp), %edx    // @class-desc "Class"
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
	movl %edi, -8(%ebp) // store @Class (Type Object)
	
    pushl -12(%ebp)
    pushl %esi; pushl Class_m_setDesc; call (%esi)
	addl 12, %esp
	
    movl 8(%ebp), %edx      // @class-desc "Runtime"
    pushl 0     // info
    pushl class_Runtime_ict_ch_tpl_size(%edx) // instance size
    pushl class_Runtime_ict_SysCall_allocate;
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
    addl class_Runtime_so_ct_class, %eax
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
    popad
    
    leave
    ret

// method initSysCall
.global class_Runtime_mo_initSysCall := (class_Runtime_method_initSysCall - class_Runtime_desc)
class_Runtime_method_initSysCall:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    movl 16(%ebp), %eax                           // arg @syscall-runtime
    movl %eax, Runtime_i_syscall_runtime(%ebx)    // store @syscall-runtime
    movl 20(%ebp), %eax                           // arg @syscall-entry
    movl %eax, Runtime_i_syscall_entry(%ebx)      // store @syscall-entry
    
    leave
    ret

// method getClassDesc
.global class_Runtime_mo_getClassDesc := (class_Runtime_method_getClassDesc - class_Runtime_desc)
class_Runtime_method_getClassDesc:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 0         // desc
    pushl 16(%ebp)  // @classname
    pushl class_Runtime_ict_SysCall_find_class;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 16, %esp
    popl 20(%ebp)   // return @class desc
    
    popad
    
    leave
    ret

// method allocate
.global class_Runtime_mo_allocate := (class_Runtime_method_allocate - class_Runtime_desc)
class_Runtime_method_allocate:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 0         // info
    pushl 16(%ebp)  // param size
    pushl class_Runtime_ict_SysCall_allocate;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 16, %esp
    popl 20(%ebp)   // return info
    
    popad
    
    leave
    ret

// method free
.global class_Runtime_mo_free := (class_Runtime_method_free - class_Runtime_desc)
class_Runtime_method_free:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 16(%ebp)  // param info
    pushl 0         // size
    pushl class_Runtime_ict_SysCall_free;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 20, %esp
    
    popad
    
    leave
    ret

// method printChar
.global class_Runtime_mo_printChar := (class_Runtime_method_printChar - class_Runtime_desc)
class_Runtime_method_printChar:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param c
    pushl class_Runtime_ict_spk_char // kind
    pushl 16(%ebp)  // param stream
    pushl class_Runtime_ict_SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method printString
.global class_Runtime_mo_printString := (class_Runtime_method_printString - class_Runtime_desc)
class_Runtime_method_printString:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)    // param s
    pushl class_Runtime_ict_spk_string // kind
    pushl 16(%ebp)    // param stream
    pushl class_Runtime_ict_SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method printInt
.global class_Runtime_mo_printInt := (class_Runtime_method_printInt - class_Runtime_desc)
class_Runtime_method_printInt:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param i
    pushl class_Runtime_ict_spk_int  // kind
    pushl 16(%ebp)  // param stream
    pushl class_Runtime_ict_SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method printHex
.global class_Runtime_mo_printHex := (class_Runtime_method_printHex - class_Runtime_desc)
class_Runtime_method_printHex:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl handle_Runtime_vars_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param i
    pushl class_Runtime_ict_spk_hex  // kind
    pushl 16(%ebp)  // param stream
    pushl class_Runtime_ict_SysCall_print;
    pushl %esp; pushl Runtime_i_syscall_runtime(%ebx); call Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method destroyInstance
.global class_Runtime_mo_destroyInstance := (class_Runtime_method_destroyInstance - class_Runtime_desc)
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

// method as
.global class_Runtime_mo_as := (class_Runtime_method_as - class_Runtime_desc)
class_Runtime_method_as:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %esi
_crma_start:
    movl 0, 24(%ebp)    // not-found default handle: NULL
    movl 12(%ebp), %esi // @this (Type Runtime)
    
    subl 4, %esp  # return value of getClassDesc
    pushl 20(%ebp)  // param @classname
    pushl %esi; pushl Runtime_m_getClassDesc; call (%esi)
	addl 12, %esp
    popl %ecx       // @class-desc
    addl 0, %ecx; jz _crma_return   // return NULL if class not exists
   
    movl 16(%ebp), %eax             // @obj (Type ANY)
    movl 4(%eax), %ebx              // @obj
    movl (%ebx), %eax               // @obj-class desc
    addl class_Runtime_ict_ch_cts(%eax), %eax // @obj-class vtabs entry
_crma_loop:
    cmpl (%eax), %ecx
    je _crma_found
    addl class_Runtime_ict_cts_size, %eax
    cmpl 0, (%eax)
    je _crma_return
    jmp _crma_loop
_crma_found:
    addl class_Runtime_ict_cts_ho(%eax), %ebx
    movl %ebx, 24(%ebp) // return correct handle
_crma_return:
    popl %esi
    popl %ecx
    
    leave
    ret

// method createThread
.global class_Runtime_mo_createThread := (class_Runtime_method_createThread - class_Runtime_desc)
class_Runtime_method_createThread:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %esi
_crmct_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %esi       // @this (Type Runtime)
    
    subl 4, %esp  # return value of createInstance
    pushl 16(%ebp)  // param @classname
    pushl %esi; pushl Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %ecx; // @instance (type <classname>)
    addl 0, %ecx; jz _crmct_return // break if not instantiated
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_ct_thread, %eax
    subl 4, %esp  # return value of as
    pushl %eax
    pushl %ecx
    pushl %esi; pushl Runtime_m_as; call (%esi)
	addl 16, %esp
    popl %eax; // @instance (type "Thread")
    addl 0, %eax; jz _crmct_cleanup // destroy instance if not a thread
    
    movl %eax, 20(%ebp)  // return @instance (type "Thread")
	jmp _crmct_return
    
_crmct_cleanup:
    pushl %ecx
    pushl %esi; pushl Runtime_m_destroyInstance; call (%esi)
	addl 12, %esp
_crmct_return:
    popl %esi
    popl %ecx
    
    leave
    ret

// method createInstance
.global class_Runtime_mo_createInstance := (class_Runtime_method_createInstance - class_Runtime_desc)
class_Runtime_method_createInstance:
    pushl %ebp; movl %esp, %ebp
    
    
    pushad
_crmci_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %esi       // @this (Type Runtime)
    
    subl 4, %esp  # return value of getClassDesc
    pushl 16(%ebp)  // param @classname
    pushl %esi; pushl Runtime_m_getClassDesc; call (%esi)
	addl 12, %esp
    popl %edx       // @class-desc
    addl 0, %edx; jz _crmci_return  // return NULL if class not exists
    
    cmpl 0, class_Runtime_ict_ch_inst_handle(%edx)
    jnz _crmci_instantiate // class already initialized
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_ct_class, %eax
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
    
    subl 4, %esp  # return value of allocate
    pushl class_Runtime_ict_ch_tpl_size(%edx) // instance size
    pushl %esi; pushl Runtime_m_allocate; call (%esi)
	addl 12, %esp
    popl %eax                       // @object-meminfo
    addl 0, %eax; jz _crmci_return
    
    pushl %esi // @Runtime for later setRt
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    addl 0, %esi; jz _crmci_return  // return NULL if instance could not be generated
    movl %esi, 20(%ebp)             // return correct handle
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
    
_crmci_return:
    popad
    
    leave
    ret

// method _crh_instantiate
_crh_instantiate: // %eax: @object-meminfo %ebx: @_call_entry %edx: @Class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl (%eax), %edi   // @object
    movl %edx, %esi
    addl class_Runtime_ict_ch_tpl(%edx), %esi // @instance tpl
    movl class_Runtime_ict_ch_tpl_size(%edx), %ecx // instance size
    .byte 0xf3; .byte 0xa4 #// rep movsb // copy template to object
    
    movl (%eax), %edi   // @object
    movl %edx, (%edi)   // store @class desc in instance
    movl %eax, 4(%edi)  // store @meminfo in instance
    
    movl %edx, %eax                     // @obj-class desc
    addl class_Runtime_ict_ch_cts(%eax), %eax // @obj-class vtabs entry
_crhi_loop:
    movl class_Runtime_ict_cts_ho(%eax), %esi
    movl class_Runtime_ict_cts_vto(%eax), %ecx
    movl %ebx, (%edi, %esi)         // store @call-entry in handle
    movl %edi, 4(%edi, %esi)        // store @object in handle
    movl %ecx, 8(%edi, %esi)        // store vtab-offset in handle
    addl class_Runtime_ict_cts_size, %eax
    cmpl 0, (%eax)
    jne _crhi_loop
    
    movl %edi, %esi
    addl class_Runtime_ict_ch_tpl_obj_handle(%edx), %edi // @object (Type Object)
    addl class_Runtime_ict_ch_tpl_cls_handle(%edx), %esi // @object (Type <class>)
    ret

// method _call_entry
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
	addl class_Runtime_ict_cts_ho(%ebx), %ecx   # compute method-@this
	movl %ecx, 12(%esp)         # store method-@this
	movl class_Runtime_ict_cts_cdo(%ebx), %ebx  # get method-class-desc
	movl %ebx, 8(%esp)          # store method-class-desc
	addl 0(%eax), %ebx          # compute method-addr
	popl %ecx
	jmp %ebx                    # goto method
