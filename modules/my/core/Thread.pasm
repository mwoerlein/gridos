/*[meta]
mimetype = text/x-pasm
description = class "my::core::Thread"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::core::Thread
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class Thread
_my_core_Thread:
    .long 0x15AC1A55
    .long 0
    .long _my_core_Thread_coso_CLASSNAME
    .long (_0dbda62f_cts - _my_core_Thread)
    .long (_0dbda62f_mts - _my_core_Thread)
    .long (_0dbda62f_mdt - _my_core_Thread)
    .long (_0dbda62f_tpl - _my_core_Thread)
    .long (_0dbda62f_tpl_end - _0dbda62f_tpl)
    .long (_0dbda62f_tpl_h_01a2e54e - _0dbda62f_tpl)
    .long (_0dbda62f_tpl_h_0dbda62f - _0dbda62f_tpl)

// class tab
_0dbda62f_cts:
_0dbda62f_cto_01a2e54e := (_0dbda62f_ct_01a2e54e - _my_core_Thread)
_0dbda62f_ct_01a2e54e:
    .long 0
    .long _my_core_Thread_coso_string_1
    .long (_0dbda62f_mt_01a2e54e - _my_core_Thread)
    .long (_0dbda62f_tpl_h_01a2e54e - _0dbda62f_tpl)
_0dbda62f_cto_0dbda62f := (_0dbda62f_ct_0dbda62f - _my_core_Thread)
_0dbda62f_ct_0dbda62f:
    .long 0
    .long _my_core_Thread_coso_CLASSNAME
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
    .long 0
    .long _0dbda62f_cto_01a2e54e
    .long 4
    .long _0dbda62f_cto_01a2e54e
    .long 8
    .long _0dbda62f_cto_01a2e54e
    .long 12
    .long _0dbda62f_cto_01a2e54e
    .long 16
    .long _0dbda62f_cto_01a2e54e
_0dbda62f_mt_0dbda62f:
    .long 0
    .long _0dbda62f_cto_01a2e54e
    .long 4
    .long _0dbda62f_cto_01a2e54e
    .long 8
    .long _0dbda62f_cto_01a2e54e
    .long 12
    .long _0dbda62f_cto_01a2e54e
    .long 16
    .long _0dbda62f_cto_01a2e54e
    .long 0
    .long _0dbda62f_cto_0dbda62f

// methods tab
_0dbda62f_mdt:
    .long 0

// constants
// string CLASSNAME
_my_core_Thread_coso_CLASSNAME := (_0dbda62f_cos_CLASSNAME - _my_core_Thread)
_0dbda62f_cos_CLASSNAME:
    .asciz "my::core::Thread"

// string string_1
_my_core_Thread_coso_string_1 := (_0dbda62f_cos_string_1 - _my_core_Thread)
_0dbda62f_cos_string_1:
    .asciz "my::core::Object"

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
_my_core_Object_i_runtime := (_0dbda62f_tpl_v_01a2e54e_runtime - _0dbda62f_tpl_vs_01a2e54e)
_0dbda62f_tpl_v_01a2e54e_runtime:
    .long 0
_0dbda62f_tpl_vs_0dbda62f:
_0dbda62f_tpl_end:

// method definitions
// method run
