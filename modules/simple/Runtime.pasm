/*[meta]
mimetype = text/x-pasm
description = class "/my/Runtime"
[pool]
version = 0.1.0
class = true
bootstrapOffset = _my_Runtime_mdo_bootstrap
*/
// class Runtime
_my_Runtime:
    .long 0x15AC1A55
    .long 0
    .long _my_Runtime_cno_my_Runtime
    .long (_648788a8_cts - _my_Runtime)
    .long (_648788a8_mts - _my_Runtime)
    .long (_648788a8_tpl - _my_Runtime)
    .long (_648788a8_tpl_end - _648788a8_tpl)
    .long (_648788a8_tpl_h_e36c4e5b - _648788a8_tpl)
    .long (_648788a8_tpl_h_648788a8 - _648788a8_tpl)

// class tab
_648788a8_cts:
_648788a8_cto_e36c4e5b := (_648788a8_ct_e36c4e5b - _my_Runtime)
_648788a8_ct_e36c4e5b:
    .long 0
    .long _my_Runtime_cno_my_Object
    .long (_648788a8_mt_e36c4e5b - _my_Runtime)
    .long (_648788a8_tpl_h_e36c4e5b - _648788a8_tpl)
_648788a8_cto_648788a8 := (_648788a8_ct_648788a8 - _my_Runtime)
_648788a8_ct_648788a8:
    .long 0
    .long _my_Runtime_cno_my_Runtime
    .long (_648788a8_mt_648788a8 - _my_Runtime)
    .long (_648788a8_tpl_h_648788a8 - _648788a8_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_648788a8_mts:
_648788a8_mt_e36c4e5b:
    .long _my_Object_mdo_getClass
    .long _648788a8_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _648788a8_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _648788a8_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _648788a8_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _648788a8_cto_e36c4e5b
_648788a8_mt_648788a8:
.global _my_Runtime_m_getClass := (_648788a8_mtm_648788a8_getClass - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_getClass:
    .long _my_Object_mdo_getClass
    .long _648788a8_cto_e36c4e5b
.global _my_Runtime_m_hash := (_648788a8_mtm_648788a8_hash - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_hash:
    .long _my_Object_mdo_hash
    .long _648788a8_cto_e36c4e5b
.global _my_Runtime_m_equals := (_648788a8_mtm_648788a8_equals - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_equals:
    .long _my_Object_mdo_equals
    .long _648788a8_cto_e36c4e5b
.global _my_Runtime_m_rt := (_648788a8_mtm_648788a8_rt - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_rt:
    .long _my_Object_mdo_rt
    .long _648788a8_cto_e36c4e5b
.global _my_Runtime_m_setRt := (_648788a8_mtm_648788a8_setRt - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_setRt:
    .long _my_Object_mdo_setRt
    .long _648788a8_cto_e36c4e5b
.global _my_Runtime_m_bootstrap := (_648788a8_mtm_648788a8_bootstrap - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_bootstrap:
    .long _my_Runtime_mdo_bootstrap
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_initSysCall := (_648788a8_mtm_648788a8_initSysCall - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_initSysCall:
    .long _my_Runtime_mdo_initSysCall
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_getClassDesc := (_648788a8_mtm_648788a8_getClassDesc - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_getClassDesc:
    .long _my_Runtime_mdo_getClassDesc
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_allocate := (_648788a8_mtm_648788a8_allocate - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_allocate:
    .long _my_Runtime_mdo_allocate
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_free := (_648788a8_mtm_648788a8_free - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_free:
    .long _my_Runtime_mdo_free
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_printChar := (_648788a8_mtm_648788a8_printChar - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_printChar:
    .long _my_Runtime_mdo_printChar
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_printString := (_648788a8_mtm_648788a8_printString - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_printString:
    .long _my_Runtime_mdo_printString
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_printInt := (_648788a8_mtm_648788a8_printInt - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_printInt:
    .long _my_Runtime_mdo_printInt
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_printHex := (_648788a8_mtm_648788a8_printHex - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_printHex:
    .long _my_Runtime_mdo_printHex
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_destroyInstance := (_648788a8_mtm_648788a8_destroyInstance - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_destroyInstance:
    .long _my_Runtime_mdo_destroyInstance
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_as := (_648788a8_mtm_648788a8_as - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_as:
    .long _my_Runtime_mdo_as
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_createThread := (_648788a8_mtm_648788a8_createThread - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_createThread:
    .long _my_Runtime_mdo_createThread
    .long _648788a8_cto_648788a8
.global _my_Runtime_m_createInstance := (_648788a8_mtm_648788a8_createInstance - _648788a8_mt_648788a8)
_648788a8_mtm_648788a8_createInstance:
    .long _my_Runtime_mdo_createInstance
    .long _648788a8_cto_648788a8

// constants
// string mClass
_my_Runtime_coso_mClass := (_648788a8_cos_mClass - _my_Runtime)
_648788a8_cos_mClass:
    .asciz "/my/Class"

// string mThread
_my_Runtime_coso_mThread := (_648788a8_cos_mThread - _my_Runtime)
_648788a8_cos_mThread:
    .asciz "/my/Thread"

// int out
.global _my_Runtime_c_out := 0

// int err
.global _my_Runtime_c_err := 1

// int SysCall_allocate
_my_Runtime_coi_SysCall_allocate := 1

// int SysCall_free
_my_Runtime_coi_SysCall_free := 2

// int SysCall_find_class
_my_Runtime_coi_SysCall_find_class := 3

// int SysCall_print
_my_Runtime_coi_SysCall_print := 4

// int spk_char
_my_Runtime_coi_spk_char := 0

// int spk_int
_my_Runtime_coi_spk_int := 1

// int spk_hex
_my_Runtime_coi_spk_hex := 2

// int spk_string
_my_Runtime_coi_spk_string := 3

// int sps_out
_my_Runtime_coi_sps_out := 0

// int sps_err
_my_Runtime_coi_sps_err := 1

// int ch_inst_handle
_my_Runtime_coi_ch_inst_handle := 4

// int ch_cts
_my_Runtime_coi_ch_cts := 12

// int ch_tpl
_my_Runtime_coi_ch_tpl := 20

// int ch_tpl_size
_my_Runtime_coi_ch_tpl_size := 24

// int ch_tpl_obj_handle
_my_Runtime_coi_ch_tpl_obj_handle := 28

// int ch_tpl_cls_handle
_my_Runtime_coi_ch_tpl_cls_handle := 32

// int cts_cdo
_my_Runtime_coi_cts_cdo := 0

// int cts_vto
_my_Runtime_coi_cts_vto := 8

// int cts_ho
_my_Runtime_coi_cts_ho := 12

// int cts_size
_my_Runtime_coi_cts_size := 16

// class-name Object
_my_Runtime_cno_my_Object := (_648788a8_cn_e36c4e5b - _my_Runtime)
_648788a8_cn_e36c4e5b:
    .asciz "/my/Object"

// class-name Runtime
_my_Runtime_cno_my_Runtime := (_648788a8_cn_648788a8 - _my_Runtime)
_648788a8_cn_648788a8:
    .asciz "/my/Runtime"

// instance template
_648788a8_tpl:
    .long 0
    .long 0
_648788a8_tpl_h_e36c4e5b:
    .long 0
    .long 0
    .long 0
    .long (_648788a8_tpl_vs_e36c4e5b - _648788a8_tpl)
_648788a8_tpl_h_648788a8:
    .long 0
    .long 0
    .long 0
_my_Runtime_hvo_my_Object := (_648788a8_tpl_hv_e36c4e5b - _648788a8_tpl_h_648788a8)
_648788a8_tpl_hv_e36c4e5b:
    .long (_648788a8_tpl_vs_e36c4e5b - _648788a8_tpl)
_my_Runtime_hvo_my_Runtime := (_648788a8_tpl_hv_648788a8 - _648788a8_tpl_h_648788a8)
_648788a8_tpl_hv_648788a8:
    .long (_648788a8_tpl_vs_648788a8 - _648788a8_tpl)
_648788a8_tpl_vs_e36c4e5b:
// variable runtime
    .long 0
_648788a8_tpl_vs_648788a8:
// variable syscall_runtime
.global _my_Runtime_i_syscall_runtime := (_648788a8_tpl_v_648788a8_syscall_runtime - _648788a8_tpl_vs_648788a8)
_648788a8_tpl_v_648788a8_syscall_runtime:
    .long 0
// variable syscall_entry
.global _my_Runtime_i_syscall_entry := (_648788a8_tpl_v_648788a8_syscall_entry - _648788a8_tpl_vs_648788a8)
_648788a8_tpl_v_648788a8_syscall_entry:
    .long 0
_648788a8_tpl_end:

// method definitions
// method bootstrap
.global _my_Runtime_mdo_bootstrap := (_648788a8_md_bootstrap - _my_Runtime)
_648788a8_md_bootstrap:
    pushl %ebp; movl %esp, %ebp
    
    subl 12, %esp
    pushad
    
    movl 0x0, 24(%ebp) // default result: NULL
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl _my_Runtime_coso_mClass, %eax
    
    pushl 0 // desc
    pushl %eax        // "Class"
    pushl _my_Runtime_coi_SysCall_find_class
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl -12(%ebp)  // store @class desc
    
    movl -12(%ebp), %edx
    pushl 0     // info
    pushl _my_Runtime_coi_ch_tpl_size(%edx) // instance size
    pushl _my_Runtime_coi_SysCall_allocate;
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
    pushl %esi; pushl _my_Class_m_setDesc; call (%esi)
	addl 12, %esp
	
    movl 8(%ebp), %edx      // @class-desc "Runtime"
    pushl 0     // info
    pushl _my_Runtime_coi_ch_tpl_size(%edx) // instance size
    pushl _my_Runtime_coi_SysCall_allocate;
    pushl %esp; pushl 16(%ebp); call 20(%ebp)
    addl 16, %esp
    popl %eax   // return info
    addl 0, %eax; jz _bs_return  // return NULL on allocate error
    
    movl 8(%ebp), %edx      // @class-desc "Runtime"
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    
    pushl %esi
    pushl %edi; pushl _my_Object_m_setRt; call (%edi)
	addl 12, %esp
    
    pushl 20(%ebp) // @syscall-entry
    pushl 16(%ebp) // @syscall-runtime
    pushl %esi; pushl _my_Runtime_m_initSysCall; call (%esi)
	addl 16, %esp
	
	movl -8(%ebp), %edi // load @Class (Type Object)
    pushl %esi
    pushl %edi; pushl _my_Object_m_setRt; call (%edi)
	addl 12, %esp
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl _my_Runtime_coso_mClass, %eax
    subl 4, %esp  # return value of createInstance
    pushl %eax // @classname
    pushl %esi; pushl _my_Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %eax   // @class (Type Class)
    addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
    
    pushl 8(%ebp)      // @class-desc "Runtime"
    pushl %eax; pushl _my_Class_m_setDesc; call (%eax)
	addl 12, %esp
	
    movl %esi, 24(%ebp) // store @runtime (Type Runtime) as result
_bs_return:
    popad
    
    leave
    ret

// method initSysCall
.global _my_Runtime_mdo_initSysCall := (_648788a8_md_initSysCall - _my_Runtime)
_648788a8_md_initSysCall:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    movl 16(%ebp), %eax                           // arg @syscall-runtime
    movl %eax, _my_Runtime_i_syscall_runtime(%ebx)    // store @syscall-runtime
    movl 20(%ebp), %eax                           // arg @syscall-entry
    movl %eax, _my_Runtime_i_syscall_entry(%ebx)      // store @syscall-entry
    
    leave
    ret

// method getClassDesc
.global _my_Runtime_mdo_getClassDesc := (_648788a8_md_getClassDesc - _my_Runtime)
_648788a8_md_getClassDesc:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 0         // desc
    pushl 16(%ebp)  // @classname
    pushl _my_Runtime_coi_SysCall_find_class;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 16, %esp
    popl 20(%ebp)   // return @class desc
    
    popad
    
    leave
    ret

// method allocate
.global _my_Runtime_mdo_allocate := (_648788a8_md_allocate - _my_Runtime)
_648788a8_md_allocate:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 0         // info
    pushl 16(%ebp)  // param size
    pushl _my_Runtime_coi_SysCall_allocate;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 16, %esp
    popl 20(%ebp)   // return info
    
    popad
    
    leave
    ret

// method free
.global _my_Runtime_mdo_free := (_648788a8_md_free - _my_Runtime)
_648788a8_md_free:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 16(%ebp)  // param info
    pushl 0         // size
    pushl _my_Runtime_coi_SysCall_free;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 20, %esp
    
    popad
    
    leave
    ret

// method printChar
.global _my_Runtime_mdo_printChar := (_648788a8_md_printChar - _my_Runtime)
_648788a8_md_printChar:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param c
    pushl _my_Runtime_coi_spk_char // kind
    pushl 16(%ebp)  // param stream
    pushl _my_Runtime_coi_SysCall_print;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method printString
.global _my_Runtime_mdo_printString := (_648788a8_md_printString - _my_Runtime)
_648788a8_md_printString:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)    // param s
    pushl _my_Runtime_coi_spk_string // kind
    pushl 16(%ebp)    // param stream
    pushl _my_Runtime_coi_SysCall_print;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method printInt
.global _my_Runtime_mdo_printInt := (_648788a8_md_printInt - _my_Runtime)
_648788a8_md_printInt:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param i
    pushl _my_Runtime_coi_spk_int  // kind
    pushl 16(%ebp)  // param stream
    pushl _my_Runtime_coi_SysCall_print;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method printHex
.global _my_Runtime_mdo_printHex := (_648788a8_md_printHex - _my_Runtime)
_648788a8_md_printHex:
    pushl %ebp; movl %esp, %ebp
    
    pushad
    
    movl 12(%ebp), %eax                           // @this (Type Runtime)
    movl _my_Runtime_hvo_my_Runtime(%eax), %ebx  // inst vars offset (Runtime)
    addl 4(%eax), %ebx                            // @this.vars(Runtime)
    
    pushl 20(%ebp)  // param i
    pushl _my_Runtime_coi_spk_hex  // kind
    pushl 16(%ebp)  // param stream
    pushl _my_Runtime_coi_SysCall_print;
    pushl %esp; pushl _my_Runtime_i_syscall_runtime(%ebx); call _my_Runtime_i_syscall_entry(%ebx)
    addl 24, %esp
    
    popad
    
    leave
    ret

// method destroyInstance
.global _my_Runtime_mdo_destroyInstance := (_648788a8_md_destroyInstance - _my_Runtime)
_648788a8_md_destroyInstance:
    pushl %ebp; movl %esp, %ebp
    
    movl 16(%ebp), %eax       // @obj (Type ANY)
    movl 4(%eax), %eax        // @obj
    movl 12(%ebp), %ebx       // @this (Type Runtime)
    
    pushl 4(%eax)             // @obj meminfo
    pushl %ebx; pushl _my_Runtime_m_free; call (%ebx)
    addl 12, %esp
    
    leave
    ret

// method as
.global _my_Runtime_mdo_as := (_648788a8_md_as - _my_Runtime)
_648788a8_md_as:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %esi
_crma_start:
    movl 0, 24(%ebp)    // not-found default handle: NULL
    movl 12(%ebp), %esi // @this (Type Runtime)
    
    subl 4, %esp  # return value of getClassDesc
    pushl 20(%ebp)  // param @classname
    pushl %esi; pushl _my_Runtime_m_getClassDesc; call (%esi)
	addl 12, %esp
    popl %ecx       // @class-desc
    addl 0, %ecx; jz _crma_return   // return NULL if class not exists
   
    movl 16(%ebp), %eax             // @obj (Type ANY)
    movl 4(%eax), %ebx              // @obj
    movl (%ebx), %eax               // @obj-class desc
    addl _my_Runtime_coi_ch_cts(%eax), %eax // @obj-class vtabs entry
_crma_loop:
    cmpl (%eax), %ecx
    je _crma_found
    addl _my_Runtime_coi_cts_size, %eax
    cmpl 0, (%eax)
    je _crma_return
    jmp _crma_loop
_crma_found:
    addl _my_Runtime_coi_cts_ho(%eax), %ebx
    movl %ebx, 24(%ebp) // return correct handle
_crma_return:
    popl %esi
    popl %ecx
    
    leave
    ret

// method createThread
.global _my_Runtime_mdo_createThread := (_648788a8_md_createThread - _my_Runtime)
_648788a8_md_createThread:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %esi
_crmct_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %esi       // @this (Type Runtime)
    
    subl 4, %esp  # return value of createInstance
    pushl 16(%ebp)  // param @classname
    pushl %esi; pushl _my_Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %ecx; // @instance (type <classname>)
    addl 0, %ecx; jz _crmct_return // break if not instantiated
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl _my_Runtime_coso_mThread, %eax
    subl 4, %esp  # return value of as
    pushl %eax
    pushl %ecx
    pushl %esi; pushl _my_Runtime_m_as; call (%esi)
	addl 16, %esp
    popl %eax; // @instance (type "Thread")
    addl 0, %eax; jz _crmct_cleanup // destroy instance if not a thread
    
    movl %eax, 20(%ebp)  // return @instance (type "Thread")
	jmp _crmct_return
    
_crmct_cleanup:
    pushl %ecx
    pushl %esi; pushl _my_Runtime_m_destroyInstance; call (%esi)
	addl 12, %esp
_crmct_return:
    popl %esi
    popl %ecx
    
    leave
    ret

// method createInstance
.global _my_Runtime_mdo_createInstance := (_648788a8_md_createInstance - _my_Runtime)
_648788a8_md_createInstance:
    pushl %ebp; movl %esp, %ebp
    
    
    pushad
_crmci_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %esi       // @this (Type Runtime)
    
    subl 4, %esp  # return value of getClassDesc
    pushl 16(%ebp)  // param @classname
    pushl %esi; pushl _my_Runtime_m_getClassDesc; call (%esi)
	addl 12, %esp
    popl %edx       // @class-desc
    addl 0, %edx; jz _crmci_return  // return NULL if class not exists
    
    cmpl 0, _my_Runtime_coi_ch_inst_handle(%edx)
    jnz _crmci_instantiate // class already initialized
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl _my_Runtime_coso_mClass, %eax
    subl 4, %esp  # return value of createInstance
    pushl %eax // @classname
    pushl %esi; pushl _my_Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %eax   // @class (Type Class)
    addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
    
    pushl %edx                      // @class-desc
    pushl %eax; pushl _my_Class_m_setDesc; call (%eax)
	addl 12, %esp
    
_crmci_instantiate:
    
    subl 4, %esp  # return value of allocate
    pushl _my_Runtime_coi_ch_tpl_size(%edx) // instance size
    pushl %esi; pushl _my_Runtime_m_allocate; call (%esi)
	addl 12, %esp
    popl %eax                       // @object-meminfo
    addl 0, %eax; jz _crmci_return
    
    pushl %esi // @Runtime for later setRt
    movl 8(%ebp), %ebx      // @class-desc "Runtime"
    addl _cr_mo_call_entry, %ebx
    call _crh_instantiate // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    addl 0, %esi; jz _crmci_return  // return NULL if instance could not be generated
    movl %esi, 20(%ebp)             // return correct handle
    pushl %edi; pushl _my_Object_m_setRt; call (%edi)
	addl 12, %esp
    
_crmci_return:
    popad
    
    leave
    ret

// method _crh_instantiate
_crh_instantiate: // %eax: @object-meminfo %ebx: @_call_entry %edx: @Class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl (%eax), %edi   // @object
    movl %edx, %esi
    addl _my_Runtime_coi_ch_tpl(%edx), %esi // @instance tpl
    movl _my_Runtime_coi_ch_tpl_size(%edx), %ecx // instance size
    .byte 0xf3; .byte 0xa4 #// rep movsb // copy template to object
    
    movl (%eax), %edi   // @object
    movl %edx, (%edi)   // store @class desc in instance
    movl %eax, 4(%edi)  // store @meminfo in instance
    
    movl %edx, %eax                     // @obj-class desc
    addl _my_Runtime_coi_ch_cts(%eax), %eax // @obj-class vtabs entry
_crhi_loop:
    movl _my_Runtime_coi_cts_ho(%eax), %esi
    movl _my_Runtime_coi_cts_vto(%eax), %ecx
    movl %ebx, (%edi, %esi)         // store @call-entry in handle
    movl %edi, 4(%edi, %esi)        // store @object in handle
    movl %ecx, 8(%edi, %esi)        // store vtab-offset in handle
    addl _my_Runtime_coi_cts_size, %eax
    cmpl 0, (%eax)
    jne _crhi_loop
    
    movl %edi, %esi
    addl _my_Runtime_coi_ch_tpl_obj_handle(%edx), %edi // @object (Type Object)
    addl _my_Runtime_coi_ch_tpl_cls_handle(%edx), %esi // @object (Type <class>)
    ret

// method _call_entry
_cr_mo_call_entry := (_call_entry - _my_Runtime)
_call_entry:
	pushl %ecx
	movl 12(%esp), %ebx	        # load object handle
	movl 4(%ebx), %ecx	        # get object
	movl 0(%ecx), %eax          # get class-desc
	addl 8(%ebx), %eax          # get vtab
	addl 8(%esp), %eax	        # get vtab-entry by adding method-offset number
	movl 0(%ecx), %ebx	        # get class-desc
	addl 4(%eax), %ebx          # get method-vtabs-entry
	addl _my_Runtime_coi_cts_ho(%ebx), %ecx   # compute method-@this
	movl %ecx, 12(%esp)         # store method-@this
	movl _my_Runtime_coi_cts_cdo(%ebx), %ebx  # get method-class-desc
	movl %ebx, 8(%esp)          # store method-class-desc
	addl 0(%eax), %ebx          # compute method-addr
	popl %ecx
	jmp %ebx                    # goto method
