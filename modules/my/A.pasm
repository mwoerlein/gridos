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
    .long _my_A_coso_CLASSNAME
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
    .long _my_A_coso_string_3
    .long (_07f7c73b_mt_01a2e54e - _my_A)
    .long (_07f7c73b_tpl_h_01a2e54e - _07f7c73b_tpl)
_07f7c73b_cto_07f7c73b := (_07f7c73b_ct_07f7c73b - _my_A)
_07f7c73b_ct_07f7c73b:
    .long 0
    .long _my_A_coso_CLASSNAME
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
    .long 0
    .long _07f7c73b_cto_01a2e54e
    .long 4
    .long _07f7c73b_cto_01a2e54e
    .long 8
    .long _07f7c73b_cto_01a2e54e
    .long 12
    .long _07f7c73b_cto_01a2e54e
    .long 16
    .long _07f7c73b_cto_01a2e54e
_07f7c73b_mt_07f7c73b:
    .long 0
    .long _07f7c73b_cto_01a2e54e
    .long 4
    .long _07f7c73b_cto_01a2e54e
    .long 8
    .long _07f7c73b_cto_01a2e54e
    .long 12
    .long _07f7c73b_cto_01a2e54e
    .long 16
    .long _07f7c73b_cto_01a2e54e
    .long 0
    .long _07f7c73b_cto_07f7c73b
    .long 4
    .long _07f7c73b_cto_07f7c73b
    .long 8
    .long _07f7c73b_cto_07f7c73b
    .long 12
    .long _07f7c73b_cto_07f7c73b

// methods tab
_07f7c73b_mdt:
    .long (_07f7c73b_md_init - _my_A)
    .long (_07f7c73b_md_getRow - _my_A)
    .long (_07f7c73b_md_getRowAndColumn - _my_A)
    .long (_07f7c73b_md_test - _my_A)

// constants
// int cafe
_my_A_coi_cafe := 51966

// string CLASSNAME
_my_A_coso_CLASSNAME := (_07f7c73b_cos_CLASSNAME - _my_A)
_07f7c73b_cos_CLASSNAME:
    .asciz "my::A"

// string string_1
_my_A_coso_string_1 := (_07f7c73b_cos_string_1 - _my_A)
_07f7c73b_cos_string_1:
    .asciz " compile test"

// string string_2
_my_A_coso_string_2 := (_07f7c73b_cos_string_2 - _my_A)
_07f7c73b_cos_string_2:
    .asciz "\n"

// string string_3
_my_A_coso_string_3 := (_07f7c73b_cos_string_3 - _my_A)
_07f7c73b_cos_string_3:
    .asciz "my::core::Object"

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
    subl 4, %esp
    pushad
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl 16(%ebp), %eax
    movl %eax, _my_A_i_row(%ebx)
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl 20(%ebp), %eax
    movl %eax, _my_A_i_column(%ebx)
    jmp _07f7c73b_md_init_return
_07f7c73b_md_init_return:
    popad
    leave
    ret

// method getRow
_07f7c73b_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _07f7c73b_md_getRow_return
_07f7c73b_md_getRow_return:
    popad
    leave
    ret

// method getRowAndColumn
_07f7c73b_md_getRowAndColumn:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    pushad
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_column(%ebx), %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _07f7c73b_md_getRowAndColumn_return
_07f7c73b_md_getRowAndColumn_return:
    popad
    leave
    ret

// method test
_07f7c73b_md_test:
    pushl %ebp; movl %esp, %ebp
    subl 104, %esp
    pushad
    movl 0, -8(%ebp)
    movl 1, -12(%ebp)
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, -16(%ebp)
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 0; call (%eax)
    addl 8, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -24(%ebp)
    subl 4, %esp
    movl -24(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -32(%ebp)
    pushl -8(%ebp)
    pushl -32(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    movl 32, -36(%ebp)
    pushl -8(%ebp)
    pushl -36(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_column(%ebx), %eax
    movl %eax, -40(%ebp)
    pushl -8(%ebp)
    pushl -40(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -44(%ebp)
    pushl -8(%ebp)
    pushl -44(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    pushl -8(%ebp)
    pushl 16(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -48(%ebp)
    pushl -8(%ebp)
    pushl -48(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 51966, -52(%ebp)
    pushl -12(%ebp)
    pushl -52(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    movl 32, -56(%ebp)
    pushl -8(%ebp)
    pushl -56(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    subl 8, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -68(%ebp)
    popl -72(%ebp)
    movl -68(%ebp), %eax
    movl %eax, -60(%ebp)
    movl -72(%ebp), %eax
    movl %eax, -64(%ebp)
    subl 8, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -84(%ebp)
    popl -88(%ebp)
    movl -84(%ebp), %eax
    movl %eax, -76(%ebp)
    movl -88(%ebp), %eax
    movl %eax, -80(%ebp)
    pushl -8(%ebp)
    pushl -76(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -92(%ebp)
    pushl -8(%ebp)
    pushl -92(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    pushl -8(%ebp)
    pushl -80(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_A_coso_string_1, %eax
    movl %eax, -96(%ebp)
    pushl -12(%ebp)
    pushl -96(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_A_coso_string_2, %eax
    movl %eax, -100(%ebp)
    movl 0, -104(%ebp)
    pushl -104(%ebp)
    pushl -100(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    jmp _07f7c73b_md_test_return
_07f7c73b_md_test_return:
    popad
    leave
    ret
