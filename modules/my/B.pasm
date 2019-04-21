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
    .long 16
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
    .long 16
    .long _07f7c73c_cto_07f7c73c
    .long 8
    .long _07f7c73c_cto_07f7c73b
    .long 12
    .long _07f7c73c_cto_07f7c73b
    .long 4
    .long _07f7c73c_cto_07f7c73c
    .long 8
    .long _07f7c73c_cto_07f7c73c
    .long 12
    .long _07f7c73c_cto_07f7c73c

// methods tab
_07f7c73c_mdt:
    .long (_07f7c73c_md_run - _my_B)
    .long (_07f7c73c_md_doIt - _my_B)
    .long (_07f7c73c_md_testLoop - _my_B)
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
    subl 36, %esp
    pushad
    jmp _07f7c73c_md_run_bb_2
_07f7c73c_md_run_bb_1:
    popad
    leave
    ret
_07f7c73c_md_run_bb_2:
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 7, -12(%ebp)
    movl 20, -16(%ebp)
    pushl -16(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_B_coso_string_2, %eax
    movl %eax, -24(%ebp)
    subl 4, %esp
    pushl -24(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 5, -32(%ebp)
    movl 2, -36(%ebp)
    pushl -36(%ebp)
    pushl -32(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 40; call (%eax)
    addl 16, %esp
    pushl -20(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    pushl -20(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 104; call (%eax)
    addl 12, %esp
    jmp _07f7c73c_md_run_bb_1
_07f7c73c_md_run_bb_3:
    jmp _07f7c73c_md_run_bb_1

// method doIt
_07f7c73c_md_doIt:
    pushl %ebp; movl %esp, %ebp
    subl 68, %esp
    pushad
    jmp _07f7c73c_md_doIt_bb_2
_07f7c73c_md_doIt_bb_1:
    popad
    leave
    ret
_07f7c73c_md_doIt_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 64, -20(%ebp)
    movl 1, -24(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_B_coso_string_1, %eax
    movl %eax, -28(%ebp)
    pushl -4(%ebp)
    pushl -28(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 16, %esp
    subl 4, %esp
    pushl 12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 16; call (%eax)
    addl 12, %esp
    popl -32(%ebp)
    pushl -4(%ebp)
    pushl -32(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -36(%ebp)
    pushl -4(%ebp)
    pushl -36(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    subl 4, %esp
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 16; call (%eax)
    addl 12, %esp
    popl -40(%ebp)
    pushl -4(%ebp)
    pushl -40(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 4660, -44(%ebp)
    pushl -44(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 12, %esp
    movl 64, -48(%ebp)
    movl 1, -52(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 10, -56(%ebp)
    pushl -4(%ebp)
    pushl -56(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 4, -60(%ebp)
    pushl -60(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 12, %esp
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -64(%ebp)
    pushl -64(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 12, %esp
    subl 4, %esp
    movl 16(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 8, %esp
    popl -68(%ebp)
    pushl -68(%ebp)
    movl 16(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    jmp _07f7c73c_md_doIt_bb_1
_07f7c73c_md_doIt_bb_3:
    jmp _07f7c73c_md_doIt_bb_1

// method testLoop
_07f7c73c_md_testLoop:
    pushl %ebp; movl %esp, %ebp
    subl 96, %esp
    pushad
    movl 1, -28(%ebp)
    movl 0, -32(%ebp)
    jmp _07f7c73c_md_testLoop_bb_2
_07f7c73c_md_testLoop_bb_1:
    popad
    leave
    ret
_07f7c73c_md_testLoop_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -20(%ebp)
    jmp _07f7c73c_md_testLoop_bb_5
_07f7c73c_md_testLoop_bb_3:
    jmp _07f7c73c_md_testLoop_bb_1
_07f7c73c_md_testLoop_bb_4:
    movl 16(%ebp), %eax
    movl %eax, -36(%ebp)
    jmp _07f7c73c_md_testLoop_bb_8
_07f7c73c_md_testLoop_bb_5:
    movl -20(%ebp), %eax
    movl %eax, -24(%ebp)
    movl -24(%ebp), %eax
    subl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    movl -24(%ebp), %eax
    cmpl -32(%ebp), %eax
    jne _07f7c73c_md_testLoop_bb_4
    jmp _07f7c73c_md_testLoop_bb_3
_07f7c73c_md_testLoop_bb_6:
    movl 10, -96(%ebp)
    pushl -4(%ebp)
    pushl -96(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    jmp _07f7c73c_md_testLoop_bb_5
_07f7c73c_md_testLoop_bb_7:
    movl 10, -44(%ebp)
    movl 16(%ebp), %eax
    cmpl -44(%ebp), %eax
    jge _07f7c73c_md_testLoop_bb_10
    jmp _07f7c73c_md_testLoop_bb_11
_07f7c73c_md_testLoop_bb_8:
    movl -36(%ebp), %eax
    movl %eax, -40(%ebp)
    movl -40(%ebp), %eax
    subl -28(%ebp), %eax
    movl %eax, -36(%ebp)
    movl -40(%ebp), %eax
    cmpl -32(%ebp), %eax
    jne _07f7c73c_md_testLoop_bb_7
    jmp _07f7c73c_md_testLoop_bb_6
_07f7c73c_md_testLoop_bb_9:
    pushl -4(%ebp)
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl 32, -84(%ebp)
    pushl -4(%ebp)
    pushl -84(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    pushl -4(%ebp)
    pushl -36(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 16, %esp
    movl -36(%ebp), %eax
    cmpl -32(%ebp), %eax
    jne _07f7c73c_md_testLoop_bb_23
    jmp _07f7c73c_md_testLoop_bb_24
_07f7c73c_md_testLoop_bb_10:
    movl -20(%ebp), %eax
    cmpl -36(%ebp), %eax
    je _07f7c73c_md_testLoop_bb_13
    jmp _07f7c73c_md_testLoop_bb_15
_07f7c73c_md_testLoop_bb_11:
    movl -20(%ebp), %eax
    cmpl -36(%ebp), %eax
    jle _07f7c73c_md_testLoop_bb_20
    jmp _07f7c73c_md_testLoop_bb_21
_07f7c73c_md_testLoop_bb_12:
    movl 10, -68(%ebp)
    movl -20(%ebp), %eax
    cmpl -68(%ebp), %eax
    jlt _07f7c73c_md_testLoop_bb_17
    jmp _07f7c73c_md_testLoop_bb_18
_07f7c73c_md_testLoop_bb_13:
    movl 1, -60(%ebp)
    movl -60(%ebp), %eax
    movl %eax, -4(%ebp)
    jmp _07f7c73c_md_testLoop_bb_12
_07f7c73c_md_testLoop_bb_14:
    movl 0, -64(%ebp)
    movl -64(%ebp), %eax
    movl %eax, -4(%ebp)
    jmp _07f7c73c_md_testLoop_bb_12
_07f7c73c_md_testLoop_bb_15:
    movl -20(%ebp), %eax
    addl -36(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 1, -52(%ebp)
    movl 16(%ebp), %eax
    subl -52(%ebp), %eax
    movl %eax, -56(%ebp)
    movl -48(%ebp), %eax
    cmpl -56(%ebp), %eax
    je _07f7c73c_md_testLoop_bb_13
    jmp _07f7c73c_md_testLoop_bb_14
_07f7c73c_md_testLoop_bb_16:
    jmp _07f7c73c_md_testLoop_bb_9
_07f7c73c_md_testLoop_bb_17:
    movl 32, -72(%ebp)
    pushl -4(%ebp)
    pushl -72(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    jmp _07f7c73c_md_testLoop_bb_16
_07f7c73c_md_testLoop_bb_18:
    jmp _07f7c73c_md_testLoop_bb_16
_07f7c73c_md_testLoop_bb_19:
    jmp _07f7c73c_md_testLoop_bb_9
_07f7c73c_md_testLoop_bb_20:
    movl 0, -76(%ebp)
    movl -76(%ebp), %eax
    movl %eax, -4(%ebp)
    jmp _07f7c73c_md_testLoop_bb_19
_07f7c73c_md_testLoop_bb_21:
    movl 1, -80(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -4(%ebp)
    jmp _07f7c73c_md_testLoop_bb_19
_07f7c73c_md_testLoop_bb_22:
    jmp _07f7c73c_md_testLoop_bb_8
_07f7c73c_md_testLoop_bb_23:
    movl 32, -88(%ebp)
    pushl -4(%ebp)
    pushl -88(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 32, -92(%ebp)
    pushl -4(%ebp)
    pushl -92(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    jmp _07f7c73c_md_testLoop_bb_22
_07f7c73c_md_testLoop_bb_24:
    jmp _07f7c73c_md_testLoop_bb_22

// method testAllocate
_07f7c73c_md_testAllocate:
    pushl %ebp; movl %esp, %ebp
    subl 44, %esp
    pushad
    jmp _07f7c73c_md_testAllocate_bb_2
_07f7c73c_md_testAllocate_bb_1:
    popad
    leave
    ret
_07f7c73c_md_testAllocate_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 8, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    subl 4, %esp
    pushl 16(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 32, -28(%ebp)
    pushl -4(%ebp)
    pushl -28(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    pushl -4(%ebp)
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    movl 32, -32(%ebp)
    pushl -4(%ebp)
    pushl -32(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 57005, -36(%ebp)
    pushl -4(%ebp)
    pushl -36(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    movl 32, -40(%ebp)
    pushl -4(%ebp)
    pushl -40(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 16, %esp
    movl 49374, -44(%ebp)
    pushl -4(%ebp)
    pushl -44(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 16, %esp
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    jmp _07f7c73c_md_testAllocate_bb_1
_07f7c73c_md_testAllocate_bb_3:
    jmp _07f7c73c_md_testAllocate_bb_1

// method getRow
_07f7c73c_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    pushad
    jmp _07f7c73c_md_getRow_bb_2
_07f7c73c_md_getRow_bb_1:
    popad
    leave
    ret
_07f7c73c_md_getRow_bb_2:
    movl 2, -4(%ebp)
    movl 12(%ebp), %eax
    movl _my_B_hvo_my_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -4(%ebp), %eax
    movl -8(%ebp), %ebx
    .byte 0x0f; .byte 0xaf; .byte 0xc3 #//imul %ebx, %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _07f7c73c_md_getRow_bb_1
_07f7c73c_md_getRow_bb_3:
    jmp _07f7c73c_md_getRow_bb_1
