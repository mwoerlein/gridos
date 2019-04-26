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
    .long 20
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
    .long 20
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
    .long (_4990fdfb_md_initStreams - _my_core_Runtime)
    .long (_4990fdfb_md_out - _my_core_Runtime)
    .long (_4990fdfb_md_err - _my_core_Runtime)
    .long (_4990fdfb_md_getClassDesc - _my_core_Runtime)
    .long (_4990fdfb_md_allocate - _my_core_Runtime)
    .long (_4990fdfb_md_free - _my_core_Runtime)
    .long (_4990fdfb_md_printChar - _my_core_Runtime)
    .long (_4990fdfb_md_destroyInstance - _my_core_Runtime)
    .long (_4990fdfb_md_cast - _my_core_Runtime)
    .long (_4990fdfb_md_createAndRunThread - _my_core_Runtime)
    .long (_4990fdfb_md_createInstance - _my_core_Runtime)
    .long 0
    .long 0

// constants
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

// string CLASSNAME
_my_core_Runtime_coso_CLASSNAME := (_4990fdfb_cos_CLASSNAME - _my_core_Runtime)
_4990fdfb_cos_CLASSNAME:
    .asciz "my::core::Runtime"

// string string_1
_my_core_Runtime_coso_string_1 := (_4990fdfb_cos_string_1 - _my_core_Runtime)
_4990fdfb_cos_string_1:
    .asciz "my::core::Class"

// string string_2
_my_core_Runtime_coso_string_2 := (_4990fdfb_cos_string_2 - _my_core_Runtime)
_4990fdfb_cos_string_2:
    .asciz "my::core::RuntimeOStream"

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
// variable out
_my_core_Runtime_i_out := (_4990fdfb_tpl_v_4990fdfb_out - _4990fdfb_tpl_vs_4990fdfb)
_4990fdfb_tpl_v_4990fdfb_out:
    .long 0
// variable err
_my_core_Runtime_i_err := (_4990fdfb_tpl_v_4990fdfb_err - _4990fdfb_tpl_vs_4990fdfb)
_4990fdfb_tpl_v_4990fdfb_err:
    .long 0
_4990fdfb_tpl_end:

// method definitions
// method bootstrap
_4990fdfb_md_bootstrap:
    pushl %ebp; movl %esp, %ebp
    subl 96, %esp
    pushad
    movl 0, -16(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_2
_4990fdfb_md_bootstrap_bb_1:
    popad
    leave
    ret
_4990fdfb_md_bootstrap_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_1, %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    movl 16(%ebp), %edi
    movl 20(%ebp), %esi
            pushl 0; pushl %eax; pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl %edi; call %esi
            addl 16, %esp; popl %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_bootstrap_bb_5
    jmp _4990fdfb_md_bootstrap_bb_4
_4990fdfb_md_bootstrap_bb_3:
    movl 0, -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -24(%ebp)
    movl -4(%ebp), %eax
    movl 16(%ebp), %edi
    movl 20(%ebp), %esi
            pushl 0
            pushl _my_core_Runtime_coi_ch_tpl_size(%eax) // instance size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl %edi; call %esi
            addl 16, %esp; popl %eax
    movl %eax, -24(%ebp)
    movl -24(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_bootstrap_bb_9
    jmp _4990fdfb_md_bootstrap_bb_8
_4990fdfb_md_bootstrap_bb_4:
    movl 0, -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_1
_4990fdfb_md_bootstrap_bb_5:
    jmp _4990fdfb_md_bootstrap_bb_3
_4990fdfb_md_bootstrap_bb_6:
    jmp _4990fdfb_md_bootstrap_bb_3
_4990fdfb_md_bootstrap_bb_7:
    movl 0, -40(%ebp)
    movl -40(%ebp), %eax
    movl %eax, -36(%ebp)
    movl -24(%ebp), %eax
    movl -4(%ebp), %edx
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl %esi, -36(%ebp)
    movl 0, -48(%ebp)
    movl -48(%ebp), %eax
    movl %eax, -44(%ebp)
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_CLASSNAME, %eax
    movl %eax, -52(%ebp)
    movl -52(%ebp), %eax
    movl 16(%ebp), %edi
    movl 20(%ebp), %esi
            pushl 0; pushl %eax; pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl %edi; call %esi
            addl 16, %esp; popl %eax
    movl %eax, -44(%ebp)
    movl -44(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_bootstrap_bb_13
    jmp _4990fdfb_md_bootstrap_bb_12
_4990fdfb_md_bootstrap_bb_8:
    movl 0, -32(%ebp)
    movl -32(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_1
_4990fdfb_md_bootstrap_bb_9:
    jmp _4990fdfb_md_bootstrap_bb_7
_4990fdfb_md_bootstrap_bb_10:
    jmp _4990fdfb_md_bootstrap_bb_7
_4990fdfb_md_bootstrap_bb_11:
    movl 0, -64(%ebp)
    movl -64(%ebp), %eax
    movl %eax, -60(%ebp)
    movl -44(%ebp), %eax
    movl 16(%ebp), %edi
    movl 20(%ebp), %esi
            pushl 0
            pushl _my_core_Runtime_coi_ch_tpl_size(%eax) // instance size
            pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl %edi; call %esi
            addl 16, %esp; popl %eax
    movl %eax, -60(%ebp)
    movl -60(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_bootstrap_bb_17
    jmp _4990fdfb_md_bootstrap_bb_16
_4990fdfb_md_bootstrap_bb_12:
    movl 0, -56(%ebp)
    movl -56(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_1
_4990fdfb_md_bootstrap_bb_13:
    jmp _4990fdfb_md_bootstrap_bb_11
_4990fdfb_md_bootstrap_bb_14:
    jmp _4990fdfb_md_bootstrap_bb_11
_4990fdfb_md_bootstrap_bb_15:
    movl 0, -76(%ebp)
    movl -76(%ebp), %eax
    movl %eax, -72(%ebp)
    movl -60(%ebp), %eax
    movl -44(%ebp), %edx
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl %esi, -72(%ebp)
    pushl -72(%ebp)
    movl -36(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    pushl -4(%ebp)
    movl -36(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    pushl -72(%ebp)
    movl -72(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    pushl 20(%ebp)
    pushl 16(%ebp)
    movl -72(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_1, %eax
    movl %eax, -84(%ebp)
    subl 4, %esp
    pushl -84(%ebp)
    movl -72(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 12, %esp
    popl -88(%ebp)
    movl -88(%ebp), %eax
    movl %eax, -80(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -92(%ebp)
    movl -92(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_bootstrap_bb_21
    jmp _4990fdfb_md_bootstrap_bb_20
_4990fdfb_md_bootstrap_bb_16:
    movl 0, -68(%ebp)
    movl -68(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_1
_4990fdfb_md_bootstrap_bb_17:
    jmp _4990fdfb_md_bootstrap_bb_15
_4990fdfb_md_bootstrap_bb_18:
    jmp _4990fdfb_md_bootstrap_bb_15
_4990fdfb_md_bootstrap_bb_19:
    pushl -44(%ebp)
    movl -80(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    movl -72(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    movl -72(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_1
_4990fdfb_md_bootstrap_bb_20:
    movl 0, -96(%ebp)
    movl -96(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_bootstrap_bb_1
_4990fdfb_md_bootstrap_bb_21:
    jmp _4990fdfb_md_bootstrap_bb_19
_4990fdfb_md_bootstrap_bb_22:
    jmp _4990fdfb_md_bootstrap_bb_19
_4990fdfb_md_bootstrap_bb_23:
    jmp _4990fdfb_md_bootstrap_bb_1

// method initSysCall
_4990fdfb_md_initSysCall:
    pushl %ebp; movl %esp, %ebp
    pushad
    jmp _4990fdfb_md_initSysCall_bb_2
_4990fdfb_md_initSysCall_bb_1:
    popad
    leave
    ret
_4990fdfb_md_initSysCall_bb_2:
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl 16(%ebp), %eax
    movl %eax, _my_core_Runtime_i_syscall_runtime(%ebx)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl 20(%ebp), %eax
    movl %eax, _my_core_Runtime_i_syscall_entry(%ebx)
    jmp _4990fdfb_md_initSysCall_bb_1

// method initStreams
_4990fdfb_md_initStreams:
    pushl %ebp; movl %esp, %ebp
    subl 40, %esp
    pushad
    jmp _4990fdfb_md_initStreams_bb_2
_4990fdfb_md_initStreams_bb_1:
    popad
    leave
    ret
_4990fdfb_md_initStreams_bb_2:
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_2, %eax
    movl %eax, -8(%ebp)
    subl 4, %esp
    pushl -8(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 12, %esp
    popl -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -16(%ebp)
    subl 4, %esp
    pushl -16(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 152; call (%eax)
    addl 12, %esp
    popl -20(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl -20(%ebp), %eax
    movl %eax, _my_core_Runtime_i_out(%ebx)
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_2, %eax
    movl %eax, -28(%ebp)
    subl 4, %esp
    pushl -28(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 12, %esp
    popl -32(%ebp)
    movl -32(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 1, -36(%ebp)
    subl 4, %esp
    pushl -36(%ebp)
    movl -24(%ebp), %eax
    pushl %eax; pushl 152; call (%eax)
    addl 12, %esp
    popl -40(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl -40(%ebp), %eax
    movl %eax, _my_core_Runtime_i_err(%ebx)
    jmp _4990fdfb_md_initStreams_bb_1

// method out
_4990fdfb_md_out:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    jmp _4990fdfb_md_out_bb_2
_4990fdfb_md_out_bb_1:
    popad
    leave
    ret
_4990fdfb_md_out_bb_2:
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_out(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _4990fdfb_md_out_bb_1
_4990fdfb_md_out_bb_3:
    jmp _4990fdfb_md_out_bb_1

// method err
_4990fdfb_md_err:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    jmp _4990fdfb_md_err_bb_2
_4990fdfb_md_err_bb_1:
    popad
    leave
    ret
_4990fdfb_md_err_bb_2:
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_err(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _4990fdfb_md_err_bb_1
_4990fdfb_md_err_bb_3:
    jmp _4990fdfb_md_err_bb_1

// method getClassDesc
_4990fdfb_md_getClassDesc:
    pushl %ebp; movl %esp, %ebp
    subl 16, %esp
    pushad
    jmp _4990fdfb_md_getClassDesc_bb_2
_4990fdfb_md_getClassDesc_bb_1:
    popad
    leave
    ret
_4990fdfb_md_getClassDesc_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_runtime(%ebx), %eax
    movl %eax, -12(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_entry(%ebx), %eax
    movl %eax, -16(%ebp)
    movl 16(%ebp), %eax
    movl -12(%ebp), %edi
    movl -16(%ebp), %esi
            pushl 0; pushl %eax; pushl _my_core_Runtime_coi_SysCall_find_class
            pushl %esp; pushl %edi; call %esi
            addl 16, %esp; popl %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_getClassDesc_bb_1
_4990fdfb_md_getClassDesc_bb_3:
    jmp _4990fdfb_md_getClassDesc_bb_1

// method allocate
_4990fdfb_md_allocate:
    pushl %ebp; movl %esp, %ebp
    subl 16, %esp
    pushad
    jmp _4990fdfb_md_allocate_bb_2
_4990fdfb_md_allocate_bb_1:
    popad
    leave
    ret
_4990fdfb_md_allocate_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_runtime(%ebx), %eax
    movl %eax, -12(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_entry(%ebx), %eax
    movl %eax, -16(%ebp)
    movl 16(%ebp), %eax
    movl -12(%ebp), %edi
    movl -16(%ebp), %esi
            pushl 0; pushl %eax; pushl _my_core_Runtime_coi_SysCall_allocate
            pushl %esp; pushl %edi; call %esi
            addl 16, %esp; popl %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_allocate_bb_1
_4990fdfb_md_allocate_bb_3:
    jmp _4990fdfb_md_allocate_bb_1

// method free
_4990fdfb_md_free:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _4990fdfb_md_free_bb_2
_4990fdfb_md_free_bb_1:
    popad
    leave
    ret
_4990fdfb_md_free_bb_2:
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_runtime(%ebx), %eax
    movl %eax, -4(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_entry(%ebx), %eax
    movl %eax, -8(%ebp)
    movl 16(%ebp), %eax
    movl -4(%ebp), %edi
    movl -8(%ebp), %esi
            pushl %eax; pushl 0; pushl _my_core_Runtime_coi_SysCall_free
            pushl %esp; pushl %edi; call %esi
            addl 20, %esp
    jmp _4990fdfb_md_free_bb_1

// method printChar
_4990fdfb_md_printChar:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _4990fdfb_md_printChar_bb_2
_4990fdfb_md_printChar_bb_1:
    popad
    leave
    ret
_4990fdfb_md_printChar_bb_2:
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_runtime(%ebx), %eax
    movl %eax, -4(%ebp)
    movl 12(%ebp), %eax
    movl _my_core_Runtime_hvo_my_core_Runtime(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Runtime_i_syscall_entry(%ebx), %eax
    movl %eax, -8(%ebp)
    movl 16(%ebp), %eax
    movl 20(%ebp), %ebx
    movl -4(%ebp), %edi
    movl -8(%ebp), %esi
            pushl %eax; pushl _my_core_Runtime_coi_spk_char; pushl %ebx; pushl _my_core_Runtime_coi_SysCall_print
            pushl %esp; pushl %edi; call %esi
            addl 24, %esp
    jmp _4990fdfb_md_printChar_bb_1

// method destroyInstance
_4990fdfb_md_destroyInstance:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _4990fdfb_md_destroyInstance_bb_2
_4990fdfb_md_destroyInstance_bb_1:
    popad
    leave
    ret
_4990fdfb_md_destroyInstance_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 16(%ebp), %eax
            movl 4(%eax), %eax  // @obj
            movl 4(%eax), %eax  // @obj meminfo
    movl %eax, -4(%ebp)
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 12, %esp
    jmp _4990fdfb_md_destroyInstance_bb_1
_4990fdfb_md_destroyInstance_bb_3:
    jmp _4990fdfb_md_destroyInstance_bb_1

// method cast
_4990fdfb_md_cast:
    pushl %ebp; movl %esp, %ebp
    subl 20, %esp
    pushad
    movl 0, -20(%ebp)
    jmp _4990fdfb_md_cast_bb_2
_4990fdfb_md_cast_bb_1:
    popad
    leave
    ret
_4990fdfb_md_cast_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    cmpl -20(%ebp), %eax
    jne _4990fdfb_md_cast_bb_4
    jmp _4990fdfb_md_cast_bb_5
_4990fdfb_md_cast_bb_3:
_crma_return:
    movl -4(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _4990fdfb_md_cast_bb_1
_4990fdfb_md_cast_bb_4:
    movl 20(%ebp), %eax
    movl -12(%ebp), %ecx
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
    movl %ebx, -4(%ebp)
    jmp _4990fdfb_md_cast_bb_3
_4990fdfb_md_cast_bb_5:
    jmp _4990fdfb_md_cast_bb_3
_4990fdfb_md_cast_bb_6:
    jmp _4990fdfb_md_cast_bb_1

// method createAndRunThread
_4990fdfb_md_createAndRunThread:
    pushl %ebp; movl %esp, %ebp
    subl 32, %esp
    pushad
    movl 0, -16(%ebp)
    jmp _4990fdfb_md_createAndRunThread_bb_2
_4990fdfb_md_createAndRunThread_bb_1:
    popad
    leave
    ret
_4990fdfb_md_createAndRunThread_bb_2:
    subl 4, %esp
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 12, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_createAndRunThread_bb_5
    jmp _4990fdfb_md_createAndRunThread_bb_4
_4990fdfb_md_createAndRunThread_bb_3:
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_3, %eax
    movl %eax, -24(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    pushl -24(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 120; call (%eax)
    addl 16, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, -32(%ebp)
    movl -32(%ebp), %eax
    cmpl -16(%ebp), %eax
    jne _4990fdfb_md_createAndRunThread_bb_8
    jmp _4990fdfb_md_createAndRunThread_bb_9
_4990fdfb_md_createAndRunThread_bb_4:
    jmp _4990fdfb_md_createAndRunThread_bb_1
_4990fdfb_md_createAndRunThread_bb_5:
    jmp _4990fdfb_md_createAndRunThread_bb_3
_4990fdfb_md_createAndRunThread_bb_6:
    jmp _4990fdfb_md_createAndRunThread_bb_3
_4990fdfb_md_createAndRunThread_bb_7:
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 12, %esp
    jmp _4990fdfb_md_createAndRunThread_bb_1
_4990fdfb_md_createAndRunThread_bb_8:
    movl -20(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 8, %esp
    jmp _4990fdfb_md_createAndRunThread_bb_7
_4990fdfb_md_createAndRunThread_bb_9:
    jmp _4990fdfb_md_createAndRunThread_bb_7

// method createInstance
_4990fdfb_md_createInstance:
    pushl %ebp; movl %esp, %ebp
    subl 80, %esp
    pushad
    movl 0, -12(%ebp)
    jmp _4990fdfb_md_createInstance_bb_2
_4990fdfb_md_createInstance_bb_1:
    popad
    leave
    ret
_4990fdfb_md_createInstance_bb_2:
    subl 4, %esp
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    cmpl -12(%ebp), %eax
    jne _4990fdfb_md_createInstance_bb_5
    jmp _4990fdfb_md_createInstance_bb_4
_4990fdfb_md_createInstance_bb_3:
    movl 0, -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 0, -32(%ebp)
    movl -32(%ebp), %eax
    movl %eax, -28(%ebp)
    movl -4(%ebp), %eax
            movl _my_core_Runtime_coi_ch_inst_handle(%eax), %ebx
            movl _my_core_Runtime_coi_ch_tpl_size(%eax), %eax
    movl %eax, -28(%ebp)
    movl %ebx, -20(%ebp)
    movl -20(%ebp), %eax
    cmpl -12(%ebp), %eax
    jne _4990fdfb_md_createInstance_bb_9
    jmp _4990fdfb_md_createInstance_bb_8
_4990fdfb_md_createInstance_bb_4:
    movl 0, -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_createInstance_bb_1
_4990fdfb_md_createInstance_bb_5:
    jmp _4990fdfb_md_createInstance_bb_3
_4990fdfb_md_createInstance_bb_6:
    jmp _4990fdfb_md_createInstance_bb_3
_4990fdfb_md_createInstance_bb_7:
    subl 4, %esp
    pushl -28(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 12, %esp
    popl -60(%ebp)
    movl -60(%ebp), %eax
    movl %eax, -56(%ebp)
    movl -56(%ebp), %eax
    cmpl -12(%ebp), %eax
    jne _4990fdfb_md_createInstance_bb_16
    jmp _4990fdfb_md_createInstance_bb_15
_4990fdfb_md_createInstance_bb_8:
    movl 8(%ebp), %eax
    addl _my_core_Runtime_coso_string_1, %eax
    movl %eax, -40(%ebp)
    subl 4, %esp
    pushl -40(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 12, %esp
    popl -44(%ebp)
    movl -44(%ebp), %eax
    movl %eax, -36(%ebp)
    movl -36(%ebp), %eax
    movl %eax, -48(%ebp)
    movl -48(%ebp), %eax
    cmpl -12(%ebp), %eax
    jne _4990fdfb_md_createInstance_bb_12
    jmp _4990fdfb_md_createInstance_bb_11
_4990fdfb_md_createInstance_bb_9:
    jmp _4990fdfb_md_createInstance_bb_7
_4990fdfb_md_createInstance_bb_10:
    pushl -4(%ebp)
    movl -36(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    jmp _4990fdfb_md_createInstance_bb_7
_4990fdfb_md_createInstance_bb_11:
    movl 0, -52(%ebp)
    movl -52(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_createInstance_bb_1
_4990fdfb_md_createInstance_bb_12:
    jmp _4990fdfb_md_createInstance_bb_10
_4990fdfb_md_createInstance_bb_13:
    jmp _4990fdfb_md_createInstance_bb_10
_4990fdfb_md_createInstance_bb_14:
    movl 0, -72(%ebp)
    movl -72(%ebp), %eax
    movl %eax, -68(%ebp)
    movl 0, -80(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -76(%ebp)
    movl -56(%ebp), %eax
    movl -4(%ebp), %edx
            movl 8(%ebp), %ebx      // @class-desc "Runtime"
            addl _cr_mo_call_entry, %ebx
            call _crh_instantiate   // %eax: @object-meminfo %ebx: @_call_entry %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl %edi, -68(%ebp)
    movl %esi, -76(%ebp)
    pushl 12(%ebp)
    movl -68(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    movl -76(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_createInstance_bb_1
_4990fdfb_md_createInstance_bb_15:
    movl 0, -64(%ebp)
    movl -64(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _4990fdfb_md_createInstance_bb_1
_4990fdfb_md_createInstance_bb_16:
    jmp _4990fdfb_md_createInstance_bb_14
_4990fdfb_md_createInstance_bb_17:
    jmp _4990fdfb_md_createInstance_bb_14
_4990fdfb_md_createInstance_bb_18:
    jmp _4990fdfb_md_createInstance_bb_1

// method _crh_instantiate
_4990fdfb_md__crh_instantiate_bb_2:
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
_4990fdfb_md__call_entry_bb_2:
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
