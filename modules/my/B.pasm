/*[meta]
mimetype = text/x-pasm
description = class "my::B"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::B
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class B
_my_B:
    .long 0x15AC1A55
    .long 0
    .long _my_B_coso_CLASSNAME
    .long (_07f7c73c_cts - _my_B)
    .long (_07f7c73c_mts - _my_B)
    .long (_07f7c73c_mdt - _my_B)
    .long (_07f7c73c_tpl - _my_B)
    .long (_07f7c73c_tpl_end - _07f7c73c_tpl)
    .long (_07f7c73c_tpl_h_01a2e54e - _07f7c73c_tpl)
    .long (_07f7c73c_tpl_h_07f7c73c - _07f7c73c_tpl)

// class tab
_07f7c73c_cts:
_07f7c73c_cto_01a2e54e := (_07f7c73c_ct_01a2e54e - _my_B)
_07f7c73c_ct_01a2e54e:
    .long 0
    .long _my_B_coso_string_3
    .long (_07f7c73c_mt_01a2e54e - _my_B)
    .long (_07f7c73c_tpl_h_01a2e54e - _07f7c73c_tpl)
_07f7c73c_cto_0dbda62f := (_07f7c73c_ct_0dbda62f - _my_B)
_07f7c73c_ct_0dbda62f:
    .long 0
    .long _my_B_coso_string_4
    .long (_07f7c73c_mt_0dbda62f - _my_B)
    .long (_07f7c73c_tpl_h_0dbda62f - _07f7c73c_tpl)
_07f7c73c_cto_07f7c73b := (_07f7c73c_ct_07f7c73b - _my_B)
_07f7c73c_ct_07f7c73b:
    .long 0
    .long _my_B_coso_string_2
    .long (_07f7c73c_mt_07f7c73b - _my_B)
    .long (_07f7c73c_tpl_h_07f7c73b - _07f7c73c_tpl)
_07f7c73c_cto_07f7c73c := (_07f7c73c_ct_07f7c73c - _my_B)
_07f7c73c_ct_07f7c73c:
    .long 0
    .long _my_B_coso_CLASSNAME
    .long (_07f7c73c_mt_07f7c73c - _my_B)
    .long (_07f7c73c_tpl_h_07f7c73c - _07f7c73c_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_07f7c73c_mts:
_07f7c73c_mt_01a2e54e:
    .long 0
    .long _07f7c73c_cto_01a2e54e
    .long 4
    .long _07f7c73c_cto_01a2e54e
    .long 8
    .long _07f7c73c_cto_01a2e54e
    .long 12
    .long _07f7c73c_cto_01a2e54e
    .long 16
    .long _07f7c73c_cto_01a2e54e
_07f7c73c_mt_0dbda62f:
    .long 0
    .long _07f7c73c_cto_01a2e54e
    .long 4
    .long _07f7c73c_cto_01a2e54e
    .long 8
    .long _07f7c73c_cto_01a2e54e
    .long 12
    .long _07f7c73c_cto_01a2e54e
    .long 16
    .long _07f7c73c_cto_01a2e54e
    .long 0
    .long _07f7c73c_cto_07f7c73c
_07f7c73c_mt_07f7c73b:
    .long 0
    .long _07f7c73c_cto_01a2e54e
    .long 4
    .long _07f7c73c_cto_01a2e54e
    .long 8
    .long _07f7c73c_cto_01a2e54e
    .long 12
    .long _07f7c73c_cto_01a2e54e
    .long 16
    .long _07f7c73c_cto_01a2e54e
    .long 0
    .long _07f7c73c_cto_07f7c73b
    .long 12
    .long _07f7c73c_cto_07f7c73c
    .long 8
    .long _07f7c73c_cto_07f7c73b
    .long 12
    .long _07f7c73c_cto_07f7c73b
_07f7c73c_mt_07f7c73c:
    .long 0
    .long _07f7c73c_cto_01a2e54e
    .long 4
    .long _07f7c73c_cto_01a2e54e
    .long 8
    .long _07f7c73c_cto_01a2e54e
    .long 12
    .long _07f7c73c_cto_01a2e54e
    .long 16
    .long _07f7c73c_cto_01a2e54e
    .long 0
    .long _07f7c73c_cto_07f7c73c
    .long 0
    .long _07f7c73c_cto_07f7c73b
    .long 12
    .long _07f7c73c_cto_07f7c73c
    .long 8
    .long _07f7c73c_cto_07f7c73b
    .long 12
    .long _07f7c73c_cto_07f7c73b
    .long 4
    .long _07f7c73c_cto_07f7c73c
    .long 8
    .long _07f7c73c_cto_07f7c73c

// methods tab
_07f7c73c_mdt:
    .long (_07f7c73c_md_run - _my_B)
    .long (_07f7c73c_md_doIt - _my_B)
    .long (_07f7c73c_md_testAllocate - _my_B)
    .long (_07f7c73c_md_getRow - _my_B)

// constants
// string CLASSNAME
_my_B_coso_CLASSNAME := (_07f7c73c_cos_CLASSNAME - _my_B)
_07f7c73c_cos_CLASSNAME:
    .asciz "my::B"

// string string_1
_my_B_coso_string_1 := (_07f7c73c_cos_string_1 - _my_B)
_07f7c73c_cos_string_1:
    .asciz "OMG!! "

// string string_2
_my_B_coso_string_2 := (_07f7c73c_cos_string_2 - _my_B)
_07f7c73c_cos_string_2:
    .asciz "my::A"

// string string_3
_my_B_coso_string_3 := (_07f7c73c_cos_string_3 - _my_B)
_07f7c73c_cos_string_3:
    .asciz "my::core::Object"

// string string_4
_my_B_coso_string_4 := (_07f7c73c_cos_string_4 - _my_B)
_07f7c73c_cos_string_4:
    .asciz "my::core::Thread"

// instance template
_07f7c73c_tpl:
    .long 0
    .long 0
_07f7c73c_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_07f7c73c_tpl_vs_01a2e54e - _07f7c73c_tpl)
_07f7c73c_tpl_h_0dbda62f:
    .long 0
    .long 0
    .long 0
    .long (_07f7c73c_tpl_vs_01a2e54e - _07f7c73c_tpl)
    .long (_07f7c73c_tpl_vs_0dbda62f - _07f7c73c_tpl)
_07f7c73c_tpl_h_07f7c73b:
    .long 0
    .long 0
    .long 0
    .long (_07f7c73c_tpl_vs_01a2e54e - _07f7c73c_tpl)
    .long (_07f7c73c_tpl_vs_07f7c73b - _07f7c73c_tpl)
_07f7c73c_tpl_h_07f7c73c:
    .long 0
    .long 0
    .long 0
_my_B_hvo_my_core_Object := (_07f7c73c_tpl_hv_01a2e54e - _07f7c73c_tpl_h_07f7c73c)
_07f7c73c_tpl_hv_01a2e54e:
    .long (_07f7c73c_tpl_vs_01a2e54e - _07f7c73c_tpl)
_my_B_hvo_my_core_Thread := (_07f7c73c_tpl_hv_0dbda62f - _07f7c73c_tpl_h_07f7c73c)
_07f7c73c_tpl_hv_0dbda62f:
    .long (_07f7c73c_tpl_vs_0dbda62f - _07f7c73c_tpl)
_my_B_hvo_my_A := (_07f7c73c_tpl_hv_07f7c73b - _07f7c73c_tpl_h_07f7c73c)
_07f7c73c_tpl_hv_07f7c73b:
    .long (_07f7c73c_tpl_vs_07f7c73b - _07f7c73c_tpl)
_my_B_hvo_my_B := (_07f7c73c_tpl_hv_07f7c73c - _07f7c73c_tpl_h_07f7c73c)
_07f7c73c_tpl_hv_07f7c73c:
    .long (_07f7c73c_tpl_vs_07f7c73c - _07f7c73c_tpl)
_07f7c73c_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_07f7c73c_tpl_v_01a2e54e_runtime - _07f7c73c_tpl_vs_01a2e54e)
_07f7c73c_tpl_v_01a2e54e_runtime:
    .long 0
_07f7c73c_tpl_vs_0dbda62f:
_07f7c73c_tpl_vs_07f7c73b:
// variable column
_my_A_i_column := (_07f7c73c_tpl_v_07f7c73b_column - _07f7c73c_tpl_vs_07f7c73b)
_07f7c73c_tpl_v_07f7c73b_column:
    .long 0
// variable row
_my_A_i_row := (_07f7c73c_tpl_v_07f7c73b_row - _07f7c73c_tpl_vs_07f7c73b)
_07f7c73c_tpl_v_07f7c73b_row:
    .long 0
_07f7c73c_tpl_vs_07f7c73c:
_07f7c73c_tpl_end:

// method definitions
// method run
_07f7c73c_md_run:
    pushl %ebp; movl %esp, %ebp
    subl 56, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, -8(%ebp)
    movl 7, -16(%ebp)
    movl 20, -20(%ebp)
    pushl -20(%ebp)
    pushl -16(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_B_coso_string_2, %eax
    movl %eax, -28(%ebp)
    subl 4, %esp
    pushl -28(%ebp)
    movl -8(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -32(%ebp)
    movl -32(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 5, -36(%ebp)
    movl 2, -40(%ebp)
    pushl -40(%ebp)
    pushl -36(%ebp)
    movl -24(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 16, %esp
    pushl -24(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    movl -24(%ebp), %eax
    movl %eax, -44(%ebp)
    movl 8(%ebp), %eax
    addl _my_B_coso_string_3, %eax
    movl %eax, -52(%ebp)
    subl 4, %esp
    pushl -44(%ebp)
    pushl -52(%ebp)
    movl -8(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 16, %esp
    popl -56(%ebp)
    movl -56(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    movl -8(%ebp), %eax
    pushl %eax; pushl 104; call (%eax)
    addl 12, %esp
    jmp _07f7c73c_md_run_return
_07f7c73c_md_run_return:
    popad
    leave
    ret

// method doIt
_07f7c73c_md_doIt:
    pushl %ebp; movl %esp, %ebp
    subl 108, %esp
    pushad
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
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 8(%ebp), %eax
    addl _my_B_coso_string_3, %eax
    movl %eax, -32(%ebp)
    subl 4, %esp
    pushl -20(%ebp)
    pushl -32(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 16, %esp
    popl -36(%ebp)
    movl -36(%ebp), %eax
    movl %eax, -28(%ebp)
    movl -4(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 8(%ebp), %eax
    addl _my_B_coso_string_3, %eax
    movl %eax, -48(%ebp)
    subl 4, %esp
    pushl -40(%ebp)
    pushl -48(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 16, %esp
    popl -52(%ebp)
    movl -52(%ebp), %eax
    movl %eax, -44(%ebp)
    movl 64, -56(%ebp)
    movl 1, -60(%ebp)
    pushl -60(%ebp)
    pushl -56(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_B_coso_string_1, %eax
    movl %eax, -64(%ebp)
    pushl -8(%ebp)
    pushl -64(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    subl 4, %esp
    pushl -44(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 16; call (%eax)
    addl 12, %esp
    popl -68(%ebp)
    pushl -8(%ebp)
    pushl -68(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -72(%ebp)
    pushl -8(%ebp)
    pushl -72(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    subl 4, %esp
    pushl -28(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 16; call (%eax)
    addl 12, %esp
    popl -76(%ebp)
    pushl -8(%ebp)
    pushl -76(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 4660, -80(%ebp)
    pushl -80(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 12, %esp
    movl 64, -84(%ebp)
    movl 1, -88(%ebp)
    pushl -88(%ebp)
    pushl -84(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 10, -92(%ebp)
    pushl -8(%ebp)
    pushl -92(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -96(%ebp)
    pushl -96(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 12, %esp
    movl 16(%ebp), %eax
    movl %eax, -100(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -104(%ebp)
    subl 4, %esp
    movl -104(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 8, %esp
    popl -108(%ebp)
    pushl -108(%ebp)
    movl -100(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    jmp _07f7c73c_md_doIt_return
_07f7c73c_md_doIt_return:
    popad
    leave
    ret

// method testAllocate
_07f7c73c_md_testAllocate:
    pushl %ebp; movl %esp, %ebp
    subl 48, %esp
    pushad
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
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    subl 4, %esp
    pushl -24(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 32, -32(%ebp)
    pushl -8(%ebp)
    pushl -32(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    pushl -8(%ebp)
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    movl 32, -36(%ebp)
    pushl -8(%ebp)
    pushl -36(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 57005, -40(%ebp)
    pushl -8(%ebp)
    pushl -40(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    movl 32, -44(%ebp)
    pushl -8(%ebp)
    pushl -44(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 49374, -48(%ebp)
    pushl -8(%ebp)
    pushl -48(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    jmp _07f7c73c_md_testAllocate_return
_07f7c73c_md_testAllocate_return:
    popad
    leave
    ret

// method getRow
_07f7c73c_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
    movl -4(%ebp), %eax
    movl _my_B_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _07f7c73c_md_getRow_return
_07f7c73c_md_getRow_return:
    popad
    leave
    ret
