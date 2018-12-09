/*[meta]
mimetype = text/x-pasm
description = class "/my/Thread"
[pool]
version = 0.1.0
class = true
*/
// class Thread
_my_Thread:
    .long 0x15AC1A55
    .long 0
    .long _my_Thread_cno_my_Thread
    .long (_ef870f3c_cts - _my_Thread)
    .long (_ef870f3c_mts - _my_Thread)
    .long (_ef870f3c_tpl - _my_Thread)
    .long (_ef870f3c_tpl_end - _ef870f3c_tpl)
    .long (_ef870f3c_tpl_h_e36c4e5b - _ef870f3c_tpl)
    .long (_ef870f3c_tpl_h_ef870f3c - _ef870f3c_tpl)

// class tab
_ef870f3c_cts:
_ef870f3c_cto_e36c4e5b := (_ef870f3c_ct_e36c4e5b - _my_Thread)
_ef870f3c_ct_e36c4e5b:
    .long 0
    .long _my_Thread_cno_my_Object
    .long (_ef870f3c_mt_e36c4e5b - _my_Thread)
    .long (_ef870f3c_tpl_h_e36c4e5b - _ef870f3c_tpl)
_ef870f3c_cto_ef870f3c := (_ef870f3c_ct_ef870f3c - _my_Thread)
_ef870f3c_ct_ef870f3c:
    .long 0
    .long _my_Thread_cno_my_Thread
    .long (_ef870f3c_mt_ef870f3c - _my_Thread)
    .long (_ef870f3c_tpl_h_ef870f3c - _ef870f3c_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_ef870f3c_mts:
_ef870f3c_mt_e36c4e5b:
    .long _my_Object_mdo_getClass
    .long _ef870f3c_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _ef870f3c_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _ef870f3c_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _ef870f3c_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _ef870f3c_cto_e36c4e5b
_ef870f3c_mt_ef870f3c:
.global _my_Thread_m_getClass := (_ef870f3c_mtm_ef870f3c_getClass - _ef870f3c_mt_ef870f3c)
_ef870f3c_mtm_ef870f3c_getClass:
    .long _my_Object_mdo_getClass
    .long _ef870f3c_cto_e36c4e5b
.global _my_Thread_m_hash := (_ef870f3c_mtm_ef870f3c_hash - _ef870f3c_mt_ef870f3c)
_ef870f3c_mtm_ef870f3c_hash:
    .long _my_Object_mdo_hash
    .long _ef870f3c_cto_e36c4e5b
.global _my_Thread_m_equals := (_ef870f3c_mtm_ef870f3c_equals - _ef870f3c_mt_ef870f3c)
_ef870f3c_mtm_ef870f3c_equals:
    .long _my_Object_mdo_equals
    .long _ef870f3c_cto_e36c4e5b
.global _my_Thread_m_rt := (_ef870f3c_mtm_ef870f3c_rt - _ef870f3c_mt_ef870f3c)
_ef870f3c_mtm_ef870f3c_rt:
    .long _my_Object_mdo_rt
    .long _ef870f3c_cto_e36c4e5b
.global _my_Thread_m_setRt := (_ef870f3c_mtm_ef870f3c_setRt - _ef870f3c_mt_ef870f3c)
_ef870f3c_mtm_ef870f3c_setRt:
    .long _my_Object_mdo_setRt
    .long _ef870f3c_cto_e36c4e5b
.global _my_Thread_m_run := (_ef870f3c_mtm_ef870f3c_run - _ef870f3c_mt_ef870f3c)
_ef870f3c_mtm_ef870f3c_run:
    .long _my_Thread_mdo_run
    .long _ef870f3c_cto_ef870f3c

// constants
// class-name Object
_my_Thread_cno_my_Object := (_ef870f3c_cn_e36c4e5b - _my_Thread)
_ef870f3c_cn_e36c4e5b:
    .asciz "/my/Object"

// class-name Thread
_my_Thread_cno_my_Thread := (_ef870f3c_cn_ef870f3c - _my_Thread)
_ef870f3c_cn_ef870f3c:
    .asciz "/my/Thread"

// instance template
_ef870f3c_tpl:
    .long 0
    .long 0
_ef870f3c_tpl_h_e36c4e5b:
    .long 0
    .long 0
    .long 0
    .long (_ef870f3c_tpl_vs_e36c4e5b - _ef870f3c_tpl)
_ef870f3c_tpl_h_ef870f3c:
    .long 0
    .long 0
    .long 0
_my_Thread_hvo_my_Object := (_ef870f3c_tpl_hv_e36c4e5b - _ef870f3c_tpl_h_ef870f3c)
_ef870f3c_tpl_hv_e36c4e5b:
    .long (_ef870f3c_tpl_vs_e36c4e5b - _ef870f3c_tpl)
_my_Thread_hvo_my_Thread := (_ef870f3c_tpl_hv_ef870f3c - _ef870f3c_tpl_h_ef870f3c)
_ef870f3c_tpl_hv_ef870f3c:
    .long (_ef870f3c_tpl_vs_ef870f3c - _ef870f3c_tpl)
_ef870f3c_tpl_vs_e36c4e5b:
// variable runtime
    .long 0
_ef870f3c_tpl_vs_ef870f3c:
_ef870f3c_tpl_end:

// method definitions
// method run
.global _my_Thread_mdo_run := 0
