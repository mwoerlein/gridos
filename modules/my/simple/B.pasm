/*[meta]
mimetype = text/x-pasm
description = class "my::simple::B"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::simple::B
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class B
_my_simple_B:
    .long 0x15AC1A55
    .long 0
    .long _my_simple_B_coso_CLASSNAME
    .long (_1e73907a_cts - _my_simple_B)
    .long (_1e73907a_mts - _my_simple_B)
    .long (_1e73907a_mdt - _my_simple_B)
    .long (_1e73907a_tpl - _my_simple_B)
    .long (_1e73907a_tpl_end - _1e73907a_tpl)
    .long (_1e73907a_tpl_h_01a2e54e - _1e73907a_tpl)
    .long (_1e73907a_tpl_h_1e73907a - _1e73907a_tpl)

// class tab
_1e73907a_cts:
_1e73907a_cto_01a2e54e := (_1e73907a_ct_01a2e54e - _my_simple_B)
_1e73907a_ct_01a2e54e:
    .long 0
    .long _my_simple_B_coso_string_4
    .long (_1e73907a_mt_01a2e54e - _my_simple_B)
    .long (_1e73907a_tpl_h_01a2e54e - _1e73907a_tpl)
_1e73907a_cto_0dbda62f := (_1e73907a_ct_0dbda62f - _my_simple_B)
_1e73907a_ct_0dbda62f:
    .long 0
    .long _my_simple_B_coso_string_5
    .long (_1e73907a_mt_0dbda62f - _my_simple_B)
    .long (_1e73907a_tpl_h_0dbda62f - _1e73907a_tpl)
_1e73907a_cto_1e739079 := (_1e73907a_ct_1e739079 - _my_simple_B)
_1e73907a_ct_1e739079:
    .long 0
    .long _my_simple_B_coso_string_3
    .long (_1e73907a_mt_1e739079 - _my_simple_B)
    .long (_1e73907a_tpl_h_1e739079 - _1e73907a_tpl)
_1e73907a_cto_1e73907a := (_1e73907a_ct_1e73907a - _my_simple_B)
_1e73907a_ct_1e73907a:
    .long 0
    .long _my_simple_B_coso_CLASSNAME
    .long (_1e73907a_mt_1e73907a - _my_simple_B)
    .long (_1e73907a_tpl_h_1e73907a - _1e73907a_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_1e73907a_mts:
_1e73907a_mt_01a2e54e:
    .long 0
    .long _1e73907a_cto_01a2e54e
    .long 4
    .long _1e73907a_cto_01a2e54e
    .long 8
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_1e73907a
    .long 16
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_01a2e54e
_1e73907a_mt_0dbda62f:
    .long 0
    .long _1e73907a_cto_01a2e54e
    .long 4
    .long _1e73907a_cto_01a2e54e
    .long 8
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_1e73907a
    .long 16
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_01a2e54e
    .long 0
    .long _1e73907a_cto_1e73907a
_1e73907a_mt_1e739079:
    .long 0
    .long _1e73907a_cto_01a2e54e
    .long 4
    .long _1e73907a_cto_01a2e54e
    .long 8
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_1e73907a
    .long 16
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_01a2e54e
    .long 0
    .long _1e73907a_cto_1e739079
    .long 16
    .long _1e73907a_cto_1e73907a
    .long 8
    .long _1e73907a_cto_1e739079
    .long 12
    .long _1e73907a_cto_1e739079
_1e73907a_mt_1e73907a:
    .long 0
    .long _1e73907a_cto_01a2e54e
    .long 4
    .long _1e73907a_cto_01a2e54e
    .long 8
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_1e73907a
    .long 16
    .long _1e73907a_cto_01a2e54e
    .long 20
    .long _1e73907a_cto_01a2e54e
    .long 0
    .long _1e73907a_cto_1e73907a
    .long 0
    .long _1e73907a_cto_1e739079
    .long 16
    .long _1e73907a_cto_1e73907a
    .long 8
    .long _1e73907a_cto_1e739079
    .long 12
    .long _1e73907a_cto_1e739079
    .long 4
    .long _1e73907a_cto_1e73907a
    .long 8
    .long _1e73907a_cto_1e73907a
    .long 12
    .long _1e73907a_cto_1e73907a

// methods tab
_1e73907a_mdt:
    .long (_1e73907a_md_run - _my_simple_B)
    .long (_1e73907a_md_doIt - _my_simple_B)
    .long (_1e73907a_md_testLoop - _my_simple_B)
    .long (_1e73907a_md_testAllocate - _my_simple_B)
    .long (_1e73907a_md_getRow - _my_simple_B)
    .long (_1e73907a_md_printToStream - _my_simple_B)

// constants
// string CLASSNAME
_my_simple_B_coso_CLASSNAME := (_1e73907a_cos_CLASSNAME - _my_simple_B)
_1e73907a_cos_CLASSNAME:
    .asciz "my::simple::B"

// string string_1
_my_simple_B_coso_string_1 := (_1e73907a_cos_string_1 - _my_simple_B)
_1e73907a_cos_string_1:
    .asciz "OMG!! "

// string string_2
_my_simple_B_coso_string_2 := (_1e73907a_cos_string_2 - _my_simple_B)
_1e73907a_cos_string_2:
    .asciz "I-am-B"

// string string_3
_my_simple_B_coso_string_3 := (_1e73907a_cos_string_3 - _my_simple_B)
_1e73907a_cos_string_3:
    .asciz "my::simple::A"

// string string_4
_my_simple_B_coso_string_4 := (_1e73907a_cos_string_4 - _my_simple_B)
_1e73907a_cos_string_4:
    .asciz "my::core::Object"

// string string_5
_my_simple_B_coso_string_5 := (_1e73907a_cos_string_5 - _my_simple_B)
_1e73907a_cos_string_5:
    .asciz "my::core::Thread"

// instance template
_1e73907a_tpl:
    .long 0
    .long 0
_1e73907a_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_1e73907a_tpl_vs_01a2e54e - _1e73907a_tpl)
_1e73907a_tpl_h_0dbda62f:
    .long 0
    .long 0
    .long 0
    .long (_1e73907a_tpl_vs_01a2e54e - _1e73907a_tpl)
    .long (_1e73907a_tpl_vs_0dbda62f - _1e73907a_tpl)
_1e73907a_tpl_h_1e739079:
    .long 0
    .long 0
    .long 0
    .long (_1e73907a_tpl_vs_01a2e54e - _1e73907a_tpl)
    .long (_1e73907a_tpl_vs_1e739079 - _1e73907a_tpl)
_1e73907a_tpl_h_1e73907a:
    .long 0
    .long 0
    .long 0
_my_simple_B_hvo_my_core_Object := (_1e73907a_tpl_hv_01a2e54e - _1e73907a_tpl_h_1e73907a)
_1e73907a_tpl_hv_01a2e54e:
    .long (_1e73907a_tpl_vs_01a2e54e - _1e73907a_tpl)
_my_simple_B_hvo_my_core_Thread := (_1e73907a_tpl_hv_0dbda62f - _1e73907a_tpl_h_1e73907a)
_1e73907a_tpl_hv_0dbda62f:
    .long (_1e73907a_tpl_vs_0dbda62f - _1e73907a_tpl)
_my_simple_B_hvo_my_simple_A := (_1e73907a_tpl_hv_1e739079 - _1e73907a_tpl_h_1e73907a)
_1e73907a_tpl_hv_1e739079:
    .long (_1e73907a_tpl_vs_1e739079 - _1e73907a_tpl)
_my_simple_B_hvo_my_simple_B := (_1e73907a_tpl_hv_1e73907a - _1e73907a_tpl_h_1e73907a)
_1e73907a_tpl_hv_1e73907a:
    .long (_1e73907a_tpl_vs_1e73907a - _1e73907a_tpl)
_1e73907a_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_1e73907a_tpl_v_01a2e54e_runtime - _1e73907a_tpl_vs_01a2e54e)
_1e73907a_tpl_v_01a2e54e_runtime:
    .long 0
_1e73907a_tpl_vs_0dbda62f:
_1e73907a_tpl_vs_1e739079:
// variable column
_my_simple_A_i_column := (_1e73907a_tpl_v_1e739079_column - _1e73907a_tpl_vs_1e739079)
_1e73907a_tpl_v_1e739079_column:
    .long 0
// variable row
_my_simple_A_i_row := (_1e73907a_tpl_v_1e739079_row - _1e73907a_tpl_vs_1e739079)
_1e73907a_tpl_v_1e739079_row:
    .long 0
_1e73907a_tpl_vs_1e73907a:
_1e73907a_tpl_end:

// method definitions
// method run
_1e73907a_md_run:
    pushl %ebp; movl %esp, %ebp
    subl 36, %esp
    pushad
    jmp _1e73907a_md_run_bb_2
_1e73907a_md_run_bb_1:
    popad
    leave
    ret
_1e73907a_md_run_bb_2:
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 8, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 7, -12(%ebp)
    movl 20, -16(%ebp)
    pushl -16(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 16, %esp
    movl 8(%ebp), %eax
    addl _my_simple_B_coso_string_3, %eax
    movl %eax, -24(%ebp)
    subl 4, %esp
    pushl -24(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 12, %esp
    popl -28(%ebp)
    movl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 5, -32(%ebp)
    movl 2, -36(%ebp)
    pushl -36(%ebp)
    pushl -32(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 16, %esp
    pushl -20(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 12, %esp
    pushl -20(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 12, %esp
    jmp _1e73907a_md_run_bb_1
_1e73907a_md_run_bb_3:
    jmp _1e73907a_md_run_bb_1

// method doIt
_1e73907a_md_doIt:
    pushl %ebp; movl %esp, %ebp
    subl 92, %esp
    pushad
    jmp _1e73907a_md_doIt_bb_2
_1e73907a_md_doIt_bb_1:
    popad
    leave
    ret
_1e73907a_md_doIt_bb_2:
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
    movl -4(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 8, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, -20(%ebp)
    movl 64, -28(%ebp)
    subl 4, %esp
    pushl -28(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -32(%ebp)
    movl 8(%ebp), %eax
    addl _my_simple_B_coso_string_1, %eax
    movl %eax, -36(%ebp)
    subl 4, %esp
    pushl -36(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    popl -40(%ebp)
    subl 4, %esp
    pushl 12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 16; call (%eax)
    addl 12, %esp
    popl -44(%ebp)
    subl 4, %esp
    pushl -44(%ebp)
    movl -12(%ebp), %eax
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
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 16; call (%eax)
    addl 12, %esp
    popl -60(%ebp)
    subl 4, %esp
    pushl -60(%ebp)
    movl -56(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -64(%ebp)
    movl 4660, -68(%ebp)
    pushl -68(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 104; call (%eax)
    addl 12, %esp
    movl 64, -72(%ebp)
    subl 4, %esp
    pushl -72(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -76(%ebp)
    subl 4, %esp
    movl -76(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 8, %esp
    popl -80(%ebp)
    movl 4, -84(%ebp)
    pushl -84(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 12, %esp
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -88(%ebp)
    pushl -88(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    subl 4, %esp
    movl 16(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 8, %esp
    popl -92(%ebp)
    pushl -92(%ebp)
    movl 16(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 12, %esp
    jmp _1e73907a_md_doIt_bb_1
_1e73907a_md_doIt_bb_3:
    jmp _1e73907a_md_doIt_bb_1

// method testLoop
_1e73907a_md_testLoop:
    pushl %ebp; movl %esp, %ebp
    subl 120, %esp
    pushad
    movl 1, -28(%ebp)
    movl 0, -32(%ebp)
    jmp _1e73907a_md_testLoop_bb_2
_1e73907a_md_testLoop_bb_1:
    popad
    leave
    ret
_1e73907a_md_testLoop_bb_2:
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
    movl 16(%ebp), %eax
    movl %eax, -20(%ebp)
    jmp _1e73907a_md_testLoop_bb_5
_1e73907a_md_testLoop_bb_3:
    jmp _1e73907a_md_testLoop_bb_1
_1e73907a_md_testLoop_bb_4:
    movl 16(%ebp), %eax
    movl %eax, -36(%ebp)
    jmp _1e73907a_md_testLoop_bb_8
_1e73907a_md_testLoop_bb_5:
    movl -20(%ebp), %eax
    movl %eax, -24(%ebp)
    movl -24(%ebp), %eax
    subl -28(%ebp), %eax
    movl %eax, -20(%ebp)
    movl -24(%ebp), %eax
    cmpl -32(%ebp), %eax
    jne _1e73907a_md_testLoop_bb_4
    jmp _1e73907a_md_testLoop_bb_3
_1e73907a_md_testLoop_bb_6:
    subl 4, %esp
    movl -12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 8, %esp
    popl -120(%ebp)
    jmp _1e73907a_md_testLoop_bb_5
_1e73907a_md_testLoop_bb_7:
    movl 10, -44(%ebp)
    movl 16(%ebp), %eax
    cmpl -44(%ebp), %eax
    jge _1e73907a_md_testLoop_bb_10
    jmp _1e73907a_md_testLoop_bb_11
_1e73907a_md_testLoop_bb_8:
    movl -36(%ebp), %eax
    movl %eax, -40(%ebp)
    movl -40(%ebp), %eax
    subl -28(%ebp), %eax
    movl %eax, -36(%ebp)
    movl -40(%ebp), %eax
    cmpl -32(%ebp), %eax
    jne _1e73907a_md_testLoop_bb_7
    jmp _1e73907a_md_testLoop_bb_6
_1e73907a_md_testLoop_bb_9:
    subl 4, %esp
    pushl -20(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -88(%ebp)
    movl 32, -92(%ebp)
    subl 4, %esp
    pushl -92(%ebp)
    movl -88(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -96(%ebp)
    subl 4, %esp
    pushl -36(%ebp)
    movl -96(%ebp), %eax
    pushl %eax; pushl 56; call (%eax)
    addl 12, %esp
    popl -100(%ebp)
    movl -36(%ebp), %eax
    cmpl -32(%ebp), %eax
    jne _1e73907a_md_testLoop_bb_23
    jmp _1e73907a_md_testLoop_bb_24
_1e73907a_md_testLoop_bb_10:
    movl -20(%ebp), %eax
    cmpl -36(%ebp), %eax
    je _1e73907a_md_testLoop_bb_13
    jmp _1e73907a_md_testLoop_bb_15
_1e73907a_md_testLoop_bb_11:
    movl -20(%ebp), %eax
    cmpl -36(%ebp), %eax
    jle _1e73907a_md_testLoop_bb_20
    jmp _1e73907a_md_testLoop_bb_21
_1e73907a_md_testLoop_bb_12:
    movl 10, -68(%ebp)
    movl -20(%ebp), %eax
    cmpl -68(%ebp), %eax
    jlt _1e73907a_md_testLoop_bb_17
    jmp _1e73907a_md_testLoop_bb_18
_1e73907a_md_testLoop_bb_13:
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 8, %esp
    popl -60(%ebp)
    movl -60(%ebp), %eax
    movl %eax, -12(%ebp)
    jmp _1e73907a_md_testLoop_bb_12
_1e73907a_md_testLoop_bb_14:
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -64(%ebp)
    movl -64(%ebp), %eax
    movl %eax, -12(%ebp)
    jmp _1e73907a_md_testLoop_bb_12
_1e73907a_md_testLoop_bb_15:
    movl -20(%ebp), %eax
    addl -36(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 1, -52(%ebp)
    movl 16(%ebp), %eax
    subl -52(%ebp), %eax
    movl %eax, -56(%ebp)
    movl -48(%ebp), %eax
    cmpl -56(%ebp), %eax
    je _1e73907a_md_testLoop_bb_13
    jmp _1e73907a_md_testLoop_bb_14
_1e73907a_md_testLoop_bb_16:
    jmp _1e73907a_md_testLoop_bb_9
_1e73907a_md_testLoop_bb_17:
    movl 32, -72(%ebp)
    subl 4, %esp
    pushl -72(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -76(%ebp)
    jmp _1e73907a_md_testLoop_bb_16
_1e73907a_md_testLoop_bb_18:
    jmp _1e73907a_md_testLoop_bb_16
_1e73907a_md_testLoop_bb_19:
    jmp _1e73907a_md_testLoop_bb_9
_1e73907a_md_testLoop_bb_20:
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -80(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -12(%ebp)
    jmp _1e73907a_md_testLoop_bb_19
_1e73907a_md_testLoop_bb_21:
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 8, %esp
    popl -84(%ebp)
    movl -84(%ebp), %eax
    movl %eax, -12(%ebp)
    jmp _1e73907a_md_testLoop_bb_19
_1e73907a_md_testLoop_bb_22:
    jmp _1e73907a_md_testLoop_bb_8
_1e73907a_md_testLoop_bb_23:
    movl 32, -104(%ebp)
    subl 4, %esp
    pushl -104(%ebp)
    movl -12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -108(%ebp)
    movl 32, -112(%ebp)
    subl 4, %esp
    pushl -112(%ebp)
    movl -108(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -116(%ebp)
    jmp _1e73907a_md_testLoop_bb_22
_1e73907a_md_testLoop_bb_24:
    jmp _1e73907a_md_testLoop_bb_22

// method testAllocate
_1e73907a_md_testAllocate:
    pushl %ebp; movl %esp, %ebp
    subl 64, %esp
    pushad
    jmp _1e73907a_md_testAllocate_bb_2
_1e73907a_md_testAllocate_bb_1:
    popad
    leave
    ret
_1e73907a_md_testAllocate_bb_2:
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 8, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    pushl 16(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 88; call (%eax)
    addl 12, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    subl 4, %esp
    movl -4(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 8, %esp
    popl -20(%ebp)
    movl 32, -24(%ebp)
    subl 4, %esp
    pushl -24(%ebp)
    movl -20(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -28(%ebp)
    subl 4, %esp
    pushl -12(%ebp)
    movl -28(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 12, %esp
    popl -32(%ebp)
    movl 32, -36(%ebp)
    subl 4, %esp
    pushl -36(%ebp)
    movl -32(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -40(%ebp)
    movl 57005, -44(%ebp)
    subl 4, %esp
    pushl -44(%ebp)
    movl -40(%ebp), %eax
    pushl %eax; pushl 72; call (%eax)
    addl 12, %esp
    popl -48(%ebp)
    movl 32, -52(%ebp)
    subl 4, %esp
    pushl -52(%ebp)
    movl -48(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -56(%ebp)
    movl 49374, -60(%ebp)
    subl 4, %esp
    pushl -60(%ebp)
    movl -56(%ebp), %eax
    pushl %eax; pushl 64; call (%eax)
    addl 12, %esp
    popl -64(%ebp)
    pushl -12(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 12, %esp
    jmp _1e73907a_md_testAllocate_bb_1
_1e73907a_md_testAllocate_bb_3:
    jmp _1e73907a_md_testAllocate_bb_1

// method getRow
_1e73907a_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    pushad
    jmp _1e73907a_md_getRow_bb_2
_1e73907a_md_getRow_bb_1:
    popad
    leave
    ret
_1e73907a_md_getRow_bb_2:
    movl 2, -4(%ebp)
    movl 12(%ebp), %eax
    movl _my_simple_B_hvo_my_simple_A(%eax), %ebx
    addl 4(%eax), %ebx
    movl _my_simple_A_i_row(%ebx), %eax
    movl %eax, -8(%ebp)
    movl -4(%ebp), %eax
    movl -8(%ebp), %ebx
    .byte 0x0f; .byte 0xaf; .byte 0xc3 #//imul %ebx, %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _1e73907a_md_getRow_bb_1
_1e73907a_md_getRow_bb_3:
    jmp _1e73907a_md_getRow_bb_1

// method printToStream
_1e73907a_md_printToStream:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _1e73907a_md_printToStream_bb_2
_1e73907a_md_printToStream_bb_1:
    popad
    leave
    ret
_1e73907a_md_printToStream_bb_2:
    movl 8(%ebp), %eax
    addl _my_simple_B_coso_string_2, %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    movl 16(%ebp), %eax
    pushl %eax; pushl 80; call (%eax)
    addl 12, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _1e73907a_md_printToStream_bb_1
_1e73907a_md_printToStream_bb_3:
    jmp _1e73907a_md_printToStream_bb_1
