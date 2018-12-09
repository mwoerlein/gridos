/*[meta]
mimetype = text/x-pasm
description = class "/my/A"
[pool]
version = 0.1.0
class = true
*/
// class A
_my_A:
    .long 0x15AC1A55
    .long 0
    .long _my_A_cno_my_A
    .long (_03904e05_cts - _my_A)
    .long (_03904e05_mts - _my_A)
    .long (_03904e05_tpl - _my_A)
    .long (_03904e05_tpl_end - _03904e05_tpl)
    .long (_03904e05_tpl_h_e36c4e5b - _03904e05_tpl)
    .long (_03904e05_tpl_h_03904e05 - _03904e05_tpl)

// class tab
_03904e05_cts:
_03904e05_cto_e36c4e5b := (_03904e05_ct_e36c4e5b - _my_A)
_03904e05_ct_e36c4e5b:
    .long 0
    .long _my_A_cno_my_Object
    .long (_03904e05_mt_e36c4e5b - _my_A)
    .long (_03904e05_tpl_h_e36c4e5b - _03904e05_tpl)
_03904e05_cto_03904e05 := (_03904e05_ct_03904e05 - _my_A)
_03904e05_ct_03904e05:
    .long 0
    .long _my_A_cno_my_A
    .long (_03904e05_mt_03904e05 - _my_A)
    .long (_03904e05_tpl_h_03904e05 - _03904e05_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_03904e05_mts:
_03904e05_mt_e36c4e5b:
    .long _my_Object_mdo_getClass
    .long _03904e05_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _03904e05_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _03904e05_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _03904e05_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _03904e05_cto_e36c4e5b
_03904e05_mt_03904e05:
.global _my_A_m_getClass := (_03904e05_mtm_03904e05_getClass - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_getClass:
    .long _my_Object_mdo_getClass
    .long _03904e05_cto_e36c4e5b
.global _my_A_m_hash := (_03904e05_mtm_03904e05_hash - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_hash:
    .long _my_Object_mdo_hash
    .long _03904e05_cto_e36c4e5b
.global _my_A_m_equals := (_03904e05_mtm_03904e05_equals - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_equals:
    .long _my_Object_mdo_equals
    .long _03904e05_cto_e36c4e5b
.global _my_A_m_rt := (_03904e05_mtm_03904e05_rt - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_rt:
    .long _my_Object_mdo_rt
    .long _03904e05_cto_e36c4e5b
.global _my_A_m_setRt := (_03904e05_mtm_03904e05_setRt - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_setRt:
    .long _my_Object_mdo_setRt
    .long _03904e05_cto_e36c4e5b
.global _my_A_m_init := (_03904e05_mtm_03904e05_init - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_init:
    .long _my_A_mdo_init
    .long _03904e05_cto_03904e05
.global _my_A_m_getRow := (_03904e05_mtm_03904e05_getRow - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_getRow:
    .long _my_A_mdo_getRow
    .long _03904e05_cto_03904e05
.global _my_A_m_test := (_03904e05_mtm_03904e05_test - _03904e05_mt_03904e05)
_03904e05_mtm_03904e05_test:
    .long _my_A_mdo_test
    .long _03904e05_cto_03904e05

// constants
// string test
_my_A_coso_test := (_03904e05_cos_test - _my_A)
_03904e05_cos_test:
    .asciz " Test\n"

// class-name Object
_my_A_cno_my_Object := (_03904e05_cn_e36c4e5b - _my_A)
_03904e05_cn_e36c4e5b:
    .asciz "/my/Object"

// class-name A
_my_A_cno_my_A := (_03904e05_cn_03904e05 - _my_A)
_03904e05_cn_03904e05:
    .asciz "/my/A"

// instance template
_03904e05_tpl:
    .long 0
    .long 0
_03904e05_tpl_h_e36c4e5b:
    .long 0
    .long 0
    .long 0
    .long (_03904e05_tpl_vs_e36c4e5b - _03904e05_tpl)
_03904e05_tpl_h_03904e05:
    .long 0
    .long 0
    .long 0
_my_A_hvo_my_Object := (_03904e05_tpl_hv_e36c4e5b - _03904e05_tpl_h_03904e05)
_03904e05_tpl_hv_e36c4e5b:
    .long (_03904e05_tpl_vs_e36c4e5b - _03904e05_tpl)
_my_A_hvo_my_A := (_03904e05_tpl_hv_03904e05 - _03904e05_tpl_h_03904e05)
_03904e05_tpl_hv_03904e05:
    .long (_03904e05_tpl_vs_03904e05 - _03904e05_tpl)
_03904e05_tpl_vs_e36c4e5b:
// variable runtime
    .long 0
_03904e05_tpl_vs_03904e05:
// variable column
.global _my_A_i_column := (_03904e05_tpl_v_03904e05_column - _03904e05_tpl_vs_03904e05)
_03904e05_tpl_v_03904e05_column:
    .long 0
// variable row
.global _my_A_i_row := (_03904e05_tpl_v_03904e05_row - _03904e05_tpl_vs_03904e05)
_03904e05_tpl_v_03904e05_row:
    .long 0
_03904e05_tpl_end:

// method definitions
// method init
.global _my_A_mdo_init := (_03904e05_md_init - _my_A)
_03904e05_md_init:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax               // @this (Type A)
    movl _my_A_hvo_my_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl 16(%esp), %eax         // param row
    movl %eax, _my_A_i_row(%ebx)    // set this.row
    movl 20(%esp), %eax         // param column
    movl %eax, _my_A_i_column(%ebx) // set this.column
    
    leave
    ret

// method getRow
.global _my_A_mdo_getRow := (_03904e05_md_getRow - _my_A)
_03904e05_md_getRow:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax               // @this (Type A)
    movl _my_A_hvo_my_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl _my_A_i_row(%ebx), %eax // row
    movl %eax, 16(%ebp)      // return row
    
    leave
    ret

// method test
.global _my_A_mdo_test := (_03904e05_md_test - _my_A)
_03904e05_md_test:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %edx
    
    movl 12(%ebp), %ecx               // @this (Type A)
    
    subl 4, %esp  # return value of rt
    pushl %ecx; pushl _my_A_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime (Type Runtime)
    
    subl 4, %esp  # return value of getClass
    pushl %ecx; pushl _my_A_m_getClass; call (%ecx)
	addl 8, %esp
    popl %eax // Class instance ("A"|"B") (Type Class)
/*
    subl 4, %esp  # return value of getClass
    pushl %eax; pushl _my_Class_m_getClass; call (%eax)
	addl 8, %esp
    popl %eax // Class instance "Class" (Type Class)
*/
    subl 4, %esp  # return value of getName
    pushl %eax; pushl _my_Class_m_getName; call (%eax)
	addl 8, %esp
    popl %eax // name cstring ref
    
    pushl %eax; pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _my_Runtime_c_out // ' '
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    movl _my_A_hvo_my_A(%ecx), %ebx  // inst vars offset (A)
    addl 4(%ecx), %ebx                // @this.vars(A)
    push _my_A_i_column(%ebx); pushl _my_Runtime_c_out // column
    pushl %edx; pushl _my_Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _my_Runtime_c_out // ' '
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl 16(%ebp); pushl _my_Runtime_c_out // row
    pushl %edx; pushl _my_Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    movl 8(%ebp), %eax      // @class-desc "A"
    addl _my_A_coso_test, %eax
    pushl %eax; pushl _my_Runtime_c_err
    pushl %edx; pushl _my_Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    popl %ecx
    
    leave
    ret
