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
    .long _my_core_Object_mdo_getClass
    .long _07f7c73b_cto_01a2e54e
    .long _my_core_Object_mdo_hash
    .long _07f7c73b_cto_01a2e54e
    .long _my_core_Object_mdo_equals
    .long _07f7c73b_cto_01a2e54e
    .long _my_core_Object_mdo_rt
    .long _07f7c73b_cto_01a2e54e
    .long _my_core_Object_mdo_setRt
    .long _07f7c73b_cto_01a2e54e
_07f7c73b_mt_07f7c73b:
.global _my_A_m_getClass := (_07f7c73b_mtm_07f7c73b_getClass - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_getClass:
    .long _my_core_Object_mdo_getClass
    .long _07f7c73b_cto_01a2e54e
.global _my_A_m_hash := (_07f7c73b_mtm_07f7c73b_hash - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_hash:
    .long _my_core_Object_mdo_hash
    .long _07f7c73b_cto_01a2e54e
.global _my_A_m_equals := (_07f7c73b_mtm_07f7c73b_equals - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_equals:
    .long _my_core_Object_mdo_equals
    .long _07f7c73b_cto_01a2e54e
.global _my_A_m_rt := (_07f7c73b_mtm_07f7c73b_rt - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_rt:
    .long _my_core_Object_mdo_rt
    .long _07f7c73b_cto_01a2e54e
.global _my_A_m_setRt := (_07f7c73b_mtm_07f7c73b_setRt - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_setRt:
    .long _my_core_Object_mdo_setRt
    .long _07f7c73b_cto_01a2e54e
.global _my_A_m_init := (_07f7c73b_mtm_07f7c73b_init - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_init:
    .long _my_A_mdo_init
    .long _07f7c73b_cto_07f7c73b
.global _my_A_m_getRow := (_07f7c73b_mtm_07f7c73b_getRow - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_getRow:
    .long _my_A_mdo_getRow
    .long _07f7c73b_cto_07f7c73b
.global _my_A_m_getRowAndColumn := (_07f7c73b_mtm_07f7c73b_getRowAndColumn - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_getRowAndColumn:
    .long _my_A_mdo_getRowAndColumn
    .long _07f7c73b_cto_07f7c73b
.global _my_A_m_test := (_07f7c73b_mtm_07f7c73b_test - _07f7c73b_mt_07f7c73b)
_07f7c73b_mtm_07f7c73b_test:
    .long _my_A_mdo_test
    .long _07f7c73b_cto_07f7c73b

// constants
// string test
_my_A_coso_test := (_07f7c73b_cos_test - _my_A)
_07f7c73b_cos_test:
    .asciz " Test\n"

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
    .long 0
_07f7c73b_tpl_vs_07f7c73b:
// variable column
.global _my_A_i_column := (_07f7c73b_tpl_v_07f7c73b_column - _07f7c73b_tpl_vs_07f7c73b)
_07f7c73b_tpl_v_07f7c73b_column:
    .long 0
// variable row
.global _my_A_i_row := (_07f7c73b_tpl_v_07f7c73b_row - _07f7c73b_tpl_vs_07f7c73b)
_07f7c73b_tpl_v_07f7c73b_row:
    .long 0
_07f7c73b_tpl_end:

// method definitions
// method init
.global _my_A_mdo_init := (_07f7c73b_md_init - _my_A)
_07f7c73b_md_init:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax             // @this (Type A)
            movl _my_A_hvo_my_A(%eax), %ebx // inst vars offset (A)
            addl 4(%eax), %ebx              // @this.vars(A)
            
            movl 16(%ebp), %eax             // param row
            movl %eax, _my_A_i_row(%ebx)    // set this.row
            movl 20(%ebp), %eax             // param column
            movl %eax, _my_A_i_column(%ebx) // set this.column
    
    leave
    ret

// method getRow
.global _my_A_mdo_getRow := (_07f7c73b_md_getRow - _my_A)
_07f7c73b_md_getRow:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax             // @this (Type A)
            movl _my_A_hvo_my_A(%eax), %ebx // inst vars offset (A)
            addl 4(%eax), %ebx              // @this.vars(A)
            
            movl _my_A_i_row(%ebx), %eax    // row
            movl %eax, 16(%ebp)             // return row
    
    leave
    ret

// method getRowAndColumn
.global _my_A_mdo_getRowAndColumn := (_07f7c73b_md_getRowAndColumn - _my_A)
_07f7c73b_md_getRowAndColumn:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax             // @this (Type A)
            movl _my_A_hvo_my_A(%eax), %ebx // inst vars offset (A)
            addl 4(%eax), %ebx              // @this.vars(A)
            
            movl _my_A_i_row(%ebx), %eax    // row
            movl %eax, 20(%ebp)             // return row
            movl _my_A_i_column(%ebx), %eax // column
            movl %eax, 16(%ebp)             // return column
    
    leave
    ret

// method test
.global _my_A_mdo_test := (_07f7c73b_md_test - _my_A)
_07f7c73b_md_test:
    pushl %ebp; movl %esp, %ebp
    
            pushl %ecx
            pushl %edx
            
            movl 12(%ebp), %ecx // @this (Type A)
            
            subl 4, %esp    // return value of rt
            pushl %ecx; pushl _my_A_m_rt; call (%ecx)
        	addl 8, %esp
            popl %edx       // Runtime (Type Runtime)
            
            subl 4, %esp    // return value of getClass
            pushl %ecx; pushl _my_A_m_getClass; call (%ecx)
        	addl 8, %esp
            popl %eax       // Class instance ("A"|"B") (Type Class)
/*
            subl 4, %esp    // return value of getClass
            pushl %eax; pushl _my_core_Class_m_getClass; call (%eax)
        	addl 8, %esp
            popl %eax       // Class instance "Class" (Type Class)
*/
            subl 4, %esp    // return value of getName
            pushl %eax; pushl _my_core_Class_m_getName; call (%eax)
        	addl 8, %esp
            popl %eax       // name cstring ref
            
            pushl %eax; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            movl _my_A_hvo_my_A(%ecx), %ebx     // inst vars offset (A)
            addl 4(%ecx), %ebx                  // @this.vars(A)
            push _my_A_i_column(%ebx); pushl _my_core_Runtime_c_out // column
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl 16(%ebp); pushl _my_core_Runtime_c_out // param row
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            subl 8, %esp    // return values of getRowAndColumn
            pushl %ecx; pushl _my_A_m_getRowAndColumn; call (%ecx)
        	addl 8, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            popl %eax       // column from getRowAndColumn
            pushl %eax; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl 0x20; pushl _my_core_Runtime_c_out // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            popl %eax       // row from getRowAndColumn
            pushl %eax; pushl _my_core_Runtime_c_out
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            movl 8(%ebp), %eax      // @class-desc "A"
            addl _my_A_coso_test, %eax
            pushl %eax; pushl _my_core_Runtime_c_err
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            popl %edx
            popl %ecx
    
    leave
    ret
