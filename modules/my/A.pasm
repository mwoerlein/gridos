/*[meta]
mimetype = text/x-pasm
description = class "my::A"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::A
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class A
_my_A:
    .long 0x15AC1A55
    .long 0
    .long _my_A_cno_my_A
    .long (_07f7c73b_cts - _my_A)
    .long (_07f7c73b_mts - _my_A)
    .long (_07f7c73b_mdt - _my_A)
    .long (_07f7c73b_tpl - _my_A)
    .long (_07f7c73b_tpl_end - _07f7c73b_tpl)
    .long (_07f7c73b_tpl_h_01a2e54e - _07f7c73b_tpl)
    .long (_07f7c73b_tpl_h_07f7c73b - _07f7c73b_tpl)

// class tab
_07f7c73b_cts:
_07f7c73b_cto_01a2e54e := (_07f7c73b_ct_01a2e54e - _my_A)
_07f7c73b_ct_01a2e54e:
    .long 0
    .long _my_A_cno_my_core_Object
    .long (_07f7c73b_mt_01a2e54e - _my_A)
    .long (_07f7c73b_tpl_h_01a2e54e - _07f7c73b_tpl)
_07f7c73b_cto_07f7c73b := (_07f7c73b_ct_07f7c73b - _my_A)
_07f7c73b_ct_07f7c73b:
    .long 0
    .long _my_A_cno_my_A
    .long (_07f7c73b_mt_07f7c73b - _my_A)
    .long (_07f7c73b_tpl_h_07f7c73b - _07f7c73b_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_07f7c73b_mts:
_07f7c73b_mt_01a2e54e:
_my_core_Object_m_getClass := 0
    .long 0
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_hash := 8
    .long 4
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_equals := 16
    .long 8
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_rt := 24
    .long 12
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_setRt := 32
    .long 16
    .long _07f7c73b_cto_01a2e54e
_07f7c73b_mt_07f7c73b:
_my_A_m_getClass := 0
    .long 0
    .long _07f7c73b_cto_01a2e54e
_my_A_m_hash := 8
    .long 4
    .long _07f7c73b_cto_01a2e54e
_my_A_m_equals := 16
    .long 8
    .long _07f7c73b_cto_01a2e54e
_my_A_m_rt := 24
    .long 12
    .long _07f7c73b_cto_01a2e54e
_my_A_m_setRt := 32
    .long 16
    .long _07f7c73b_cto_01a2e54e
_my_A_m_init := 40
    .long 0
    .long _07f7c73b_cto_07f7c73b
_my_A_m_getRow := 48
    .long 4
    .long _07f7c73b_cto_07f7c73b
_my_A_m_getRowAndColumn := 56
    .long 8
    .long _07f7c73b_cto_07f7c73b
_my_A_m_test := 64
    .long 12
    .long _07f7c73b_cto_07f7c73b

// methods tab
_07f7c73b_mdt:
_my_A_mdo_init := (_07f7c73b_md_init - _my_A)
    .long _my_A_mdo_init
_my_A_mdo_getRow := (_07f7c73b_md_getRow - _my_A)
    .long _my_A_mdo_getRow
_my_A_mdo_getRowAndColumn := (_07f7c73b_md_getRowAndColumn - _my_A)
    .long _my_A_mdo_getRowAndColumn
_my_A_mdo_test := (_07f7c73b_md_test - _my_A)
    .long _my_A_mdo_test

// constants
// string _83997363
_my_A_coso__83997363 := (_07f7c73b_cos__83997363 - _my_A)
_07f7c73b_cos__83997363:
    .asciz " compile test\n"

// class-name Object
_my_A_cno_my_core_Object := (_07f7c73b_cn_01a2e54e - _my_A)
_07f7c73b_cn_01a2e54e:
    .asciz "my::core::Object"

// class-name A
_my_A_cno_my_A := (_07f7c73b_cn_07f7c73b - _my_A)
_07f7c73b_cn_07f7c73b:
    .asciz "my::A"

// instance template
_07f7c73b_tpl:
    .long 0
    .long 0
_07f7c73b_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_07f7c73b_tpl_vs_01a2e54e - _07f7c73b_tpl)
_07f7c73b_tpl_h_07f7c73b:
    .long 0
    .long 0
    .long 0
_my_A_hvo_my_core_Object := (_07f7c73b_tpl_hv_01a2e54e - _07f7c73b_tpl_h_07f7c73b)
_07f7c73b_tpl_hv_01a2e54e:
    .long (_07f7c73b_tpl_vs_01a2e54e - _07f7c73b_tpl)
_my_A_hvo_my_A := (_07f7c73b_tpl_hv_07f7c73b - _07f7c73b_tpl_h_07f7c73b)
_07f7c73b_tpl_hv_07f7c73b:
    .long (_07f7c73b_tpl_vs_07f7c73b - _07f7c73b_tpl)
_07f7c73b_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_07f7c73b_tpl_v_01a2e54e_runtime - _07f7c73b_tpl_vs_01a2e54e)
_07f7c73b_tpl_v_01a2e54e_runtime:
    .long 0
_07f7c73b_tpl_vs_07f7c73b:
// variable column
_my_A_i_column := (_07f7c73b_tpl_v_07f7c73b_column - _07f7c73b_tpl_vs_07f7c73b)
_07f7c73b_tpl_v_07f7c73b_column:
    .long 0
// variable row
_my_A_i_row := (_07f7c73b_tpl_v_07f7c73b_row - _07f7c73b_tpl_vs_07f7c73b)
_07f7c73b_tpl_v_07f7c73b_row:
    .long 0
_07f7c73b_tpl_end:

// method definitions
// method init
_07f7c73b_md_init:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -8(%ebp)
    movl -4(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl -8(%ebp), %eax
    movl %eax, _my_A_i_row(%ebx)
    movl 20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl -4(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl -12(%ebp), %eax
    movl %eax, _my_A_i_column(%ebx)
    jmp _07f7c73b_md_init_return
_07f7c73b_md_init_return:
    leave
    ret

// method getRow
_07f7c73b_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _07f7c73b_md_getRow_return
_07f7c73b_md_getRow_return:
    leave
    ret

// method getRowAndColumn
_07f7c73b_md_getRowAndColumn:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    movl -4(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_column(%ebx), %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _07f7c73b_md_getRowAndColumn_return
_07f7c73b_md_getRowAndColumn_return:
    leave
    ret

// method test
_07f7c73b_md_test:
    pushl %ebp; movl %esp, %ebp
    subl 96, %esp
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -8(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 0; call (%eax)
    addl 8, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, -20(%ebp)
    subl 4, %esp
    movl -20(%ebp), %eax
    pushl %eax; pushl 0; call (%eax)
    addl 8, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    subl 4, %esp
    movl -20(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -32(%ebp)
    pushl -8(%ebp)
    pushl -32(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    movl 32, -36(%ebp)
    pushl -8(%ebp)
    pushl -36(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl -4(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_column(%ebx), %eax
    movl %eax, -40(%ebp)
    pushl -8(%ebp)
    pushl -40(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -44(%ebp)
    pushl -8(%ebp)
    pushl -44(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 16(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl -8(%ebp)
    pushl -48(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -52(%ebp)
    pushl -8(%ebp)
    pushl -52(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    subl 8, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -64(%ebp)
    popl -68(%ebp)
    movl -64(%ebp), %eax
    movl %eax, -56(%ebp)
    movl -68(%ebp), %eax
    movl %eax, -60(%ebp)
    subl 8, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -80(%ebp)
    popl -84(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -72(%ebp)
    movl -84(%ebp), %eax
    movl %eax, -76(%ebp)
    pushl -8(%ebp)
    pushl -72(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -88(%ebp)
    pushl -8(%ebp)
    pushl -88(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    pushl -8(%ebp)
    pushl -76(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_A_coso__83997363, %eax
    movl %eax, -92(%ebp)
    movl 1, -96(%ebp)
    pushl -96(%ebp)
    pushl -92(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    jmp _07f7c73b_md_test_return
_07f7c73b_md_test_return:
    leave
    ret
