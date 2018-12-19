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
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
_07f7c73c_mt_0dbda62f:
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
    .long _my_B_mdo_run
    .long _07f7c73c_cto_07f7c73c
_07f7c73c_mt_07f7c73b:
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
    .long _my_A_mdo_init
    .long _07f7c73c_cto_07f7c73b
    .long _my_B_mdo_getRow
    .long _07f7c73c_cto_07f7c73c
    .long _my_A_mdo_getRowAndColumn
    .long _07f7c73c_cto_07f7c73b
    .long _my_A_mdo_test
    .long _07f7c73c_cto_07f7c73b
_07f7c73c_mt_07f7c73c:
.global _my_B_m_getClass := (_07f7c73c_mtm_07f7c73c_getClass - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_getClass:
    .long _my_core_Object_mdo_getClass
    .long _07f7c73c_cto_01a2e54e
.global _my_B_m_hash := (_07f7c73c_mtm_07f7c73c_hash - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_hash:
    .long _my_core_Object_mdo_hash
    .long _07f7c73c_cto_01a2e54e
.global _my_B_m_equals := (_07f7c73c_mtm_07f7c73c_equals - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_equals:
    .long _my_core_Object_mdo_equals
    .long _07f7c73c_cto_01a2e54e
.global _my_B_m_rt := (_07f7c73c_mtm_07f7c73c_rt - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_rt:
    .long _my_core_Object_mdo_rt
    .long _07f7c73c_cto_01a2e54e
.global _my_B_m_setRt := (_07f7c73c_mtm_07f7c73c_setRt - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_setRt:
    .long _my_core_Object_mdo_setRt
    .long _07f7c73c_cto_01a2e54e
.global _my_B_m_run := (_07f7c73c_mtm_07f7c73c_run - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_run:
    .long _my_B_mdo_run
    .long _07f7c73c_cto_07f7c73c
.global _my_B_m_init := (_07f7c73c_mtm_07f7c73c_init - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_init:
    .long _my_A_mdo_init
    .long _07f7c73c_cto_07f7c73b
.global _my_B_m_getRow := (_07f7c73c_mtm_07f7c73c_getRow - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_getRow:
    .long _my_B_mdo_getRow
    .long _07f7c73c_cto_07f7c73c
.global _my_B_m_getRowAndColumn := (_07f7c73c_mtm_07f7c73c_getRowAndColumn - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_getRowAndColumn:
    .long _my_A_mdo_getRowAndColumn
    .long _07f7c73c_cto_07f7c73b
.global _my_B_m_test := (_07f7c73c_mtm_07f7c73c_test - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_test:
    .long _my_A_mdo_test
    .long _07f7c73c_cto_07f7c73b
.global _my_B_m_doIt := (_07f7c73c_mtm_07f7c73c_doIt - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_doIt:
    .long _my_B_mdo_doIt
    .long _07f7c73c_cto_07f7c73c
.global _my_B_m_testAllocate := (_07f7c73c_mtm_07f7c73c_testAllocate - _07f7c73c_mt_07f7c73c)
_07f7c73c_mtm_07f7c73c_testAllocate:
    .long _my_B_mdo_testAllocate
    .long _07f7c73c_cto_07f7c73c

// constants
// string doit
_my_B_coso_doit := (_07f7c73c_cos_doit - _my_B)
_07f7c73c_cos_doit:
    .asciz "OMG! Compiling work's! "

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
    .long 0
_07f7c73c_tpl_vs_0dbda62f:
_07f7c73c_tpl_vs_07f7c73b:
// variable column
    .long 0
// variable row
    .long 0
_07f7c73c_tpl_vs_07f7c73c:
_07f7c73c_tpl_end:

// method definitions
// method run
.global _my_B_mdo_run := (_07f7c73c_md_run - _my_B)
_07f7c73c_md_run:
    pushl %ebp; movl %esp, %ebp
    
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
            
            pushl 0x40; pushl _my_core_Runtime_c_err // '@'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            movl 8(%ebp), %eax         // @class-desc "B"
            addl _my_B_coso_doit, %eax // "DoIt "
            pushl %eax; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of equals
            pushl 12(%ebp)  // @this (Type B)
            pushl %ecx; pushl _my_B_m_equals; call (%ecx)
            addl 12, %esp
            popl %eax
            
            pushl %eax; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            subl 4, %esp    // return value of equals
            pushl 16(%ebp)  // param @a (Type A)
            pushl %ecx; pushl _my_B_m_equals; call (%ecx)
            addl 12, %esp
            popl %eax
            
            pushl %eax; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x1234    // size
            pushl %ecx; pushl _my_B_m_testAllocate; call (%ecx)
        	addl 12, %esp
            
            pushl 0x40; pushl _my_core_Runtime_c_err // '@'
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl 0xa; pushl _my_core_Runtime_c_out // '/n'
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
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl %esi; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printHex; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl (%esi); pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printHex; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl 4(%esi); pushl _my_core_Runtime_c_out 
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
