/*[meta]
mimetype = text/x-pasm
description = class "my::core::OStream"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::core::OStream
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class OStream
_my_core_OStream:
    .long 0x15AC1A55
    .long 0
    .long _my_core_OStream_coso_CLASSNAME
    .long (_13be4a12_cts - _my_core_OStream)
    .long (_13be4a12_mts - _my_core_OStream)
    .long (_13be4a12_mdt - _my_core_OStream)
    .long (_13be4a12_tpl - _my_core_OStream)
    .long (_13be4a12_tpl_end - _13be4a12_tpl)
    .long (_13be4a12_tpl_h_01a2e54e - _13be4a12_tpl)
    .long (_13be4a12_tpl_h_13be4a12 - _13be4a12_tpl)

// class tab
_13be4a12_cts:
_13be4a12_cto_01a2e54e := (_13be4a12_ct_01a2e54e - _my_core_OStream)
_13be4a12_ct_01a2e54e:
    .long 0
    .long _my_core_OStream_coso_string_1
    .long (_13be4a12_mt_01a2e54e - _my_core_OStream)
    .long (_13be4a12_tpl_h_01a2e54e - _13be4a12_tpl)
_13be4a12_cto_13be4a12 := (_13be4a12_ct_13be4a12 - _my_core_OStream)
_13be4a12_ct_13be4a12:
    .long 0
    .long _my_core_OStream_coso_CLASSNAME
    .long (_13be4a12_mt_13be4a12 - _my_core_OStream)
    .long (_13be4a12_tpl_h_13be4a12 - _13be4a12_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_13be4a12_mts:
_13be4a12_mt_01a2e54e:
    .long 0
    .long _13be4a12_cto_01a2e54e
    .long 4
    .long _13be4a12_cto_01a2e54e
    .long 8
    .long _13be4a12_cto_01a2e54e
    .long 12
    .long _13be4a12_cto_01a2e54e
    .long 16
    .long _13be4a12_cto_01a2e54e
_13be4a12_mt_13be4a12:
    .long 0
    .long _13be4a12_cto_01a2e54e
    .long 4
    .long _13be4a12_cto_01a2e54e
    .long 8
    .long _13be4a12_cto_01a2e54e
    .long 12
    .long _13be4a12_cto_01a2e54e
    .long 16
    .long _13be4a12_cto_01a2e54e
    .long 0
    .long _13be4a12_cto_13be4a12
    .long 4
    .long _13be4a12_cto_13be4a12
    .long 8
    .long _13be4a12_cto_13be4a12
    .long 12
    .long _13be4a12_cto_13be4a12
    .long 16
    .long _13be4a12_cto_13be4a12

// methods tab
_13be4a12_mdt:
    .long 0
    .long 0
    .long 0
    .long 0
    .long (_13be4a12_md_printNewline - _my_core_OStream)

// constants
// string CLASSNAME
_my_core_OStream_coso_CLASSNAME := (_13be4a12_cos_CLASSNAME - _my_core_OStream)
_13be4a12_cos_CLASSNAME:
    .asciz "my::core::OStream"

// string string_1
_my_core_OStream_coso_string_1 := (_13be4a12_cos_string_1 - _my_core_OStream)
_13be4a12_cos_string_1:
    .asciz "my::core::Object"

// instance template
_13be4a12_tpl:
    .long 0
    .long 0
_13be4a12_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_13be4a12_tpl_vs_01a2e54e - _13be4a12_tpl)
_13be4a12_tpl_h_13be4a12:
    .long 0
    .long 0
    .long 0
_my_core_OStream_hvo_my_core_Object := (_13be4a12_tpl_hv_01a2e54e - _13be4a12_tpl_h_13be4a12)
_13be4a12_tpl_hv_01a2e54e:
    .long (_13be4a12_tpl_vs_01a2e54e - _13be4a12_tpl)
_my_core_OStream_hvo_my_core_OStream := (_13be4a12_tpl_hv_13be4a12 - _13be4a12_tpl_h_13be4a12)
_13be4a12_tpl_hv_13be4a12:
    .long (_13be4a12_tpl_vs_13be4a12 - _13be4a12_tpl)
_13be4a12_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_13be4a12_tpl_v_01a2e54e_runtime - _13be4a12_tpl_vs_01a2e54e)
_13be4a12_tpl_v_01a2e54e_runtime:
    .long 0
_13be4a12_tpl_vs_13be4a12:
_13be4a12_tpl_end:

// method definitions
// method printChar

// method printString

// method printInt

// method printHex

// method printNewline
_13be4a12_md_printNewline:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _13be4a12_md_printNewline_bb_2
_13be4a12_md_printNewline_bb_1:
    popad
    leave
    ret
_13be4a12_md_printNewline_bb_2:
    movl 10, -4(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _13be4a12_md_printNewline_bb_1
_13be4a12_md_printNewline_bb_3:
    jmp _13be4a12_md_printNewline_bb_1
