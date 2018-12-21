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
    .long _my_B_cno_my_B
    .long (_07f7c73c_cts - _my_B)
    .long (_07f7c73c_mts - _my_B)
    .long (_07f7c73c_tpl - _my_B)
    .long (_07f7c73c_tpl_end - _07f7c73c_tpl)
    .long (_07f7c73c_tpl_h_01a2e54e - _07f7c73c_tpl)
    .long (_07f7c73c_tpl_h_07f7c73c - _07f7c73c_tpl)

// class tab
_07f7c73c_cts:
_07f7c73c_cto_01a2e54e := (_07f7c73c_ct_01a2e54e - _my_B)
_07f7c73c_ct_01a2e54e:
    .long 0
    .long _my_B_cno_my_core_Object
    .long (_07f7c73c_mt_01a2e54e - _my_B)
    .long (_07f7c73c_tpl_h_01a2e54e - _07f7c73c_tpl)
_07f7c73c_cto_0dbda62f := (_07f7c73c_ct_0dbda62f - _my_B)
_07f7c73c_ct_0dbda62f:
    .long 0
    .long _my_B_cno_my_core_Thread
    .long (_07f7c73c_mt_0dbda62f - _my_B)
    .long (_07f7c73c_tpl_h_0dbda62f - _07f7c73c_tpl)
_07f7c73c_cto_07f7c73b := (_07f7c73c_ct_07f7c73b - _my_B)
_07f7c73c_ct_07f7c73b:
    .long 0
    .long _my_B_cno_my_A
    .long (_07f7c73c_mt_07f7c73b - _my_B)
    .long (_07f7c73c_tpl_h_07f7c73b - _07f7c73c_tpl)
_07f7c73c_cto_07f7c73c := (_07f7c73c_ct_07f7c73c - _my_B)
_07f7c73c_ct_07f7c73c:
    .long 0
    .long _my_B_cno_my_B
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
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_hash := 8
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_equals := 16
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_rt := 24
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
_my_core_Object_m_setRt := 32
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
_07f7c73c_mt_0dbda62f:
_my_core_Thread_m_getClass := 0
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_hash := 8
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_equals := 16
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_rt := 24
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_setRt := 32
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
_my_core_Thread_m_run := 40
    .long _my_B_mdo_run
    .long _07f7c73c_cto_07f7c73c
_07f7c73c_mt_07f7c73b:
_my_A_m_getClass := 0
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
_my_A_m_hash := 8
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
_my_A_m_equals := 16
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
_my_A_m_rt := 24
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
_my_A_m_setRt := 32
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
_my_A_m_init := 40
    .long _my_A_mdo_init
    .long _07f7c73c_cto_07f7c73b
_my_A_m_getRow := 48
    .long _my_B_mdo_getRow
    .long _07f7c73c_cto_07f7c73c
_my_A_m_getRowAndColumn := 56
    .long _my_A_mdo_getRowAndColumn
    .long _07f7c73c_cto_07f7c73b
_my_A_m_test := 64
    .long _my_A_mdo_test
    .long _07f7c73c_cto_07f7c73b
_07f7c73c_mt_07f7c73c:
_my_B_m_getClass := 0
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
_my_B_m_hash := 8
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
_my_B_m_equals := 16
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
_my_B_m_rt := 24
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
_my_B_m_setRt := 32
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
_my_B_m_run := 40
    .long _my_B_mdo_run
    .long _07f7c73c_cto_07f7c73c
_my_B_m_init := 48
    .long _my_A_mdo_init
    .long _07f7c73c_cto_07f7c73b
_my_B_m_getRow := 56
    .long _my_B_mdo_getRow
    .long _07f7c73c_cto_07f7c73c
_my_B_m_getRowAndColumn := 64
    .long _my_A_mdo_getRowAndColumn
    .long _07f7c73c_cto_07f7c73b
_my_B_m_test := 72
    .long _my_A_mdo_test
    .long _07f7c73c_cto_07f7c73b
_my_B_m_doIt := 80
    .long _my_B_mdo_doIt
    .long _07f7c73c_cto_07f7c73c
_my_B_m_testAllocate := 88
    .long _my_B_mdo_testAllocate
    .long _07f7c73c_cto_07f7c73c

// constants
// string doit
_my_B_coso_doit := (_07f7c73c_cos_doit - _my_B)
_07f7c73c_cos_doit:
    .asciz "OMG! Compiling work's! "

// int out
_my_B_coi_out := 0

// int err
_my_B_coi_err := 1

// class-name Object
_my_B_cno_my_core_Object := (_07f7c73c_cn_01a2e54e - _my_B)
_07f7c73c_cn_01a2e54e:
    .asciz "my::core::Object"

// class-name Thread
_my_B_cno_my_core_Thread := (_07f7c73c_cn_0dbda62f - _my_B)
_07f7c73c_cn_0dbda62f:
    .asciz "my::core::Thread"

// class-name A
_my_B_cno_my_A := (_07f7c73c_cn_07f7c73b - _my_B)
_07f7c73c_cn_07f7c73b:
    .asciz "my::A"

// class-name B
_my_B_cno_my_B := (_07f7c73c_cn_07f7c73c - _my_B)
_07f7c73c_cn_07f7c73c:
    .asciz "my::B"

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
.global _my_B_mdo_run := (_07f7c73c_md_run - _my_B)
_07f7c73c_md_run:
    pushl %ebp; movl %esp, %ebp
    
// TODO #3: inline method-indices in method-call-generation
//*/
        _my_core_Runtime_m_getClassDesc := 56
        _my_core_Runtime_m_allocate := 64
        _my_core_Runtime_m_free := 72
        _my_core_Runtime_m_printChar := 80
        _my_core_Runtime_m_printString := 88
        _my_core_Runtime_m_printInt := 96
        _my_core_Runtime_m_printHex := 104
        _my_core_Runtime_m_destroyInstance := 112
        _my_core_Runtime_m_cast := 120
        _my_core_Runtime_m_createAndRunThread := 128
        _my_core_Runtime_m_createInstance := 136
//*/            
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
            addl _my_B_cno_my_A, %eax   // "/my/A"
            subl 4, %esp  # return value of createInstance
            pushl %eax
            pushl %edi; pushl _my_core_Runtime_m_createInstance; call (%edi)
        	addl 12, %esp
            popl %edx; // inst_A (type A)
            
            pushl 5
            pushl 2
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
    
    leave
    ret

// method doIt
.global _my_B_mdo_doIt := (_07f7c73c_md_doIt - _my_B)
_07f7c73c_md_doIt:
    pushl %ebp; movl %esp, %ebp
    
            pushl %ecx
            pushl %edx
            
            movl 12(%ebp), %ecx // @this (Type B)
            
            subl 4, %esp        // return value of rt
            pushl %ecx; pushl _my_B_m_rt; call (%ecx)
        	addl 8, %esp
            popl %edx           // Runtime(Type Runtime)
            
            pushl 0x40; pushl _my_B_coi_err // '@'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            movl 8(%ebp), %eax         // @class-desc "B"
            addl _my_B_coso_doit, %eax // "DoIt "
            pushl %eax; pushl _my_B_coi_out
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of equals
            pushl 12(%ebp)  // @this (Type B)
            pushl %ecx; pushl _my_B_m_equals; call (%ecx)
            addl 12, %esp
            popl %eax
            
            pushl %eax; pushl _my_B_coi_out
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_B_coi_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of equals
            pushl 16(%ebp)  // param @a (Type A)
            pushl %ecx; pushl _my_B_m_equals; call (%ecx)
            addl 12, %esp
            popl %eax
            
            pushl %eax; pushl _my_B_coi_out
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x1234    // size
            pushl %ecx; pushl _my_B_m_testAllocate; call (%ecx)
        	addl 12, %esp
            
            pushl 0x40; pushl _my_B_coi_err // '@'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl 0xa; pushl _my_B_coi_out // '/n'
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
    
    leave
    ret

// method testAllocate
.global _my_B_mdo_testAllocate := (_07f7c73c_md_testAllocate - _my_B)
_07f7c73c_md_testAllocate:
    pushl %ebp; movl %esp, %ebp
    
            pushl %ecx
            pushl %edx
            pushl %esi
            
            movl 12(%ebp), %ecx // @this (Type B)
            
            subl 4, %esp        // return value of rt
            pushl %ecx; pushl _my_B_m_rt; call (%ecx)
        	addl 8, %esp
            popl %edx           // Runtime(Type Runtime)
            
            subl 4, %esp    // return value of allocate
            pushl 16(%ebp)  // param size
            pushl %edx; pushl _my_core_Runtime_m_allocate; call (%edx)
        	addl 12, %esp
            popl %esi
            
            pushl 0x20; pushl _my_B_coi_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl %esi; pushl _my_B_coi_out
            pushl %edx; pushl _my_core_Runtime_m_printHex; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_B_coi_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl (%esi); pushl _my_B_coi_out
            pushl %edx; pushl _my_core_Runtime_m_printHex; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_B_coi_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl 4(%esi); pushl _my_B_coi_out 
            pushl %edx; pushl _my_core_Runtime_m_printHex; call (%edx)
            addl 16, %esp
            
            pushl %esi 
            pushl %edx; pushl _my_core_Runtime_m_free; call (%edx)
            addl 12, %esp
        	
            popl %esi
            popl %edx
            popl %ecx
    
    leave
    ret

// method getRow
.global _my_B_mdo_getRow := (_07f7c73c_md_getRow - _my_B)
_07f7c73c_md_getRow:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax             // @this (Type B)
            movl _my_B_hvo_my_A(%eax), %ebx // inst vars offset (A)
            addl 4(%eax), %ebx              // @this.vars(A)
            
            movl _my_A_i_row(%ebx), %eax    // row
            addl %eax, %eax                 // *2
            movl %eax, 16(%ebp)             // return row*2
    
    leave
    ret
