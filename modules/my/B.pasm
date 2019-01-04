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
    .long _my_B_coso_mA
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
_my_core_Object_m_getClass := 0
    .long 0
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_hash := 8
    .long 4
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_equals := 16
    .long 8
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_rt := 24
    .long 12
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_setRt := 32
    .long 16
    .long _07f7c73c_cto_01a2e54e
_07f7c73c_mt_0dbda62f:
_my_core_Thread_m_getClass := 0
    .long 0
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_hash := 8
    .long 4
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_equals := 16
    .long 8
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_rt := 24
    .long 12
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_setRt := 32
    .long 16
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_run := 40
    .long 0
    .long _07f7c73c_cto_07f7c73c
_07f7c73c_mt_07f7c73b:
_my_A_m_getClass := 0
    .long 0
    .long _07f7c73c_cto_01a2e54e
_my_A_m_hash := 8
    .long 4
    .long _07f7c73c_cto_01a2e54e
_my_A_m_equals := 16
    .long 8
    .long _07f7c73c_cto_01a2e54e
_my_A_m_rt := 24
    .long 12
    .long _07f7c73c_cto_01a2e54e
_my_A_m_setRt := 32
    .long 16
    .long _07f7c73c_cto_01a2e54e
_my_A_m_init := 40
    .long 0
    .long _07f7c73c_cto_07f7c73b
_my_A_m_getRow := 48
    .long 12
    .long _07f7c73c_cto_07f7c73c
_my_A_m_getRowAndColumn := 56
    .long 8
    .long _07f7c73c_cto_07f7c73b
_my_A_m_test := 64
    .long 12
    .long _07f7c73c_cto_07f7c73b
_07f7c73c_mt_07f7c73c:
_my_B_m_getClass := 0
    .long 0
    .long _07f7c73c_cto_01a2e54e
_my_B_m_hash := 8
    .long 4
    .long _07f7c73c_cto_01a2e54e
_my_B_m_equals := 16
    .long 8
    .long _07f7c73c_cto_01a2e54e
_my_B_m_rt := 24
    .long 12
    .long _07f7c73c_cto_01a2e54e
_my_B_m_setRt := 32
    .long 16
    .long _07f7c73c_cto_01a2e54e
_my_B_m_run := 40
    .long 0
    .long _07f7c73c_cto_07f7c73c
_my_B_m_init := 48
    .long 0
    .long _07f7c73c_cto_07f7c73b
_my_B_m_getRow := 56
    .long 12
    .long _07f7c73c_cto_07f7c73c
_my_B_m_getRowAndColumn := 64
    .long 8
    .long _07f7c73c_cto_07f7c73b
_my_B_m_test := 72
    .long 12
    .long _07f7c73c_cto_07f7c73b
_my_B_m_doIt := 80
    .long 4
    .long _07f7c73c_cto_07f7c73c
_my_B_m_testAllocate := 88
    .long 8
    .long _07f7c73c_cto_07f7c73c

// methods tab
_07f7c73c_mdt:
_my_B_mdo_run := (_07f7c73c_md_run - _my_B)
    .long _my_B_mdo_run
_my_B_mdo_doIt := (_07f7c73c_md_doIt - _my_B)
    .long _my_B_mdo_doIt
_my_B_mdo_testAllocate := (_07f7c73c_md_testAllocate - _my_B)
    .long _my_B_mdo_testAllocate
_my_B_mdo_getRow := (_07f7c73c_md_getRow - _my_B)
    .long _my_B_mdo_getRow

// constants
// int out
_my_B_coi_out := 0

// int err
_my_B_coi_err := 1

// string doit
_my_B_coso_doit := (_07f7c73c_cos_doit - _my_B)
_07f7c73c_cos_doit:
    .asciz "OMG! Compiling still work's! "

// string mA
_my_B_coso_mA := (_07f7c73c_cos_mA - _my_B)
_07f7c73c_cos_mA:
    .asciz "my::A"

// string CLASSNAME
_my_B_coso_CLASSNAME := (_07f7c73c_cos_CLASSNAME - _my_B)
_07f7c73c_cos_CLASSNAME:
    .asciz "my::B"

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
    subl 4, %esp
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
        _my_core_Runtime_m_destroyInstance := 104
        _my_core_Runtime_m_cast := 112
        _my_core_Runtime_m_createInstance := 128
            pushl %ecx
            pushl %edx
            pushl %edi
            
            movl 12(%ebp), %ecx // @this (Type B)
            
            subl 4, %esp        // return value of rt
            pushl %ecx; pushl _my_B_m_rt; call (%ecx)
        	addl 8, %esp
            popl %edi           // Runtime(Type Runtime)
            
            pushl 20
            pushl 2
            pushl %ecx; pushl _my_B_m_init; call (%ecx)
        	addl 16, %esp
        	
            movl 8(%ebp), %eax          // @class-desc "B"
            addl _my_B_coso_mA, %eax   // "my::A"
            subl 4, %esp    // return value of createInstance
            pushl %eax
            pushl %edi; pushl _my_core_Runtime_m_createInstance; call (%edi)
        	addl 12, %esp
            popl %edx; // inst_A (type A)
            
            pushl 2
            pushl 5
            pushl %edx; pushl _my_A_m_init; call (%edx)
        	addl 16, %esp
            
            pushl %edx    
            pushl %ecx; pushl _my_B_m_doIt; call (%ecx)
        	addl 12, %esp
            
            pushl %edx
            pushl %edi; pushl _my_core_Runtime_m_destroyInstance; call (%edi)
        	addl 12, %esp
            
            popl %edi
            popl %edx
            popl %ecx
_07f7c73c_md_run_return:
    leave
    ret

// method doIt
_07f7c73c_md_doIt:
    pushl %ebp; movl %esp, %ebp
    subl 4, %esp
    movl 12(%ebp), %eax
    movl %eax, -4(%ebp)
        _my_core_Runtime_m_printChar := 72
        _my_core_Runtime_m_printString := 80
        _my_core_Runtime_m_printInt := 88
        _my_core_Runtime_m_printHex := 96
            pushl %ecx
            pushl %edx
            
            movl 12(%ebp), %ecx // @this (Type B)
            
            subl 4, %esp        // return value of rt
            pushl %ecx; pushl _my_B_m_rt; call (%ecx)
        	addl 8, %esp
            popl %edx           // Runtime(Type Runtime)
            
            pushl _my_B_coi_err; pushl 0x40 // '@'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            movl 8(%ebp), %eax         // @class-desc "B"
            addl _my_B_coso_doit, %eax // "DoIt "
            pushl _my_B_coi_out; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of equals
            pushl 12(%ebp)  // @this (Type B)
            pushl %ecx; pushl _my_B_m_equals; call (%ecx)
            addl 12, %esp
            popl %eax
            
            pushl _my_B_coi_out; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl _my_B_coi_out; pushl 0x20 // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of equals
            pushl 16(%ebp)  // param @a (Type A)
            pushl %ecx; pushl _my_B_m_equals; call (%ecx)
            addl 12, %esp
            popl %eax
            
            pushl _my_B_coi_out; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x1234    // size
            pushl %ecx; pushl _my_B_m_testAllocate; call (%ecx)
        	addl 12, %esp
            
            pushl _my_B_coi_err; pushl 0x40 // '@'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl _my_B_coi_out; pushl 0xa // '/n'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of getRow
            pushl %ecx; pushl _my_B_m_getRow; call (%ecx)
        	addl 8, %esp
            popl %eax
            
            pushl %eax      // row
            pushl %ecx; pushl _my_B_m_test; call (%ecx)
        	addl 12, %esp
            
            movl 16(%ebp), %ecx // param @a (Type A)
        	
            subl 4, %esp    // return value of getRow
            pushl %ecx; pushl _my_A_m_getRow; call (%ecx)
        	addl 8, %esp
            popl %eax
            
            pushl %eax      // row
            pushl %ecx; pushl _my_A_m_test; call (%ecx)
        	addl 12, %esp
        	
            popl %edx
            popl %ecx
_07f7c73c_md_doIt_return:
    leave
    ret

// method testAllocate
_07f7c73c_md_testAllocate:
    pushl %ebp; movl %esp, %ebp
    subl 48, %esp
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
    leave
    ret

// method getRow
_07f7c73c_md_getRow:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
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
    leave
    ret
