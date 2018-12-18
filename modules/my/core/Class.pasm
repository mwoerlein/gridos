/*[meta]
mimetype = text/x-pasm
description = class "/my/Class"
[pool]
version = 0.1.0
class = true
[pool_source]
unit = my::core::Class
*/
// class Class
_my_Class:
    .long 0x15AC1A55
    .long 0
    .long _my_Class_cno_my_Class
    .long (_cfc2de5a_cts - _my_Class)
    .long (_cfc2de5a_mts - _my_Class)
    .long (_cfc2de5a_tpl - _my_Class)
    .long (_cfc2de5a_tpl_end - _cfc2de5a_tpl)
    .long (_cfc2de5a_tpl_h_e36c4e5b - _cfc2de5a_tpl)
    .long (_cfc2de5a_tpl_h_cfc2de5a - _cfc2de5a_tpl)

// class tab
_cfc2de5a_cts:
_cfc2de5a_cto_e36c4e5b := (_cfc2de5a_ct_e36c4e5b - _my_Class)
_cfc2de5a_ct_e36c4e5b:
    .long 0
    .long _my_Class_cno_my_Object
    .long (_cfc2de5a_mt_e36c4e5b - _my_Class)
    .long (_cfc2de5a_tpl_h_e36c4e5b - _cfc2de5a_tpl)
_cfc2de5a_cto_cfc2de5a := (_cfc2de5a_ct_cfc2de5a - _my_Class)
_cfc2de5a_ct_cfc2de5a:
    .long 0
    .long _my_Class_cno_my_Class
    .long (_cfc2de5a_mt_cfc2de5a - _my_Class)
    .long (_cfc2de5a_tpl_h_cfc2de5a - _cfc2de5a_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_cfc2de5a_mts:
_cfc2de5a_mt_e36c4e5b:
    .long _my_Object_mdo_getClass
    .long _cfc2de5a_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _cfc2de5a_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _cfc2de5a_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _cfc2de5a_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _cfc2de5a_cto_e36c4e5b
_cfc2de5a_mt_cfc2de5a:
.global _my_Class_m_getClass := (_cfc2de5a_mtm_cfc2de5a_getClass - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_getClass:
    .long _my_Object_mdo_getClass
    .long _cfc2de5a_cto_e36c4e5b
.global _my_Class_m_hash := (_cfc2de5a_mtm_cfc2de5a_hash - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_hash:
    .long _my_Object_mdo_hash
    .long _cfc2de5a_cto_e36c4e5b
.global _my_Class_m_equals := (_cfc2de5a_mtm_cfc2de5a_equals - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_equals:
    .long _my_Object_mdo_equals
    .long _cfc2de5a_cto_e36c4e5b
.global _my_Class_m_rt := (_cfc2de5a_mtm_cfc2de5a_rt - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_rt:
    .long _my_Object_mdo_rt
    .long _cfc2de5a_cto_e36c4e5b
.global _my_Class_m_setRt := (_cfc2de5a_mtm_cfc2de5a_setRt - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_setRt:
    .long _my_Object_mdo_setRt
    .long _cfc2de5a_cto_e36c4e5b
.global _my_Class_m_getDesc := (_cfc2de5a_mtm_cfc2de5a_getDesc - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_getDesc:
    .long _my_Class_mdo_getDesc
    .long _cfc2de5a_cto_cfc2de5a
.global _my_Class_m_setDesc := (_cfc2de5a_mtm_cfc2de5a_setDesc - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_setDesc:
    .long _my_Class_mdo_setDesc
    .long _cfc2de5a_cto_cfc2de5a
.global _my_Class_m_getName := (_cfc2de5a_mtm_cfc2de5a_getName - _cfc2de5a_mt_cfc2de5a)
_cfc2de5a_mtm_cfc2de5a_getName:
    .long _my_Class_mdo_getName
    .long _cfc2de5a_cto_cfc2de5a

// constants
// int ch_inst_handle
_my_Class_coi_ch_inst_handle := 4

// int ch_name
_my_Class_coi_ch_name := 8

// class-name Object
_my_Class_cno_my_Object := (_cfc2de5a_cn_e36c4e5b - _my_Class)
_cfc2de5a_cn_e36c4e5b:
    .asciz "/my/Object"

// class-name Class
_my_Class_cno_my_Class := (_cfc2de5a_cn_cfc2de5a - _my_Class)
_cfc2de5a_cn_cfc2de5a:
    .asciz "/my/Class"

// instance template
_cfc2de5a_tpl:
    .long 0
    .long 0
_cfc2de5a_tpl_h_e36c4e5b:
    .long 0
    .long 0
    .long 0
    .long (_cfc2de5a_tpl_vs_e36c4e5b - _cfc2de5a_tpl)
_cfc2de5a_tpl_h_cfc2de5a:
    .long 0
    .long 0
    .long 0
_my_Class_hvo_my_Object := (_cfc2de5a_tpl_hv_e36c4e5b - _cfc2de5a_tpl_h_cfc2de5a)
_cfc2de5a_tpl_hv_e36c4e5b:
    .long (_cfc2de5a_tpl_vs_e36c4e5b - _cfc2de5a_tpl)
_my_Class_hvo_my_Class := (_cfc2de5a_tpl_hv_cfc2de5a - _cfc2de5a_tpl_h_cfc2de5a)
_cfc2de5a_tpl_hv_cfc2de5a:
    .long (_cfc2de5a_tpl_vs_cfc2de5a - _cfc2de5a_tpl)
_cfc2de5a_tpl_vs_e36c4e5b:
// variable runtime
    .long 0
_cfc2de5a_tpl_vs_cfc2de5a:
// variable desc
.global _my_Class_i_desc := (_cfc2de5a_tpl_v_cfc2de5a_desc - _cfc2de5a_tpl_vs_cfc2de5a)
_cfc2de5a_tpl_v_cfc2de5a_desc:
    .long 0
_cfc2de5a_tpl_end:

// method definitions
// method getDesc
.global _my_Class_mdo_getDesc := (_cfc2de5a_md_getDesc - _my_Class)
_cfc2de5a_md_getDesc:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                     // @this (Type Class)
            movl _my_Class_hvo_my_Class(%eax), %ebx // inst vars offset (Class)
            addl 4(%eax), %ebx                      // @this.vars(Class)
            movl _my_Class_i_desc(%ebx), %eax       // @class desc
            movl %eax, 16(%ebp)                     // return @class desc
    
    leave
    ret

// method setDesc
.global _my_Class_mdo_setDesc := (_cfc2de5a_md_setDesc - _my_Class)
_cfc2de5a_md_setDesc:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                     // @this (Type Class)
            movl _my_Class_hvo_my_Class(%eax), %ebx // inst vars offset (Class)
            addl 4(%eax), %ebx                      // @this.vars(Class)
            movl 16(%ebp), %eax                     // param @class desc
            movl %eax, _my_Class_i_desc(%ebx)       // store @class desc
            movl 12(%ebp), %ebx                     // @this (Type Class)
            movl %ebx, _my_Class_coi_ch_inst_handle(%eax)   // store @this (Type Class) in class desc
    
    leave
    ret

// method getName
.global _my_Class_mdo_getName := (_cfc2de5a_md_getName - _my_Class)
_cfc2de5a_md_getName:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                     // @this (Type Class)
            movl _my_Class_hvo_my_Class(%eax), %ebx // inst vars offset (Class)
            addl 4(%eax), %ebx                      // @this.vars(Class)
            movl _my_Class_i_desc(%ebx), %eax       // @class desc
            addl _my_Class_coi_ch_name(%eax), %eax  // load reference to cstring
            movl %eax, 16(%ebp)                     // return cstring-ref
    
    leave
    ret
