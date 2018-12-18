/*[meta]
mimetype = text/x-pasm
description = class "my::core::Thread"
[pool]
version = 0.1.0
class = true
[pool_source]
unit = my::core::Thread
*/
// class Thread
_my_core_Thread:
    .long 0x15AC1A55
    .long 0
    .long _my_core_Thread_cno_my_core_Thread
    .long (_0dbda62f_cts - _my_core_Thread)
    .long (_0dbda62f_mts - _my_core_Thread)
    .long (_0dbda62f_tpl - _my_core_Thread)
    .long (_0dbda62f_tpl_end - _0dbda62f_tpl)
    .long (_0dbda62f_tpl_h_01a2e54e - _0dbda62f_tpl)
    .long (_0dbda62f_tpl_h_0dbda62f - _0dbda62f_tpl)

// class tab
_0dbda62f_cts:
_0dbda62f_cto_01a2e54e := (_0dbda62f_ct_01a2e54e - _my_core_Thread)
_0dbda62f_ct_01a2e54e:
    .long 0
    .long _my_core_Thread_cno_my_core_Object
    .long (_0dbda62f_mt_01a2e54e - _my_core_Thread)
    .long (_0dbda62f_tpl_h_01a2e54e - _0dbda62f_tpl)
_0dbda62f_cto_0dbda62f := (_0dbda62f_ct_0dbda62f - _my_core_Thread)
_0dbda62f_ct_0dbda62f:
    .long 0
    .long _my_core_Thread_cno_my_core_Thread
    .long (_0dbda62f_mt_0dbda62f - _my_core_Thread)
    .long (_0dbda62f_tpl_h_0dbda62f - _0dbda62f_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_0dbda62f_mts:
_0dbda62f_mt_01a2e54e:
    .long _my_core_Object_mdo_getClass
    .long _0dbda62f_cto_01a2e54e
    .long _my_core_Object_mdo_hash
    .long _0dbda62f_cto_01a2e54e
    .long _my_core_Object_mdo_equals
    .long _0dbda62f_cto_01a2e54e
    .long _my_core_Object_mdo_rt
    .long _0dbda62f_cto_01a2e54e
    .long _my_core_Object_mdo_setRt
    .long _0dbda62f_cto_01a2e54e
_0dbda62f_mt_0dbda62f:
.global _my_core_Thread_m_getClass := (_0dbda62f_mtm_0dbda62f_getClass - _0dbda62f_mt_0dbda62f)
_0dbda62f_mtm_0dbda62f_getClass:
    .long _my_core_Object_mdo_getClass
    .long _0dbda62f_cto_01a2e54e
.global _my_core_Thread_m_hash := (_0dbda62f_mtm_0dbda62f_hash - _0dbda62f_mt_0dbda62f)
_0dbda62f_mtm_0dbda62f_hash:
    .long _my_core_Object_mdo_hash
    .long _0dbda62f_cto_01a2e54e
.global _my_core_Thread_m_equals := (_0dbda62f_mtm_0dbda62f_equals - _0dbda62f_mt_0dbda62f)
_0dbda62f_mtm_0dbda62f_equals:
    .long _my_core_Object_mdo_equals
    .long _0dbda62f_cto_01a2e54e
.global _my_core_Thread_m_rt := (_0dbda62f_mtm_0dbda62f_rt - _0dbda62f_mt_0dbda62f)
_0dbda62f_mtm_0dbda62f_rt:
    .long _my_core_Object_mdo_rt
    .long _0dbda62f_cto_01a2e54e
.global _my_core_Thread_m_setRt := (_0dbda62f_mtm_0dbda62f_setRt - _0dbda62f_mt_0dbda62f)
_0dbda62f_mtm_0dbda62f_setRt:
    .long _my_core_Object_mdo_setRt
    .long _0dbda62f_cto_01a2e54e
.global _my_core_Thread_m_run := (_0dbda62f_mtm_0dbda62f_run - _0dbda62f_mt_0dbda62f)
_0dbda62f_mtm_0dbda62f_run:
    .long _my_core_Thread_mdo_run
    .long _0dbda62f_cto_0dbda62f

// constants
// class-name Object
_my_core_Thread_cno_my_core_Object := (_0dbda62f_cn_01a2e54e - _my_core_Thread)
_0dbda62f_cn_01a2e54e:
    .asciz "my::core::Object"

// class-name Thread
_my_core_Thread_cno_my_core_Thread := (_0dbda62f_cn_0dbda62f - _my_core_Thread)
_0dbda62f_cn_0dbda62f:
    .asciz "my::core::Thread"

// instance template
_0dbda62f_tpl:
    .long 0
    .long 0
_0dbda62f_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_0dbda62f_tpl_vs_01a2e54e - _0dbda62f_tpl)
_0dbda62f_tpl_h_0dbda62f:
    .long 0
    .long 0
    .long 0
_my_core_Thread_hvo_my_core_Object := (_0dbda62f_tpl_hv_01a2e54e - _0dbda62f_tpl_h_0dbda62f)
_0dbda62f_tpl_hv_01a2e54e:
    .long (_0dbda62f_tpl_vs_01a2e54e - _0dbda62f_tpl)
_my_core_Thread_hvo_my_core_Thread := (_0dbda62f_tpl_hv_0dbda62f - _0dbda62f_tpl_h_0dbda62f)
_0dbda62f_tpl_hv_0dbda62f:
    .long (_0dbda62f_tpl_vs_0dbda62f - _0dbda62f_tpl)
_0dbda62f_tpl_vs_01a2e54e:
// variable runtime
    .long 0
_0dbda62f_tpl_vs_0dbda62f:
_0dbda62f_tpl_end:

// method definitions
// method run
.global _my_core_Thread_mdo_run := 0
