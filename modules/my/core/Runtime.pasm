/*[meta]
mimetype = text/x-pasm
description = class "my::core::Runtime"
[pool]
class = true
version = 0.1.0
bootstrapOffset = _my_core_Runtime_mdo_bootstrap
[pool_source]
unit = my::core::Runtime
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class Runtime
_my_core_Runtime:
    .long 0x15AC1A55
    .long 0
    .long _my_core_Runtime_cno_my_core_Runtime
    .long (_4990fdfb_cts - _my_core_Runtime)
    .long (_4990fdfb_mts - _my_core_Runtime)
    .long (_4990fdfb_mdt - _my_core_Runtime)
    .long (_4990fdfb_tpl - _my_core_Runtime)
    .long (_4990fdfb_tpl_end - _4990fdfb_tpl)
    .long (_4990fdfb_tpl_h_01a2e54e - _4990fdfb_tpl)
    .long (_4990fdfb_tpl_h_4990fdfb - _4990fdfb_tpl)

// class tab
_4990fdfb_cts:
_4990fdfb_cto_01a2e54e := (_4990fdfb_ct_01a2e54e - _my_core_Runtime)
_4990fdfb_ct_01a2e54e:
    .long 0
    .long _my_core_Runtime_cno_my_core_Object
    .long (_4990fdfb_mt_01a2e54e - _my_core_Runtime)
    .long (_4990fdfb_tpl_h_01a2e54e - _4990fdfb_tpl)
_4990fdfb_cto_4990fdfb := (_4990fdfb_ct_4990fdfb - _my_core_Runtime)
_4990fdfb_ct_4990fdfb:
    .long 0
    .long _my_core_Runtime_cno_my_core_Runtime
    .long (_4990fdfb_mt_4990fdfb - _my_core_Runtime)
    .long (_4990fdfb_tpl_h_4990fdfb - _4990fdfb_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_4990fdfb_mts:
_4990fdfb_mt_01a2e54e:
_my_core_Object_m_getClass := 0
    .long 0
    .long _4990fdfb_cto_01a2e54e
_my_core_Object_m_hash := 8
    .long 4
    .long _4990fdfb_cto_01a2e54e
_my_core_Object_m_equals := 16
    .long 8
    .long _4990fdfb_cto_01a2e54e
_my_core_Object_m_rt := 24
    .long 12
    .long _4990fdfb_cto_01a2e54e
_my_core_Object_m_setRt := 32
    .long 16
    .long _4990fdfb_cto_01a2e54e
_4990fdfb_mt_4990fdfb:
_my_core_Runtime_m_getClass := 0
    .long 0
    .long _4990fdfb_cto_01a2e54e
_my_core_Runtime_m_hash := 8
    .long 4
    .long _4990fdfb_cto_01a2e54e
_my_core_Runtime_m_equals := 16
    .long 8
    .long _4990fdfb_cto_01a2e54e
_my_core_Runtime_m_rt := 24
    .long 12
    .long _4990fdfb_cto_01a2e54e
_my_core_Runtime_m_setRt := 32
    .long 16
    .long _4990fdfb_cto_01a2e54e
_my_core_Runtime_m_initSysCall := 40
    .long 4
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_getClassDesc := 48
    .long 8
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_allocate := 56
    .long 12
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_free := 64
    .long 16
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_printChar := 72
    .long 20
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_printString := 80
    .long 24
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_printInt := 88
    .long 28
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_printHex := 96
    .long 32
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_destroyInstance := 104
    .long 36
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_cast := 112
    .long 40
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_createAndRunThread := 120
    .long 44
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_createInstance := 128
    .long 48
    .long _4990fdfb_cto_4990fdfb
_my_core_Runtime_m_bootstrap := 136
    .long 0
    .long _4990fdfb_cto_4990fdfb

// methods tab
_4990fdfb_mdt:
_my_core_Runtime_mdo_bootstrap := (_4990fdfb_md_bootstrap - _my_core_Runtime)
    .long _my_core_Runtime_mdo_bootstrap
_my_core_Runtime_mdo_initSysCall := (_4990fdfb_md_initSysCall - _my_core_Runtime)
    .long _my_core_Runtime_mdo_initSysCall
_my_core_Runtime_mdo_getClassDesc := (_4990fdfb_md_getClassDesc - _my_core_Runtime)
    .long _my_core_Runtime_mdo_getClassDesc
_my_core_Runtime_mdo_allocate := (_4990fdfb_md_allocate - _my_core_Runtime)
    .long _my_core_Runtime_mdo_allocate
_my_core_Runtime_mdo_free := (_4990fdfb_md_free - _my_core_Runtime)
    .long _my_core_Runtime_mdo_free
_my_core_Runtime_mdo_printChar := (_4990fdfb_md_printChar - _my_core_Runtime)
    .long _my_core_Runtime_mdo_printChar
_my_core_Runtime_mdo_printString := (_4990fdfb_md_printString - _my_core_Runtime)
    .long _my_core_Runtime_mdo_printString
_my_core_Runtime_mdo_printInt := (_4990fdfb_md_printInt - _my_core_Runtime)
    .long _my_core_Runtime_mdo_printInt
_my_core_Runtime_mdo_printHex := (_4990fdfb_md_printHex - _my_core_Runtime)
    .long _my_core_Runtime_mdo_printHex
_my_core_Runtime_mdo_destroyInstance := (_4990fdfb_md_destroyInstance - _my_core_Runtime)
    .long _my_core_Runtime_mdo_destroyInstance
_my_core_Runtime_mdo_cast := (_4990fdfb_md_cast - _my_core_Runtime)
    .long _my_core_Runtime_mdo_cast
_my_core_Runtime_mdo_createAndRunThread := (_4990fdfb_md_createAndRunThread - _my_core_Runtime)
    .long _my_core_Runtime_mdo_createAndRunThread
_my_core_Runtime_mdo_createInstance := (_4990fdfb_md_createInstance - _my_core_Runtime)
    .long _my_core_Runtime_mdo_createInstance
    .long 0
    .long 0

// constants
// int out
_my_core_Runtime_coi_out := 0

// int err
_my_core_Runtime_coi_err := 1

// string mClass
_my_core_Runtime_coso_mClass := (_4990fdfb_cos_mClass - _my_core_Runtime)
_4990fdfb_cos_mClass:
    .asciz "my::core::Class"

// string mThread
_my_core_Runtime_coso_mThread := (_4990fdfb_cos_mThread - _my_core_Runtime)
_4990fdfb_cos_mThread:
    .asciz "my::core::Thread"

// int SysCall_allocate
_my_core_Runtime_coi_SysCall_allocate := 1

// int SysCall_free
_my_core_Runtime_coi_SysCall_free := 2

// int SysCall_find_class
_my_core_Runtime_coi_SysCall_find_class := 3

// int SysCall_print
_my_core_Runtime_coi_SysCall_print := 4

// int spk_char
_my_core_Runtime_coi_spk_char := 0

// int spk_int
_my_core_Runtime_coi_spk_int := 1

// int spk_hex
_my_core_Runtime_coi_spk_hex := 2

// int spk_string
_my_core_Runtime_coi_spk_string := 3

// int sps_out
_my_core_Runtime_coi_sps_out := 0

// int sps_err
_my_core_Runtime_coi_sps_err := 1

// int ch_inst_handle
_my_core_Runtime_coi_ch_inst_handle := 4

// int ch_cts
_my_core_Runtime_coi_ch_cts := 12

// int ch_mt
_my_core_Runtime_coi_ch_mt := 20

// int ch_tpl
_my_core_Runtime_coi_ch_tpl := 24

// int ch_tpl_size
_my_core_Runtime_coi_ch_tpl_size := 28

// int ch_tpl_obj_handle
_my_core_Runtime_coi_ch_tpl_obj_handle := 32

// int ch_tpl_cls_handle
_my_core_Runtime_coi_ch_tpl_cls_handle := 36

// int cts_cdo
_my_core_Runtime_coi_cts_cdo := 0

// int cts_vto
_my_core_Runtime_coi_cts_vto := 8

// int cts_ho
_my_core_Runtime_coi_cts_ho := 12

// int cts_size
_my_core_Runtime_coi_cts_size := 16

// class-name Object
_my_core_Runtime_cno_my_core_Object := (_4990fdfb_cn_01a2e54e - _my_core_Runtime)
_4990fdfb_cn_01a2e54e:
    .asciz "my::core::Object"

// class-name Runtime
_my_core_Runtime_cno_my_core_Runtime := (_4990fdfb_cn_4990fdfb - _my_core_Runtime)
_4990fdfb_cn_4990fdfb:
    .asciz "my::core::Runtime"

// instance template
_4990fdfb_tpl:
    .long 0
    .long 0
_4990fdfb_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_4990fdfb_tpl_vs_01a2e54e - _4990fdfb_tpl)
_4990fdfb_tpl_h_4990fdfb:
    .long 0
    .long 0
    .long 0
_my_core_Runtime_hvo_my_core_Object := (_4990fdfb_tpl_hv_01a2e54e - _4990fdfb_tpl_h_4990fdfb)
_4990fdfb_tpl_hv_01a2e54e:
    .long (_4990fdfb_tpl_vs_01a2e54e - _4990fdfb_tpl)
_my_core_Runtime_hvo_my_core_Runtime := (_4990fdfb_tpl_hv_4990fdfb - _4990fdfb_tpl_h_4990fdfb)
_4990fdfb_tpl_hv_4990fdfb:
    .long (_4990fdfb_tpl_vs_4990fdfb - _4990fdfb_tpl)
_4990fdfb_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_4990fdfb_tpl_v_01a2e54e_runtime - _4990fdfb_tpl_vs_01a2e54e)
_4990fdfb_tpl_v_01a2e54e_runtime:
    .long 0
_4990fdfb_tpl_vs_4990fdfb:
// variable syscall_runtime
_my_core_Runtime_i_syscall_runtime := (_4990fdfb_tpl_v_4990fdfb_syscall_runtime - _4990fdfb_tpl_vs_4990fdfb)
_4990fdfb_tpl_v_4990fdfb_syscall_runtime:
    .long 0
// variable syscall_entry
_my_core_Runtime_i_syscall_entry := (_4990fdfb_tpl_v_4990fdfb_syscall_entry - _4990fdfb_tpl_vs_4990fdfb)
_4990fdfb_tpl_v_4990fdfb_syscall_entry:
    .long 0
_4990fdfb_tpl_end:

// method definitions
// method bootstrap
_4990fdfb_md_bootstrap:
    pushl %ebp; movl %esp, %ebp
    
// TODO #3: inline method-indices in method-call-generation
        _my_core_Class_m_setDesc := 48
            subl 12, %esp
            pushad
            
            movl 0x0, 24(%ebp)  // default result: NULL
            movl 8(%ebp), %eax  // @class-desc "Runtime"
            addl _my_core_Runtime_coso_mClass, %eax
            
            pushl 0     // desc
            pushl %eax  // "/my/Class"
            pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl -12(%ebp)      // store @class desc
            
            movl -12(%ebp), %edx
            pushl 0     // info
            pushl _my_core_Runtime_coi_ch_tpl_size(%edx) // instance size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl %eax   // return info
            addl 0, %eax; jz _bs_return // return NULL on allocate error
            
            movl -12(%ebp), %edx    // @class-desc "Class"
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
        	movl %edi, -8(%ebp)     // store @Class (Type Object)
        	
            pushl -12(%ebp)
            pushl %esi; pushl _my_core_Class_m_setDesc; call (%esi)
        	addl 12, %esp
        	
            movl 8(%ebp), %edx      // @class-desc "Runtime"
            pushl 0     // info
            pushl _my_core_Runtime_coi_ch_tpl_size(%edx) // instance size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl %eax   // return info
            addl 0, %eax; jz _bs_return  // return NULL on allocate error
            
            movl 8(%ebp), %edx      // @class-desc "Runtime"
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
            
            pushl %esi
            pushl %edi; pushl _my_core_Object_m_setRt; call (%edi)
        	addl 12, %esp
            
            pushl 20(%ebp)  // @syscall-entry
            pushl 16(%ebp)  // @syscall-runtime
            pushl %esi; pushl _my_core_Runtime_m_initSysCall; call (%esi)
        	addl 16, %esp
        	
        	movl -8(%ebp), %edi     // load @Class (Type Object)
            pushl %esi
            pushl %edi; pushl _my_core_Object_m_setRt; call (%edi)
        	addl 12, %esp
            
            movl 8(%ebp), %eax      // @class-desc "Runtime"
            addl _my_core_Runtime_coso_mClass, %eax
            subl 4, %esp    // return value of createInstance
            pushl %eax      // @classname
            pushl %esi; pushl _my_core_Runtime_m_createInstance; call (%esi)
        	addl 12, %esp
            popl %eax       // @class (Type Class)
            addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
            
            pushl 8(%ebp)   // @class-desc "Runtime"
            pushl %eax; pushl _my_core_Class_m_setDesc; call (%eax)
        	addl 12, %esp
        	
            movl %esi, 24(%ebp) // store @runtime (Type Runtime) as result
        _bs_return:
            popad
    
    leave
    ret

// method initSysCall
_4990fdfb_md_initSysCall:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            movl 16(%ebp), %eax                             // arg @syscall-runtime
            movl %eax, _my_core_Runtime_i_syscall_runtime(%ebx)  // store @syscall-runtime
            movl 20(%ebp), %eax                             // arg @syscall-entry
            movl %eax, _my_core_Runtime_i_syscall_entry(%ebx)    // store @syscall-entry
    
    leave
    ret

// method getClassDesc
_4990fdfb_md_getClassDesc:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 0         // desc
            pushl 16(%ebp)  // @classname
            pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 16, %esp
            popl 20(%ebp)   // return @class desc
            
            popad
    
    leave
    ret

// method allocate
_4990fdfb_md_allocate:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 0         // info
            pushl 16(%ebp)  // param size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 16, %esp
            popl 20(%ebp)   // return info
            
            popad
    
    leave
    ret

// method free
_4990fdfb_md_free:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param info
            pushl 0         // size
            pushl _my_core_Runtime_coi_SysCall_free
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 20, %esp
            
            popad
    
    leave
    ret

// method printChar
_4990fdfb_md_printChar:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param c
            pushl _my_core_Runtime_coi_spk_char // kind
            pushl 20(%ebp)  // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
            
            popad
    
    leave
    ret

// method printString
_4990fdfb_md_printString:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)    // param s
            pushl _my_core_Runtime_coi_spk_string // kind
            pushl 20(%ebp)    // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
            
            popad
    
    leave
    ret

// method printInt
_4990fdfb_md_printInt:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param i
            pushl _my_core_Runtime_coi_spk_int  // kind
            pushl 20(%ebp)  // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
            
            popad
    
    leave
    ret

// method printHex
_4990fdfb_md_printHex:
    pushl %ebp; movl %esp, %ebp
    
            pushad
            
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param i
            pushl _my_core_Runtime_coi_spk_hex  // kind
            pushl 20(%ebp)  // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
            
            popad
    
    leave
    ret

// method destroyInstance
_4990fdfb_md_destroyInstance:
    pushl %ebp; movl %esp, %ebp
    
            movl 16(%ebp), %eax       // @obj (Type ANY)
            movl 4(%eax), %eax        // @obj
            movl 12(%ebp), %ebx       // @this (Type Runtime)
            
            pushl 4(%eax)             // @obj meminfo
            pushl %ebx; pushl _my_core_Runtime_m_free; call (%ebx)
            addl 12, %esp
    
    leave
    ret

// method cast
_4990fdfb_md_cast:
    pushl %ebp; movl %esp, %ebp
    
            pushl %ecx
            pushl %esi
        _crma_start:
            movl 0, 24(%ebp)    // not-found default handle: NULL
            movl 12(%ebp), %esi // @this (Type Runtime)
            
            subl 4, %esp        // return value of getClassDesc
            pushl 16(%ebp)      // param @classname
            pushl %esi; pushl _my_core_Runtime_m_getClassDesc; call (%esi)
        	addl 12, %esp
            popl %ecx           // @class-desc
            addl 0, %ecx; jz _crma_return   // return NULL if class not exists
           
            movl 20(%ebp), %eax // @obj (Type ANY)
            movl 4(%eax), %ebx  // @obj
            movl (%ebx), %eax   // @obj-class desc
            addl _my_core_Runtime_coi_ch_cts(%eax), %eax // @obj-class vtabs entry
        _crma_loop:
            cmpl (%eax), %ecx
            je _crma_found
            addl _my_core_Runtime_coi_cts_size, %eax
            cmpl 0, (%eax)
            je _crma_return
            jmp _crma_loop
        _crma_found:
            addl _my_core_Runtime_coi_cts_ho(%eax), %ebx
            movl %ebx, 24(%ebp) // return correct handle
        _crma_return:
            popl %esi
            popl %ecx
    
    leave
    ret

// method createAndRunThread
_4990fdfb_md_createAndRunThread:
    pushl %ebp; movl %esp, %ebp
    
// TODO #3: inline method-indices in method-call-generation
        _my_core_Thread_m_run := 40
            pushl %ecx
            pushl %esi
        _mcrmcart_start:
            movl 12(%ebp), %esi // @this (Type Runtime)
            subl 4, %esp        // return value of createInstance
            pushl 16(%ebp)      // param @classname
            pushl %esi; pushl _my_core_Runtime_m_createInstance; call (%esi)
        	addl 12, %esp
            popl %ecx;          // @instance (type <classname>)
            addl 0, %ecx; jz _mcrmcart_return // break if not instantiated
            movl 8(%ebp), %eax  // @class-desc "Runtime"
            addl _my_core_Runtime_coso_mThread, %eax
            subl 4, %esp        // return value of as
            pushl %ecx
            pushl %eax
            pushl %esi; pushl _my_core_Runtime_m_cast; call (%esi)
            addl 16, %esp
            popl %eax;          // @instance (type "Thread")
            addl 0, %eax; jz _mcrmcart_cleanup // destroy instance if not a thread
            movl %eax, %ecx
            pushl %ecx; pushl _my_core_Thread_m_run; call (%ecx)
            addl 8, %esp
        _mcrmcart_cleanup:
            pushl %ecx
            pushl %esi; pushl _my_core_Runtime_m_destroyInstance; call (%esi)
        	addl 12, %esp
        _mcrmcart_return:
            popl %esi
            popl %ecx
    
    leave
    ret

// method createInstance
_4990fdfb_md_createInstance:
    pushl %ebp; movl %esp, %ebp
    
            pushad
        _crmci_start:
            movl 0, 20(%ebp)    // default handle: NULL
            movl 12(%ebp), %esi // @this (Type Runtime)
            subl 4, %esp    // return value of getClassDesc
            pushl 16(%ebp)  // param @classname
            pushl %esi; pushl _my_core_Runtime_m_getClassDesc; call (%esi)
        	addl 12, %esp
            popl %edx       // @class-desc
            addl 0, %edx; jz _crmci_return  // return NULL if class not exists
            cmpl 0, _my_core_Runtime_coi_ch_inst_handle(%edx)
            jnz _crmci_instantiate  // class already initialized
            movl 8(%ebp), %eax      // @class-desc "Runtime"
            addl _my_core_Runtime_coso_mClass, %eax
            subl 4, %esp    // return value of createInstance
            pushl %eax      // @classname
            pushl %esi; pushl _my_core_Runtime_m_createInstance; call (%esi)
        	addl 12, %esp
            popl %eax       // @class (Type Class)
            addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
            pushl %edx      // @class-desc
            pushl %eax; pushl _my_core_Class_m_setDesc; call (%eax)
        	addl 12, %esp
        _crmci_instantiate:
            subl 4, %esp    // return value of allocate
            pushl _my_core_Runtime_coi_ch_tpl_size(%edx) // instance size
            pushl %esi; pushl _my_core_Runtime_m_allocate; call (%esi)
        	addl 12, %esp
            popl %eax       // @object-meminfo
            addl 0, %eax; jz _crmci_return
            pushl %esi      // @Runtime for later setRt
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
            addl 0, %esi; jz _crmci_return  // return NULL if instance could not be generated
            movl %esi, 20(%ebp)             // return correct handle
            pushl %edi; pushl _my_core_Object_m_setRt; call (%edi)
        	addl 12, %esp
        _crmci_return:
            popad
    
    leave
    ret

// method _crh_instantiate
        _crh_instantiate:       // %eax: @object-meminfo %ebx: @_call_entry %edx: @Class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
            movl (%eax), %edi   // @object
            movl %edx, %esi
            addl _my_core_Runtime_coi_ch_tpl(%edx), %esi         // @instance tpl
            movl _my_core_Runtime_coi_ch_tpl_size(%edx), %ecx    // instance size
            .byte 0xf3; .byte 0xa4 #// rep movsb // copy template to object
            
            movl (%eax), %edi   // @object
            movl %edx, (%edi)   // store @class desc in instance 
            movl %eax, 4(%edi)  // store @meminfo in instance
            
            movl %edx, %eax     // @obj-class desc
            addl _my_core_Runtime_coi_ch_cts(%eax), %eax         // @obj-class vtabs entry
        _crhi_loop:
            movl _my_core_Runtime_coi_cts_ho(%eax), %esi
            movl _my_core_Runtime_coi_cts_vto(%eax), %ecx
            movl %ebx, (%edi, %esi)     // store @call-entry in handle
            movl %edi, 4(%edi, %esi)    // store @object in handle
            movl %ecx, 8(%edi, %esi)    // store vtab-offset in handle
            addl _my_core_Runtime_coi_cts_size, %eax
            cmpl 0, (%eax)
            jne _crhi_loop
            
            movl %edi, %esi
            addl _my_core_Runtime_coi_ch_tpl_obj_handle(%edx), %edi // @object (Type Object)
            addl _my_core_Runtime_coi_ch_tpl_cls_handle(%edx), %esi // @object (Type <class>)
            ret

// method _call_entry
        _cr_mo_call_entry := (_call_entry - _my_core_Runtime)
        _call_entry:
            pushl %ecx
            movl 12(%esp), %ebx // load object handle
            movl 4(%ebx), %ecx	// get object
            movl 0(%ecx), %eax  // get class-desc
            addl 8(%ebx), %eax  // get vtab
            addl 8(%esp), %eax	// get vtab-entry by adding method-offset number
            movl 0(%ecx), %ebx	// get class-desc
            addl 4(%eax), %ebx  // get method-vtabs-entry
            addl _my_core_Runtime_coi_cts_ho(%ebx), %ecx  // compute method-@this
            movl %ecx, 12(%esp) // store method-@this
            movl _my_core_Runtime_coi_cts_cdo(%ebx), %ebx // get method-class-desc
            movl %ebx, 8(%esp)  // store method-class-desc
            movl %ebx, %ecx
            addl _my_core_Runtime_coi_ch_mt(%ecx), %ecx   // get methods-tab
            addl 0(%eax), %ecx  // get method-offset-addr
            addl (%ecx), %ebx   // compute method-addr
            popl %ecx
            jmp %ebx            // goto method
