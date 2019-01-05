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
    .long _my_core_Runtime_coso_CLASSNAME
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
    .long _my_core_Runtime_coso_string_4
    .long (_4990fdfb_mt_01a2e54e - _my_core_Runtime)
    .long (_4990fdfb_tpl_h_01a2e54e - _4990fdfb_tpl)
_4990fdfb_cto_4990fdfb := (_4990fdfb_ct_4990fdfb - _my_core_Runtime)
_4990fdfb_ct_4990fdfb:
    .long 0
    .long _my_core_Runtime_coso_CLASSNAME
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
    .long 0
    .long _4990fdfb_cto_01a2e54e
    .long 4
    .long _4990fdfb_cto_01a2e54e
    .long 8
    .long _4990fdfb_cto_01a2e54e
    .long 12
    .long _4990fdfb_cto_01a2e54e
    .long 16
    .long _4990fdfb_cto_01a2e54e
_4990fdfb_mt_4990fdfb:
    .long 0
    .long _4990fdfb_cto_01a2e54e
    .long 4
    .long _4990fdfb_cto_01a2e54e
    .long 8
    .long _4990fdfb_cto_01a2e54e
    .long 12
    .long _4990fdfb_cto_01a2e54e
    .long 16
    .long _4990fdfb_cto_01a2e54e
    .long 4
    .long _4990fdfb_cto_4990fdfb
    .long 8
    .long _4990fdfb_cto_4990fdfb
    .long 12
    .long _4990fdfb_cto_4990fdfb
    .long 16
    .long _4990fdfb_cto_4990fdfb
    .long 20
    .long _4990fdfb_cto_4990fdfb
    .long 24
    .long _4990fdfb_cto_4990fdfb
    .long 28
    .long _4990fdfb_cto_4990fdfb
    .long 32
    .long _4990fdfb_cto_4990fdfb
    .long 36
    .long _4990fdfb_cto_4990fdfb
    .long 40
    .long _4990fdfb_cto_4990fdfb
    .long 44
    .long _4990fdfb_cto_4990fdfb
    .long 48
    .long _4990fdfb_cto_4990fdfb
    .long 0
    .long _4990fdfb_cto_4990fdfb

// methods tab
_4990fdfb_mdt:
_my_core_Runtime_mdo_bootstrap := (_4990fdfb_md_bootstrap - _my_core_Runtime)
    .long (_4990fdfb_md_bootstrap - _my_core_Runtime)
    .long (_4990fdfb_md_initSysCall - _my_core_Runtime)
    .long (_4990fdfb_md_getClassDesc - _my_core_Runtime)
    .long (_4990fdfb_md_allocate - _my_core_Runtime)
    .long (_4990fdfb_md_free - _my_core_Runtime)
    .long (_4990fdfb_md_printChar - _my_core_Runtime)
    .long (_4990fdfb_md_printString - _my_core_Runtime)
    .long (_4990fdfb_md_printInt - _my_core_Runtime)
    .long (_4990fdfb_md_printHex - _my_core_Runtime)
    .long (_4990fdfb_md_destroyInstance - _my_core_Runtime)
    .long (_4990fdfb_md_cast - _my_core_Runtime)
    .long (_4990fdfb_md_createAndRunThread - _my_core_Runtime)
    .long (_4990fdfb_md_createInstance - _my_core_Runtime)
    .long 0
    .long 0

// constants
// int out
_my_core_Runtime_coi_out := 0

// int err
_my_core_Runtime_coi_err := 1

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

// string newline
_my_core_Runtime_coso_newline := (_4990fdfb_cos_newline - _my_core_Runtime)
_4990fdfb_cos_newline:
    .asciz "\n"

// string CLASSNAME
_my_core_Runtime_coso_CLASSNAME := (_4990fdfb_cos_CLASSNAME - _my_core_Runtime)
_4990fdfb_cos_CLASSNAME:
    .asciz "my::core::Runtime"

// string string_2
_my_core_Runtime_coso_string_2 := (_4990fdfb_cos_string_2 - _my_core_Runtime)
_4990fdfb_cos_string_2:
    .asciz "my::core::Class"

// string string_3
_my_core_Runtime_coso_string_3 := (_4990fdfb_cos_string_3 - _my_core_Runtime)
_4990fdfb_cos_string_3:
    .asciz "my::core::Thread"

// string string_4
_my_core_Runtime_coso_string_4 := (_4990fdfb_cos_string_4 - _my_core_Runtime)
_4990fdfb_cos_string_4:
    .asciz "my::core::Object"

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
    subl 52, %esp
    pushad
    movl 0, -4(%ebp)
    movl 0, -8(%ebp)
    movl 0, -12(%ebp)
    movl 0, -16(%ebp)
    movl 0, -20(%ebp)
    movl 0, -24(%ebp)
    movl 0, -28(%ebp)
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_2, %eax
    movl %eax, -32(%ebp)
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_CLASSNAME, %eax
    movl %eax, -36(%ebp)
            pushl 0         // desc
            pushl -32(%ebp) // var <sClass>
            pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl -4(%ebp)   // store @class desc in var <cdClass>
cmpl 0, -4(%ebp); je _bs_return_null // return NULL if class not found
            pushl 0                 // space for meminfo
            movl -4(%ebp), %edx     // var <cdClass>
            pushl _my_core_Runtime_coi_ch_tpl_size(%edx) // instance size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl -24(%ebp)  // store meminfo in var <icClass>
cmpl 0, -24(%ebp); je _bs_return_null // return NULL on allocate error
            movl -24(%ebp), %eax    // var <icClass>
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            movl -4(%ebp), %edx     // var <cdClass>
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
        	movl %esi, -12(%ebp)    // store @Class (Type Class) in var <cClass>
            pushl 0         // desc
            pushl -36(%ebp) // var <sRuntime>
            pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl -8(%ebp)   // store @class desc in var <cdRuntime>
cmpl 0, -8(%ebp); je _bs_return_null // return NULL if class not found
            pushl 0                 // space for meminfo
            movl -8(%ebp), %edx     // var <cdRuntime>
            pushl _my_core_Runtime_coi_ch_tpl_size(%edx) // instance size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl 16(%ebp); call 20(%ebp)
            addl 16, %esp
            popl -28(%ebp)  // store meminfo in var <irt>
cmpl 0, -28(%ebp); je _bs_return_null // return NULL on allocate error
            movl -28(%ebp), %eax    // var <irt>
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            movl -8(%ebp), %edx     // var <cdRuntime>
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
        	movl %esi, -20(%ebp)    // store @Class (Type Runtime) in var <rt>
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 12, %esp
    pushl -4(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    pushl -20(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 12, %esp
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -44(%ebp)
    pushl -44(%ebp)
    pushl -40(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 16, %esp
    subl 4, %esp
    pushl -32(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -48(%ebp)
    movl -48(%ebp), %eax
    movl %eax, -16(%ebp)
cmpl 0, -16(%ebp); je _bs_return_null // return NULL if class could not be initialized
    pushl -8(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    movl -20(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_return
_bs_return_null:
    movl 0, -52(%ebp)
    movl -52(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_return
_4990fdfb_md_bootstrap_return:
    popad
    leave
    ret

// method initSysCall
_4990fdfb_md_initSysCall:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -8(%ebp)
    movl -4(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl -8(%ebp), %eax
    movl %eax, _my_core_Runtime_i_syscall_runtime(%ebx)
    movl 20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl -4(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl -12(%ebp), %eax
    movl %eax, _my_core_Runtime_i_syscall_entry(%ebx)
_4990fdfb_md_initSysCall_return:
    popad
    leave
    ret

// method getClassDesc
_4990fdfb_md_getClassDesc:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 0         // desc
            pushl 16(%ebp)  // @classname
            pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 16, %esp
            popl 20(%ebp)   // return @class desc
_4990fdfb_md_getClassDesc_return:
    popad
    leave
    ret

// method allocate
_4990fdfb_md_allocate:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 0         // info
            pushl 16(%ebp)  // param size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 16, %esp
            popl 20(%ebp)   // return info
_4990fdfb_md_allocate_return:
    popad
    leave
    ret

// method free
_4990fdfb_md_free:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param info
            pushl 0         // size
            pushl _my_core_Runtime_coi_SysCall_free
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 20, %esp
_4990fdfb_md_free_return:
    popad
    leave
    ret

// method printChar
_4990fdfb_md_printChar:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param c
            pushl _my_core_Runtime_coi_spk_char // kind
            pushl 20(%ebp)  // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
_4990fdfb_md_printChar_return:
    popad
    leave
    ret

// method printString
_4990fdfb_md_printString:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)    // param s
            pushl _my_core_Runtime_coi_spk_string // kind
            pushl 20(%ebp)    // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
_4990fdfb_md_printString_return:
    popad
    leave
    ret

// method printInt
_4990fdfb_md_printInt:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param i
            pushl _my_core_Runtime_coi_spk_int  // kind
            pushl 20(%ebp)  // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
_4990fdfb_md_printInt_return:
    popad
    leave
    ret

// method printHex
_4990fdfb_md_printHex:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
            movl 12(%ebp), %eax                             // @this (Type Runtime)
            movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx     // inst vars offset (Runtime)
            addl 4(%eax), %ebx                              // @this.vars(Runtime)
            
            pushl 16(%ebp)  // param i
            pushl _my_core_Runtime_coi_spk_hex  // kind
            pushl 20(%ebp)  // param stream
            pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl _my_core_Runtime_i_syscall_runtime(%ebx); call _my_core_Runtime_i_syscall_entry(%ebx)
            addl 24, %esp
_4990fdfb_md_printHex_return:
    popad
    leave
    ret

// method destroyInstance
_4990fdfb_md_destroyInstance:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -8(%ebp)
            movl 16(%ebp), %eax // @obj (Type ANY)
            movl 4(%eax), %eax  // @obj
            movl 4(%eax), %eax  // @obj meminfo
            movl %eax, -8(%ebp) // var <instInfo>
    pushl -8(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    jmp _4990fdfb_md_destroyInstance_return
_4990fdfb_md_destroyInstance_return:
    popad
    leave
    ret

// method cast
_4990fdfb_md_cast:
    pushl %ebp; movl %esp, %ebp
    subl 24, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -8(%ebp)
    movl 0, -12(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -16(%ebp)
    subl 4, %esp
    pushl -16(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, -8(%ebp)
cmpl 0, -8(%ebp); jz _crma_return_null   // return NULL if class not exists
            movl -8(%ebp), %ecx // var <classDesc>
            movl 20(%ebp), %eax // @obj (Type ANY)
            movl 4(%eax), %ebx  // @obj
            movl (%ebx), %eax   // @obj-class desc
            addl _my_core_Runtime_coi_ch_cts(%eax), %eax // @obj-class vtabs entry
        _crma_loop:
            cmpl (%eax), %ecx
            je _crma_found
            addl _my_core_Runtime_coi_cts_size, %eax
            cmpl 0, (%eax)
            je _crma_return_null
            jmp _crma_loop
        _crma_found:
            addl _my_core_Runtime_coi_cts_ho(%eax), %ebx
            movl %ebx, -12(%ebp) // var <ret>
    movl -12(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_cast_return
_crma_return_null:
    movl 0, -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_cast_return
_4990fdfb_md_cast_return:
    popad
    leave
    ret

// method createAndRunThread
_4990fdfb_md_createAndRunThread:
    pushl %ebp; movl %esp, %ebp
    subl 28, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -8(%ebp)
    movl 0, -12(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -16(%ebp)
    subl 4, %esp
    pushl -16(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, -8(%ebp)
cmpl 0, -8(%ebp); je _mcrmcart_return     // break if not instantiated
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_3, %eax
    movl %eax, -24(%ebp)
    subl 4, %esp
    pushl -8(%ebp)
    pushl -24(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 16, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -12(%ebp)
cmpl 0, -12(%ebp); je _mcrmcart_cleanup   // destroy instance if not a thread
    movl -12(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 8, %esp
_mcrmcart_cleanup:
    pushl -8(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 104; call (%eax)
    addl 12, %esp
_mcrmcart_return:
    jmp _4990fdfb_md_createAndRunThread_return
_4990fdfb_md_createAndRunThread_return:
    popad
    leave
    ret

// method createInstance
_4990fdfb_md_createInstance:
    pushl %ebp; movl %esp, %ebp
    subl 56, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -8(%ebp)
    movl 0, -12(%ebp)
    movl 0, -16(%ebp)
    movl 0, -20(%ebp)
    movl 0, -24(%ebp)
    movl 0, -28(%ebp)
    movl 0, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -36(%ebp)
    subl 4, %esp
    pushl -36(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -40(%ebp)
    movl -40(%ebp), %eax
    movl %eax, -8(%ebp)
cmpl 0, -8(%ebp); je _crmci_return_null   // return NULL if class not found
            movl -8(%ebp), %eax    // var <classDesc>
            movl _my_core_Runtime_coi_ch_inst_handle(%eax), %ebx
            movl %ebx, -12(%ebp)    // var <instHandle>
            movl _my_core_Runtime_coi_ch_tpl_size(%eax), %ebx
            movl %ebx, -16(%ebp)    // var <tplSize>
cmpl 0, -12(%ebp); jnz _crmci_instantiate  // class already initialized
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_2, %eax
    movl %eax, -44(%ebp)
    subl 4, %esp
    pushl -44(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -48(%ebp)
    movl -48(%ebp), %eax
    movl %eax, -24(%ebp)
cmpl 0, -24(%ebp); je _crmci_return_null  // return NULL if class could not be initialized
    pushl -8(%ebp)
    movl -24(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
_crmci_instantiate:
    subl 4, %esp
    pushl -16(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -52(%ebp)
    movl -52(%ebp), %eax
    movl %eax, -20(%ebp)
cmpl 0, -20(%ebp); je _crmci_return_null  // return NULL on allocate error
            movl -20(%ebp), %eax    // var <instInfo>
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            movl -8(%ebp), %edx    // var <class_desc>
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <name>)
        	movl %edi, -28(%ebp)    // store @Class (Type Object) in var <oinstance>
        	movl %esi, -32(%ebp)    // store @Class (Type <name>) in var <instance>
    pushl -4(%ebp)
    movl -28(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 12, %esp
    movl -32(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_createInstance_return
_crmci_return_null:
    movl 0, -56(%ebp)
    movl -56(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_createInstance_return
_4990fdfb_md_createInstance_return:
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
