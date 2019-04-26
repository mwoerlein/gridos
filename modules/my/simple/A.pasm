/*[meta]
mimetype = text/x-pasm
description = class "my::simple::A"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::simple::A
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class A
_my_simple_A:
    .long 0x15AC1A55
    .long 0
    .long _my_simple_A_coso_CLASSNAME
    .long (_1e739079_cts - _my_simple_A)
    .long (_1e739079_mts - _my_simple_A)
    .long (_1e739079_mdt - _my_simple_A)
    .long (_1e739079_tpl - _my_simple_A)
    .long (_1e739079_tpl_end - _1e739079_tpl)
    .long (_1e739079_tpl_h_01a2e54e - _1e739079_tpl)
    .long (_1e739079_tpl_h_1e739079 - _1e739079_tpl)

// class tab
_1e739079_cts:
_1e739079_cto_01a2e54e := (_1e739079_ct_01a2e54e - _my_simple_A)
_1e739079_ct_01a2e54e:
    .long 0
    .long _my_simple_A_coso_string_2
    .long (_1e739079_mt_01a2e54e - _my_simple_A)
    .long (_1e739079_tpl_h_01a2e54e - _1e739079_tpl)
_1e739079_cto_1e739079 := (_1e739079_ct_1e739079 - _my_simple_A)
_1e739079_ct_1e739079:
    .long 0
    .long _my_simple_A_coso_CLASSNAME
    .long (_1e739079_mt_1e739079 - _my_simple_A)
    .long (_1e739079_tpl_h_1e739079 - _1e739079_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_1e739079_mts:
_1e739079_mt_01a2e54e:
    .long 0
    .long _1e739079_cto_01a2e54e
    .long 4
    .long _1e739079_cto_01a2e54e
    .long 8
    .long _1e739079_cto_01a2e54e
    .long 12
    .long _1e739079_cto_01a2e54e
    .long 16
    .long _1e739079_cto_01a2e54e
    .long 20
    .long _1e739079_cto_01a2e54e
_1e739079_mt_1e739079:
    .long 0
    .long _1e739079_cto_01a2e54e
    .long 4
    .long _1e739079_cto_01a2e54e
    .long 8
    .long _1e739079_cto_01a2e54e
    .long 12
    .long _1e739079_cto_01a2e54e
    .long 16
    .long _1e739079_cto_01a2e54e
    .long 20
    .long _1e739079_cto_01a2e54e
    .long 0
    .long _1e739079_cto_1e739079
    .long 4
    .long _1e739079_cto_1e739079
    .long 8
    .long _1e739079_cto_1e739079
    .long 12
    .long _1e739079_cto_1e739079

// methods tab
_1e739079_mdt:
    .long (_1e739079_md_init - _my_simple_A)
    .long (_1e739079_md_getRow - _my_simple_A)
    .long (_1e739079_md_getRowAndColumn - _my_simple_A)
    .long (_1e739079_md_test - _my_simple_A)

// constants
// int cafe
_my_simple_A_coi_cafe := 51966

// string CLASSNAME
_my_simple_A_coso_CLASSNAME := (_1e739079_cos_CLASSNAME - _my_simple_A)
_1e739079_cos_CLASSNAME:
    .asciz "my::simple::A"

// string string_1
_my_simple_A_coso_string_1 := (_1e739079_cos_string_1 - _my_simple_A)
_1e739079_cos_string_1:
    .asciz " compile test"

// string string_2
_my_simple_A_coso_string_2 := (_1e739079_cos_string_2 - _my_simple_A)
_1e739079_cos_string_2:
    .asciz "my::core::Object"

// instance template
_1e739079_tpl:
    .long 0
    .long 0
_1e739079_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_1e739079_tpl_vs_01a2e54e - _1e739079_tpl)
_1e739079_tpl_h_1e739079:
    .long 0
    .long 0
    .long 0
_my_simple_A_hvo_my_core_Object := (_1e739079_tpl_hv_01a2e54e - _1e739079_tpl_h_1e739079)
_1e739079_tpl_hv_01a2e54e:
    .long (_1e739079_tpl_vs_01a2e54e - _1e739079_tpl)
_my_simple_A_hvo_my_simple_A := (_1e739079_tpl_hv_1e739079 - _1e739079_tpl_h_1e739079)
_1e739079_tpl_hv_1e739079:
    .long (_1e739079_tpl_vs_1e739079 - _1e739079_tpl)
_1e739079_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_1e739079_tpl_v_01a2e54e_runtime - _1e739079_tpl_vs_01a2e54e)
_1e739079_tpl_v_01a2e54e_runtime:
    .long 0
_1e739079_tpl_vs_1e739079:
// variable column
_my_simple_A_i_column := (_1e739079_tpl_v_1e739079_column - _1e739079_tpl_vs_1e739079)
_1e739079_tpl_v_1e739079_column:
    .long 0
// variable row
_my_simple_A_i_row := (_1e739079_tpl_v_1e739079_row - _1e739079_tpl_vs_1e739079)
_1e739079_tpl_v_1e739079_row:
    .long 0
_1e739079_tpl_end:

// method definitions
// method init
_1e739079_md_init:
    pushl %ebp; movl %esp, %ebp
    pushad
    jmp _1e739079_md_init_bb_2
_1e739079_md_init_bb_1:
    popad
    leave
    ret
_1e739079_md_init_bb_2:
    movl 12(%ebp), %eax
    movl _my_simple_A_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl 16(%ebp), %eax
    movl %eax, _my_simple_A_i_row(%ebx)
    movl 12(%ebp), %eax
    movl _my_simple_A_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl 20(%ebp), %eax
    movl %eax, _my_simple_A_i_column(%ebx)
    jmp _1e739079_md_init_bb_1
_1e739079_md_init_bb_3:
    jmp _1e739079_md_init_bb_1

// method getRow
_1e739079_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    jmp _1e739079_md_getRow_bb_2
_1e739079_md_getRow_bb_1:
    popad
    leave
    ret
_1e739079_md_getRow_bb_2:
    movl 12(%ebp), %eax
    movl _my_simple_A_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_simple_A_i_row(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _1e739079_md_getRow_bb_1
_1e739079_md_getRow_bb_3:
    jmp _1e739079_md_getRow_bb_1

// method getRowAndColumn
_1e739079_md_getRowAndColumn:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _1e739079_md_getRowAndColumn_bb_2
_1e739079_md_getRowAndColumn_bb_1:
    popad
    leave
    ret
_1e739079_md_getRowAndColumn_bb_2:
    movl 12(%ebp), %eax
    movl _my_simple_A_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_simple_A_i_row(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    movl 12(%ebp), %eax
    movl _my_simple_A_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_simple_A_i_column(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _1e739079_md_getRowAndColumn_bb_1
_1e739079_md_getRowAndColumn_bb_3:
    jmp _1e739079_md_getRowAndColumn_bb_1

// method test
_1e739079_md_test:
    pushl %ebp; movl %esp, %ebp
    subl 140, %esp
    pushad
    jmp _1e739079_md_test_bb_2
_1e739079_md_test_bb_1:
    popad
    leave
    ret
_1e739079_md_test_bb_2:
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 8, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    subl 4, %esp
    pushl 12(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 12, %esp
    popl -20(%ebp)
    movl 32, -24(%ebp)
    subl 4, %esp
    pushl -24(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -28(%ebp)
    movl 12(%ebp), %eax
    movl _my_simple_A_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_simple_A_i_column(%ebx), %eax
    movl %eax, -32(%ebp)
    subl 4, %esp
    pushl -32(%ebp)
    movl -28(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -36(%ebp)
    movl 32, -40(%ebp)
    subl 4, %esp
    pushl -40(%ebp)
    movl -36(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -44(%ebp)
    subl 4, %esp
    pushl 16(%ebp)
    movl -44(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -48(%ebp)
    movl 32, -52(%ebp)
    subl 4, %esp
    pushl -52(%ebp)
    movl -48(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -56(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 8, %esp
    popl -60(%ebp)
    movl 51966, -64(%ebp)
    subl 4, %esp
    pushl -64(%ebp)
    movl -60(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    popl -68(%ebp)
    subl 8, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -80(%ebp)
    popl -84(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -72(%ebp)
    movl -84(%ebp), %eax
    movl %eax, -76(%ebp)
    subl 8, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -96(%ebp)
    popl -100(%ebp)
    movl -96(%ebp), %eax
    movl %eax, -88(%ebp)
    movl -100(%ebp), %eax
    movl %eax, -92(%ebp)
    movl 32, -104(%ebp)
    subl 4, %esp
    pushl -104(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -108(%ebp)
    subl 4, %esp
    pushl -88(%ebp)
    movl -108(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -112(%ebp)
    movl 32, -116(%ebp)
    subl 4, %esp
    pushl -116(%ebp)
    movl -112(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -120(%ebp)
    subl 4, %esp
    pushl -92(%ebp)
    movl -120(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -124(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 8, %esp
    popl -128(%ebp)
    movl 8(%ebp), %eax
    addl _my_simple_A_coso_string_1, %eax
    movl %eax, -132(%ebp)
    subl 4, %esp
    pushl -132(%ebp)
    movl -128(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    popl -136(%ebp)
    subl 4, %esp
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 8, %esp
    popl -140(%ebp)
    jmp _1e739079_md_test_bb_1
_1e739079_md_test_bb_3:
    jmp _1e739079_md_test_bb_1
