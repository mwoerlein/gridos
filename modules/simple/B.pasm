/*[meta]
mimetype = text/x-pasm
description = class "/my/B"
[pool]
version = 0.1.0
class = true
*/
// class B
_my_B:
    .long 0x15AC1A55
    .long 0
    .long _my_B_cno_my_B
    .long (_03904e06_cts - _my_B)
    .long (_03904e06_mts - _my_B)
    .long (_03904e06_tpl - _my_B)
    .long (_03904e06_tpl_end - _03904e06_tpl)
    .long (_03904e06_tpl_h_e36c4e5b - _03904e06_tpl)
    .long (_03904e06_tpl_h_03904e06 - _03904e06_tpl)

// class tab
_03904e06_cts:
_03904e06_cto_e36c4e5b := (_03904e06_ct_e36c4e5b - _my_B)
_03904e06_ct_e36c4e5b:
    .long 0
    .long _my_B_cno_my_Object
    .long (_03904e06_mt_e36c4e5b - _my_B)
    .long (_03904e06_tpl_h_e36c4e5b - _03904e06_tpl)
_03904e06_cto_ef870f3c := (_03904e06_ct_ef870f3c - _my_B)
_03904e06_ct_ef870f3c:
    .long 0
    .long _my_B_cno_my_Thread
    .long (_03904e06_mt_ef870f3c - _my_B)
    .long (_03904e06_tpl_h_ef870f3c - _03904e06_tpl)
_03904e06_cto_03904e05 := (_03904e06_ct_03904e05 - _my_B)
_03904e06_ct_03904e05:
    .long 0
    .long _my_B_cno_my_A
    .long (_03904e06_mt_03904e05 - _my_B)
    .long (_03904e06_tpl_h_03904e05 - _03904e06_tpl)
_03904e06_cto_03904e06 := (_03904e06_ct_03904e06 - _my_B)
_03904e06_ct_03904e06:
    .long 0
    .long _my_B_cno_my_B
    .long (_03904e06_mt_03904e06 - _my_B)
    .long (_03904e06_tpl_h_03904e06 - _03904e06_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_03904e06_mts:
_03904e06_mt_e36c4e5b:
    .long _my_Object_mdo_getClass
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _03904e06_cto_e36c4e5b
_03904e06_mt_ef870f3c:
    .long _my_Object_mdo_getClass
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _03904e06_cto_e36c4e5b
    .long _my_B_mdo_run
    .long _03904e06_cto_03904e06
_03904e06_mt_03904e05:
    .long _my_Object_mdo_getClass
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_hash
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_equals
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_rt
    .long _03904e06_cto_e36c4e5b
    .long _my_Object_mdo_setRt
    .long _03904e06_cto_e36c4e5b
    .long _my_A_mdo_init
    .long _03904e06_cto_03904e05
    .long _my_B_mdo_getRow
    .long _03904e06_cto_03904e06
    .long _my_A_mdo_test
    .long _03904e06_cto_03904e05
_03904e06_mt_03904e06:
.global _my_B_m_getClass := (_03904e06_mtm_03904e06_getClass - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_getClass:
    .long _my_Object_mdo_getClass
    .long _03904e06_cto_e36c4e5b
.global _my_B_m_hash := (_03904e06_mtm_03904e06_hash - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_hash:
    .long _my_Object_mdo_hash
    .long _03904e06_cto_e36c4e5b
.global _my_B_m_equals := (_03904e06_mtm_03904e06_equals - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_equals:
    .long _my_Object_mdo_equals
    .long _03904e06_cto_e36c4e5b
.global _my_B_m_rt := (_03904e06_mtm_03904e06_rt - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_rt:
    .long _my_Object_mdo_rt
    .long _03904e06_cto_e36c4e5b
.global _my_B_m_setRt := (_03904e06_mtm_03904e06_setRt - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_setRt:
    .long _my_Object_mdo_setRt
    .long _03904e06_cto_e36c4e5b
.global _my_B_m_run := (_03904e06_mtm_03904e06_run - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_run:
    .long _my_B_mdo_run
    .long _03904e06_cto_03904e06
.global _my_B_m_init := (_03904e06_mtm_03904e06_init - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_init:
    .long _my_A_mdo_init
    .long _03904e06_cto_03904e05
.global _my_B_m_getRow := (_03904e06_mtm_03904e06_getRow - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_getRow:
    .long _my_B_mdo_getRow
    .long _03904e06_cto_03904e06
.global _my_B_m_test := (_03904e06_mtm_03904e06_test - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_test:
    .long _my_A_mdo_test
    .long _03904e06_cto_03904e05
.global _my_B_m_doIt := (_03904e06_mtm_03904e06_doIt - _03904e06_mt_03904e06)
_03904e06_mtm_03904e06_doIt:
    .long _my_B_mdo_doIt
    .long _03904e06_cto_03904e06

// constants
// string doit
_my_B_coso_doit := (_03904e06_cos_doit - _my_B)
_03904e06_cos_doit:
    .asciz "OMG! It work's! "

// class-name Object
_my_B_cno_my_Object := (_03904e06_cn_e36c4e5b - _my_B)
_03904e06_cn_e36c4e5b:
    .asciz "/my/Object"

// class-name Thread
_my_B_cno_my_Thread := (_03904e06_cn_ef870f3c - _my_B)
_03904e06_cn_ef870f3c:
    .asciz "/my/Thread"

// class-name A
_my_B_cno_my_A := (_03904e06_cn_03904e05 - _my_B)
_03904e06_cn_03904e05:
    .asciz "/my/A"

// class-name B
_my_B_cno_my_B := (_03904e06_cn_03904e06 - _my_B)
_03904e06_cn_03904e06:
    .asciz "/my/B"

// instance template
_03904e06_tpl:
    .long 0
    .long 0
_03904e06_tpl_h_e36c4e5b:
    .long 0
    .long 0
    .long 0
    .long (_03904e06_tpl_vs_e36c4e5b - _03904e06_tpl)
_03904e06_tpl_h_ef870f3c:
    .long 0
    .long 0
    .long 0
    .long (_03904e06_tpl_vs_e36c4e5b - _03904e06_tpl)
    .long (_03904e06_tpl_vs_ef870f3c - _03904e06_tpl)
_03904e06_tpl_h_03904e05:
    .long 0
    .long 0
    .long 0
    .long (_03904e06_tpl_vs_e36c4e5b - _03904e06_tpl)
    .long (_03904e06_tpl_vs_03904e05 - _03904e06_tpl)
_03904e06_tpl_h_03904e06:
    .long 0
    .long 0
    .long 0
_my_B_hvo_my_Object := (_03904e06_tpl_hv_e36c4e5b - _03904e06_tpl_h_03904e06)
_03904e06_tpl_hv_e36c4e5b:
    .long (_03904e06_tpl_vs_e36c4e5b - _03904e06_tpl)
_my_B_hvo_my_Thread := (_03904e06_tpl_hv_ef870f3c - _03904e06_tpl_h_03904e06)
_03904e06_tpl_hv_ef870f3c:
    .long (_03904e06_tpl_vs_ef870f3c - _03904e06_tpl)
_my_B_hvo_my_A := (_03904e06_tpl_hv_03904e05 - _03904e06_tpl_h_03904e06)
_03904e06_tpl_hv_03904e05:
    .long (_03904e06_tpl_vs_03904e05 - _03904e06_tpl)
_my_B_hvo_my_B := (_03904e06_tpl_hv_03904e06 - _03904e06_tpl_h_03904e06)
_03904e06_tpl_hv_03904e06:
    .long (_03904e06_tpl_vs_03904e06 - _03904e06_tpl)
_03904e06_tpl_vs_e36c4e5b:
// variable runtime
    .long 0
_03904e06_tpl_vs_ef870f3c:
_03904e06_tpl_vs_03904e05:
// variable column
    .long 0
// variable row
    .long 0
_03904e06_tpl_vs_03904e06:
_03904e06_tpl_end:

// method definitions
// method run
.global _my_B_mdo_run := (_03904e06_md_run - _my_B)
_03904e06_md_run:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %edx
    pushl %edi
    
    movl 12(%ebp), %ecx # @this (Type B)
    
    subl 4, %esp  # return value of rt
    pushl %ecx; pushl _my_B_m_rt; call (%ecx)
	addl 8, %esp
    popl %edi   # Runtime(Type Runtime)
    
    pushl 20
    pushl 2
    pushl %ecx; pushl _my_B_m_init; call (%ecx)
	addl 16, %esp
	
    movl 8(%ebp), %eax          // @class-desc "B"
    addl _my_B_cno_my_A, %eax  // "/my/A"
    subl 4, %esp  # return value of createInstance
    pushl %eax
    pushl %edi; pushl _my_Runtime_m_createInstance; call (%edi)
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
    pushl %edi; pushl _my_Runtime_m_destroyInstance; call (%edi)
	addl 12, %esp
    
    popl %edi
    popl %edx
    popl %ecx
    
    leave
    ret

// method doIt
.global _my_B_mdo_doIt := (_03904e06_md_doIt - _my_B)
_03904e06_md_doIt:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %edx
    
    movl 12(%ebp), %ecx # @this (Type B)
    
    subl 4, %esp  # return value of rt
    pushl %ecx; pushl _my_B_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime(Type Runtime)
    
    pushl 0x40; pushl _my_Runtime_c_err // '@'
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    movl 8(%ebp), %eax         // @class-desc "B"
    addl _my_B_coso_doit, %eax // "DoIt "
    pushl %eax; pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    subl 4, %esp  # return value of equals
    pushl 12(%ebp) # @this (Type B)
    pushl %ecx; pushl _my_B_m_equals; call (%ecx)
    addl 12, %esp
    popl %eax
    
    pushl %eax; pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _my_Runtime_c_out // ' '
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    subl 4, %esp  # return value of equals
    pushl 16(%ebp) # param @a (Type A)
    pushl %ecx; pushl _my_B_m_equals; call (%ecx)
    addl 12, %esp
    popl %eax
    
    pushl %eax; pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    subl 4, %esp  # return value of allocate
    pushl 0x124
    pushl %edx; pushl _my_Runtime_m_allocate; call (%edx)
	addl 12, %esp
    popl %esi
    
    pushl 0x20; pushl _my_Runtime_c_out // ' '
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl %esi; pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printHex; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _my_Runtime_c_out // ' '
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl (%esi); pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printHex; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _my_Runtime_c_out // ' '
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl 4(%esi); pushl _my_Runtime_c_out
    pushl %edx; pushl _my_Runtime_m_printHex; call (%edx)
    addl 16, %esp
    
    pushl 0xa; pushl _my_Runtime_c_out // '/n'
    pushl %edx; pushl _my_Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl %esi
    pushl %edx; pushl _my_Runtime_m_free; call (%edx)
    addl 12, %esp
    
    subl 4, %esp  # return value of getRow
    pushl %ecx; pushl _my_B_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl _my_B_m_test; call (%ecx)
	addl 12, %esp
    
    movl 16(%ebp), %ecx # param @a (Type A)
	
    subl 4, %esp  # return value of getRow
    pushl %ecx; pushl _my_A_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl _my_A_m_test; call (%ecx)
	addl 12, %esp
	
    popl %edx
    popl %ecx
    
    leave
    ret

// method getRow
.global _my_B_mdo_getRow := (_03904e06_md_getRow - _my_B)
_03904e06_md_getRow:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax               // @this (Type B)
    movl _my_B_hvo_my_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl _my_A_i_row(%ebx), %eax     // row
    addl %eax, %eax              // *2
    movl %eax, 16(%ebp)          // return row*2
    
    leave
    ret
