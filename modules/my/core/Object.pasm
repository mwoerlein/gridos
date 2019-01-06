/*[meta]
mimetype = text/x-pasm
description = class "my::core::Object"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::core::Object
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class Object
_my_core_Object:
    .long 0x15AC1A55
    .long 0
    .long _my_core_Object_coso_CLASSNAME
    .long (_01a2e54e_cts - _my_core_Object)
    .long (_01a2e54e_mts - _my_core_Object)
    .long (_01a2e54e_mdt - _my_core_Object)
    .long (_01a2e54e_tpl - _my_core_Object)
    .long (_01a2e54e_tpl_end - _01a2e54e_tpl)
    .long (_01a2e54e_tpl_h_01a2e54e - _01a2e54e_tpl)
    .long (_01a2e54e_tpl_h_01a2e54e - _01a2e54e_tpl)

// class tab
_01a2e54e_cts:
_01a2e54e_cto_01a2e54e := (_01a2e54e_ct_01a2e54e - _my_core_Object)
_01a2e54e_ct_01a2e54e:
    .long 0
    .long _my_core_Object_coso_CLASSNAME
    .long (_01a2e54e_mt_01a2e54e - _my_core_Object)
    .long (_01a2e54e_tpl_h_01a2e54e - _01a2e54e_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_01a2e54e_mts:
_01a2e54e_mt_01a2e54e:
    .long 0
    .long _01a2e54e_cto_01a2e54e
    .long 4
    .long _01a2e54e_cto_01a2e54e
    .long 8
    .long _01a2e54e_cto_01a2e54e
    .long 12
    .long _01a2e54e_cto_01a2e54e
    .long 16
    .long _01a2e54e_cto_01a2e54e

// methods tab
_01a2e54e_mdt:
    .long (_01a2e54e_md_getClass - _my_core_Object)
    .long (_01a2e54e_md_hash - _my_core_Object)
    .long (_01a2e54e_md_equals - _my_core_Object)
    .long (_01a2e54e_md_rt - _my_core_Object)
    .long (_01a2e54e_md_setRt - _my_core_Object)

// constants
// int ch_inst_handle
_my_core_Object_coi_ch_inst_handle := 4

// string CLASSNAME
_my_core_Object_coso_CLASSNAME := (_01a2e54e_cos_CLASSNAME - _my_core_Object)
_01a2e54e_cos_CLASSNAME:
    .asciz "my::core::Object"

// instance template
_01a2e54e_tpl:
    .long 0
    .long 0
_01a2e54e_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
_my_core_Object_hvo_my_core_Object := (_01a2e54e_tpl_hv_01a2e54e - _01a2e54e_tpl_h_01a2e54e)
_01a2e54e_tpl_hv_01a2e54e:
    .long (_01a2e54e_tpl_vs_01a2e54e - _01a2e54e_tpl)
_01a2e54e_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_01a2e54e_tpl_v_01a2e54e_runtime - _01a2e54e_tpl_vs_01a2e54e)
_01a2e54e_tpl_v_01a2e54e_runtime:
    .long 0
_01a2e54e_tpl_end:

// method definitions
// method getClass
_01a2e54e_md_getClass:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 0, -4(%ebp)
    movl 12(%ebp), %eax
             movl 4(%eax), %eax     // @this
             movl (%eax), %eax      // @class desc
             movl _my_core_Object_coi_ch_inst_handle(%eax), %eax // @class handle
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _01a2e54e_md_getClass_return
_01a2e54e_md_getClass_return:
    popad
    leave
    ret

// method hash
_01a2e54e_md_hash:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 0, -4(%ebp)
    movl 12(%ebp), %eax
             movl 4(%eax), %eax     // @this
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _01a2e54e_md_hash_return
_01a2e54e_md_hash_return:
    popad
    leave
    ret

// method equals
_01a2e54e_md_equals:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 0, -4(%ebp)
    movl 12(%ebp), %eax
    movl 16(%ebp), %ebx
    movl -4(%ebp), %ecx
            movl 4(%eax), %eax  // @this
            cmpl %eax, 4(%ebx)  // @obj
            jne _come_ret
            movl 1, %ecx        // return true
            _come_ret:
    movl %ecx, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _01a2e54e_md_equals_return
_01a2e54e_md_equals_return:
    popad
    leave
    ret

// method rt
_01a2e54e_md_rt:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl _my_core_Object_hvo_my_core_Object(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_core_Object_i_runtime(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _01a2e54e_md_rt_return
_01a2e54e_md_rt_return:
    popad
    leave
    ret

// method setRt
_01a2e54e_md_setRt:
    pushl %ebp; movl %esp, %ebp
    pushad
    movl 12(%ebp), %eax
    movl _my_core_Object_hvo_my_core_Object(%eax), %ebx
    addl 4(%eax), %ebx
    movl 16(%ebp), %eax
    movl %eax, _my_core_Object_i_runtime(%ebx)
    jmp _01a2e54e_md_setRt_return
_01a2e54e_md_setRt_return:
    popad
    leave
    ret
