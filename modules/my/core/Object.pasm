/*[meta]
mimetype = text/x-pasm
description = class "/my/Object"
[pool]
version = 0.1.0
class = true
[pool_source]
unit = my::core::Object
*/
// class Object
_my_Object:
    .long 0x15AC1A55
    .long 0
    .long _my_Object_cno_my_Object
    .long (_e36c4e5b_cts - _my_Object)
    .long (_e36c4e5b_mts - _my_Object)
    .long (_e36c4e5b_tpl - _my_Object)
    .long (_e36c4e5b_tpl_end - _e36c4e5b_tpl)
    .long (_e36c4e5b_tpl_h_e36c4e5b - _e36c4e5b_tpl)
    .long (_e36c4e5b_tpl_h_e36c4e5b - _e36c4e5b_tpl)

// class tab
_e36c4e5b_cts:
_e36c4e5b_cto_e36c4e5b := (_e36c4e5b_ct_e36c4e5b - _my_Object)
_e36c4e5b_ct_e36c4e5b:
    .long 0
    .long _my_Object_cno_my_Object
    .long (_e36c4e5b_mt_e36c4e5b - _my_Object)
    .long (_e36c4e5b_tpl_h_e36c4e5b - _e36c4e5b_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_e36c4e5b_mts:
_e36c4e5b_mt_e36c4e5b:
.global _my_Object_m_getClass := (_e36c4e5b_mtm_e36c4e5b_getClass - _e36c4e5b_mt_e36c4e5b)
_e36c4e5b_mtm_e36c4e5b_getClass:
    .long _my_Object_mdo_getClass
    .long _e36c4e5b_cto_e36c4e5b
.global _my_Object_m_hash := (_e36c4e5b_mtm_e36c4e5b_hash - _e36c4e5b_mt_e36c4e5b)
_e36c4e5b_mtm_e36c4e5b_hash:
    .long _my_Object_mdo_hash
    .long _e36c4e5b_cto_e36c4e5b
.global _my_Object_m_equals := (_e36c4e5b_mtm_e36c4e5b_equals - _e36c4e5b_mt_e36c4e5b)
_e36c4e5b_mtm_e36c4e5b_equals:
    .long _my_Object_mdo_equals
    .long _e36c4e5b_cto_e36c4e5b
.global _my_Object_m_rt := (_e36c4e5b_mtm_e36c4e5b_rt - _e36c4e5b_mt_e36c4e5b)
_e36c4e5b_mtm_e36c4e5b_rt:
    .long _my_Object_mdo_rt
    .long _e36c4e5b_cto_e36c4e5b
.global _my_Object_m_setRt := (_e36c4e5b_mtm_e36c4e5b_setRt - _e36c4e5b_mt_e36c4e5b)
_e36c4e5b_mtm_e36c4e5b_setRt:
    .long _my_Object_mdo_setRt
    .long _e36c4e5b_cto_e36c4e5b

// constants
// int ch_inst_handle
_my_Object_coi_ch_inst_handle := 4

// class-name Object
_my_Object_cno_my_Object := (_e36c4e5b_cn_e36c4e5b - _my_Object)
_e36c4e5b_cn_e36c4e5b:
    .asciz "/my/Object"

// instance template
_e36c4e5b_tpl:
    .long 0
    .long 0
_e36c4e5b_tpl_h_e36c4e5b:
    .long 0
    .long 0
    .long 0
_my_Object_hvo_my_Object := (_e36c4e5b_tpl_hv_e36c4e5b - _e36c4e5b_tpl_h_e36c4e5b)
_e36c4e5b_tpl_hv_e36c4e5b:
    .long (_e36c4e5b_tpl_vs_e36c4e5b - _e36c4e5b_tpl)
_e36c4e5b_tpl_vs_e36c4e5b:
// variable runtime
.global _my_Object_i_runtime := (_e36c4e5b_tpl_v_e36c4e5b_runtime - _e36c4e5b_tpl_vs_e36c4e5b)
_e36c4e5b_tpl_v_e36c4e5b_runtime:
    .long 0
_e36c4e5b_tpl_end:

// method definitions
// method getClass
.global _my_Object_mdo_getClass := (_e36c4e5b_md_getClass - _my_Object)
_e36c4e5b_md_getClass:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax    // @this (Type Object)
            movl 4(%eax), %eax     // @this
            movl (%eax), %eax      // @class desc
            movl _my_Object_coi_ch_inst_handle(%eax), %eax // @class handle
            movl %eax, 16(%ebp)    // return @class handle
    
    leave
    ret

// method hash
.global _my_Object_mdo_hash := (_e36c4e5b_md_hash - _my_Object)
_e36c4e5b_md_hash:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax    // @this (Type Object)
            movl 4(%eax), %eax     // @this
            movl %eax, 16(%ebp)    // return @this as hash
    
    leave
    ret

// method equals
.global _my_Object_mdo_equals := (_e36c4e5b_md_equals - _my_Object)
_e36c4e5b_md_equals:
    pushl %ebp; movl %esp, %ebp
    
            movl 0, 20(%ebp)       // default return: false
            movl 12(%ebp), %eax    // @this (Type Object)
            movl 4(%eax), %eax     // @this
            movl 16(%ebp), %ebx    // @obj (Type ANY)
            movl 4(%ebx), %ebx     // @obj
            cmpl %eax, %ebx
            jne _come_ret
            movl 1, 20(%ebp)       // return true
            _come_ret:
    
    leave
    ret

// method rt
.global _my_Object_mdo_rt := (_e36c4e5b_md_rt - _my_Object)
_e36c4e5b_md_rt:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                         // @this (Type Object)
            movl _my_Object_hvo_my_Object(%eax), %ebx   // inst vars offset (Object)
            addl 4(%eax), %ebx                          // @this.vars(Object)
            movl _my_Object_i_runtime(%ebx), %eax       // load @runtime (Type Runtime)
            movl %eax, 16(%ebp)                         // return @runtime (Type Runtime)
    
    leave
    ret

// method setRt
.global _my_Object_mdo_setRt := (_e36c4e5b_md_setRt - _my_Object)
_e36c4e5b_md_setRt:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax                         // @this (Type Object)
            movl _my_Object_hvo_my_Object(%eax), %ebx   // inst vars offset (Object)
            addl 4(%eax), %ebx                          // @this.vars(Object)
            movl 16(%ebp), %eax                         // arg @runtime (Type Runtime)
            movl %eax, _my_Object_i_runtime(%ebx)       // store @runtime (Type Runtime)
    
    leave
    ret
