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
    .long _my_A_coso_string_2
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
    pushad
    jmp _07f7c73b_md_init_bb_2
_07f7c73b_md_init_bb_1:
    popad
    leave
    ret
_07f7c73b_md_init_bb_2:
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
    jmp _07f7c73b_md_init_bb_1
_07f7c73b_md_init_bb_3:
    jmp _07f7c73b_md_init_bb_1

// method getRow
_07f7c73b_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    pushad
    jmp _07f7c73b_md_getRow_bb_2
_07f7c73b_md_getRow_bb_1:
    popad
    leave
    ret
_07f7c73b_md_getRow_bb_2:
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _07f7c73b_md_getRow_bb_1
_07f7c73b_md_getRow_bb_3:
    jmp _07f7c73b_md_getRow_bb_1

// method getRowAndColumn
_07f7c73b_md_getRowAndColumn:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _07f7c73b_md_getRowAndColumn_bb_2
_07f7c73b_md_getRowAndColumn_bb_1:
    popad
    leave
    ret
_07f7c73b_md_getRowAndColumn_bb_2:
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 16(%ebp)
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_column(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _07f7c73b_md_getRowAndColumn_bb_1
_07f7c73b_md_getRowAndColumn_bb_3:
    jmp _07f7c73b_md_getRowAndColumn_bb_1

// method test
_07f7c73b_md_test:
    pushl %ebp; movl %esp, %ebp
    subl 152, %esp
    pushad
    jmp _07f7c73b_md_test_bb_2
_07f7c73b_md_test_bb_1:
    popad
    leave
    ret
_07f7c73b_md_test_bb_2:
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 0; call (%eax)
    addl 8, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, -20(%ebp)
    subl 4, %esp
    movl -20(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -28(%ebp)
    subl 4, %esp
    pushl -28(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -32(%ebp)
    movl 32, -36(%ebp)
    subl 4, %esp
    pushl -36(%ebp)
    movl -32(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    popl -40(%ebp)
    movl 12(%ebp), %eax
    movl _my_A_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_column(%ebx), %eax
    movl %eax, -44(%ebp)
    subl 4, %esp
    pushl -44(%ebp)
    movl -40(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -48(%ebp)
    movl 32, -52(%ebp)
    subl 4, %esp
    pushl -52(%ebp)
    movl -48(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    popl -56(%ebp)
    subl 4, %esp
    pushl 16(%ebp)
    movl -56(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -60(%ebp)
    movl 32, -64(%ebp)
    subl 4, %esp
    pushl -64(%ebp)
    movl -60(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    popl -68(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -72(%ebp)
    movl 51966, -76(%ebp)
    subl 4, %esp
    pushl -76(%ebp)
    movl -72(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    popl -80(%ebp)
    subl 8, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -92(%ebp)
    popl -96(%ebp)
    movl -92(%ebp), %eax
    movl %eax, -84(%ebp)
    movl -96(%ebp), %eax
    movl %eax, -88(%ebp)
    subl 8, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -108(%ebp)
    popl -112(%ebp)
    movl -108(%ebp), %eax
    movl %eax, -100(%ebp)
    movl -112(%ebp), %eax
    movl %eax, -104(%ebp)
    movl 32, -116(%ebp)
    subl 4, %esp
    pushl -116(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    popl -120(%ebp)
    subl 4, %esp
    pushl -100(%ebp)
    movl -120(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -124(%ebp)
    movl 32, -128(%ebp)
    subl 4, %esp
    pushl -128(%ebp)
    movl -124(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 12, %esp
    popl -132(%ebp)
    subl 4, %esp
    pushl -104(%ebp)
    movl -132(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -136(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -140(%ebp)
    movl 8(%ebp), %eax
    addl _my_A_coso_string_1, %eax
    movl %eax, -144(%ebp)
    subl 4, %esp
    pushl -144(%ebp)
    movl -140(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -148(%ebp)
    subl 4, %esp
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 8, %esp
    popl -152(%ebp)
    jmp _07f7c73b_md_test_bb_1
_07f7c73b_md_test_bb_3:
    jmp _07f7c73b_md_test_bb_1
