/*[meta]
mimetype = text/x-pasm
description = class "my::core::Class"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::core::Class
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class Class
_my_core_Class:
    .long 0x15AC1A55
    .long 0
    .long _my_core_Class_cno_my_core_Class
    .long (_ff38e2ed_cts - _my_core_Class)
    .long (_ff38e2ed_mts - _my_core_Class)
    .long (_ff38e2ed_mdt - _my_core_Class)
    .long (_ff38e2ed_tpl - _my_core_Class)
    .long (_ff38e2ed_tpl_end - _ff38e2ed_tpl)
    .long (_ff38e2ed_tpl_h_01a2e54e - _ff38e2ed_tpl)
    .long (_ff38e2ed_tpl_h_ff38e2ed - _ff38e2ed_tpl)

// class tab
_ff38e2ed_cts:
_ff38e2ed_cto_01a2e54e := (_ff38e2ed_ct_01a2e54e - _my_core_Class)
_ff38e2ed_ct_01a2e54e:
    .long 0
    .long _my_core_Class_cno_my_core_Object
    .long (_ff38e2ed_mt_01a2e54e - _my_core_Class)
    .long (_ff38e2ed_tpl_h_01a2e54e - _ff38e2ed_tpl)
_ff38e2ed_cto_ff38e2ed := (_ff38e2ed_ct_ff38e2ed - _my_core_Class)
_ff38e2ed_ct_ff38e2ed:
    .long 0
    .long _my_core_Class_cno_my_core_Class
    .long (_ff38e2ed_mt_ff38e2ed - _my_core_Class)
    .long (_ff38e2ed_tpl_h_ff38e2ed - _ff38e2ed_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_ff38e2ed_mts:
_ff38e2ed_mt_01a2e54e:
_my_core_Object_m_getClass := 0
    .long 0
    .long _ff38e2ed_cto_01a2e54e
_my_core_Object_m_hash := 8
    .long 4
    .long _ff38e2ed_cto_01a2e54e
_my_core_Object_m_equals := 16
    .long 8
    .long _ff38e2ed_cto_01a2e54e
_my_core_Object_m_rt := 24
    .long 12
    .long _ff38e2ed_cto_01a2e54e
_my_core_Object_m_setRt := 32
    .long 16
    .long _ff38e2ed_cto_01a2e54e
_ff38e2ed_mt_ff38e2ed:
_my_core_Class_m_getClass := 0
    .long 0
    .long _ff38e2ed_cto_01a2e54e
_my_core_Class_m_hash := 8
    .long 4
    .long _ff38e2ed_cto_01a2e54e
_my_core_Class_m_equals := 16
    .long 8
    .long _ff38e2ed_cto_01a2e54e
_my_core_Class_m_rt := 24
    .long 12
    .long _ff38e2ed_cto_01a2e54e
_my_core_Class_m_setRt := 32
    .long 16
    .long _ff38e2ed_cto_01a2e54e
_my_core_Class_m_getDesc := 40
    .long 0
    .long _ff38e2ed_cto_ff38e2ed
_my_core_Class_m_setDesc := 48
    .long 4
    .long _ff38e2ed_cto_ff38e2ed
_my_core_Class_m_getName := 56
    .long 8
    .long _ff38e2ed_cto_ff38e2ed

// methods tab
_ff38e2ed_mdt:
_my_core_Class_mdo_getDesc := (_ff38e2ed_md_getDesc - _my_core_Class)
    .long _my_core_Class_mdo_getDesc
_my_core_Class_mdo_setDesc := (_ff38e2ed_md_setDesc - _my_core_Class)
    .long _my_core_Class_mdo_setDesc
_my_core_Class_mdo_getName := (_ff38e2ed_md_getName - _my_core_Class)
    .long _my_core_Class_mdo_getName

// constants
// int ch_inst_handle
_my_core_Class_coi_ch_inst_handle := 4

// int ch_name
_my_core_Class_coi_ch_name := 8

// class-name Object
_my_core_Class_cno_my_core_Object := (_ff38e2ed_cn_01a2e54e - _my_core_Class)
_ff38e2ed_cn_01a2e54e:
    .asciz "my::core::Object"

// class-name Class
_my_core_Class_cno_my_core_Class := (_ff38e2ed_cn_ff38e2ed - _my_core_Class)
_ff38e2ed_cn_ff38e2ed:
    .asciz "my::core::Class"

// instance template
_ff38e2ed_tpl:
    .long 0
    .long 0
_ff38e2ed_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_ff38e2ed_tpl_vs_01a2e54e - _ff38e2ed_tpl)
_ff38e2ed_tpl_h_ff38e2ed:
    .long 0
    .long 0
    .long 0
_my_core_Class_hvo_my_core_Object := (_ff38e2ed_tpl_hv_01a2e54e - _ff38e2ed_tpl_h_ff38e2ed)
_ff38e2ed_tpl_hv_01a2e54e:
    .long (_ff38e2ed_tpl_vs_01a2e54e - _ff38e2ed_tpl)
_my_core_Class_hvo_my_core_Class := (_ff38e2ed_tpl_hv_ff38e2ed - _ff38e2ed_tpl_h_ff38e2ed)
_ff38e2ed_tpl_hv_ff38e2ed:
    .long (_ff38e2ed_tpl_vs_ff38e2ed - _ff38e2ed_tpl)
_ff38e2ed_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_ff38e2ed_tpl_v_01a2e54e_runtime - _ff38e2ed_tpl_vs_01a2e54e)
_ff38e2ed_tpl_v_01a2e54e_runtime:
    .long 0
_ff38e2ed_tpl_vs_ff38e2ed:
// variable desc
_my_core_Class_i_desc := (_ff38e2ed_tpl_v_ff38e2ed_desc - _ff38e2ed_tpl_vs_ff38e2ed)
_ff38e2ed_tpl_v_ff38e2ed_desc:
    .long 0
_ff38e2ed_tpl_end:

// method definitions
// method getDesc
_ff38e2ed_md_getDesc:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                     // @this (Type Class)
            movl _my_core_Class_hvo_my_core_Class(%eax), %ebx // inst vars offset (Class)
            addl 4(%eax), %ebx                      // @this.vars(Class)
            movl _my_core_Class_i_desc(%ebx), %eax       // @class desc
            movl %eax, 16(%ebp)                     // return @class desc
    
    leave
    ret

// method setDesc
_ff38e2ed_md_setDesc:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                     // @this (Type Class)
            movl _my_core_Class_hvo_my_core_Class(%eax), %ebx // inst vars offset (Class)
            addl 4(%eax), %ebx                      // @this.vars(Class)
            movl 16(%ebp), %eax                     // param @class desc
            movl %eax, _my_core_Class_i_desc(%ebx)       // store @class desc
            movl 12(%ebp), %ebx                     // @this (Type Class)
            movl %ebx, _my_core_Class_coi_ch_inst_handle(%eax)   // store @this (Type Class) in class desc
    
    leave
    ret

// method getName
_ff38e2ed_md_getName:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                     // @this (Type Class)
            movl _my_core_Class_hvo_my_core_Class(%eax), %ebx // inst vars offset (Class)
            addl 4(%eax), %ebx                      // @this.vars(Class)
            movl _my_core_Class_i_desc(%ebx), %eax       // @class desc
            addl _my_core_Class_coi_ch_name(%eax), %eax  // load reference to cstring
            movl %eax, 16(%ebp)                     // return cstring-ref
    
    leave
    ret
