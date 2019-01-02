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
_my_core_Object_m_getClass := 0
    .long 0
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_hash := 8
    .long 4
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_equals := 16
    .long 8
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_rt := 24
    .long 12
    .long _07f7c73b_cto_01a2e54e
_my_core_Object_m_setRt := 32
    .long 16
    .long _07f7c73b_cto_01a2e54e
_07f7c73b_mt_07f7c73b:
_my_A_m_getClass := 0
    .long 0
    .long _07f7c73b_cto_01a2e54e
_my_A_m_hash := 8
    .long 4
    .long _07f7c73b_cto_01a2e54e
_my_A_m_equals := 16
    .long 8
    .long _07f7c73b_cto_01a2e54e
_my_A_m_rt := 24
    .long 12
    .long _07f7c73b_cto_01a2e54e
_my_A_m_setRt := 32
    .long 16
    .long _07f7c73b_cto_01a2e54e
_my_A_m_init := 40
    .long 0
    .long _07f7c73b_cto_07f7c73b
_my_A_m_getRow := 48
    .long 4
    .long _07f7c73b_cto_07f7c73b
_my_A_m_getRowAndColumn := 56
    .long 8
    .long _07f7c73b_cto_07f7c73b
_my_A_m_test := 64
    .long 12
    .long _07f7c73b_cto_07f7c73b

// methods tab
_07f7c73b_mdt:
_my_A_mdo_init := (_07f7c73b_md_init - _my_A)
    .long _my_A_mdo_init
_my_A_mdo_getRow := (_07f7c73b_md_getRow - _my_A)
    .long _my_A_mdo_getRow
_my_A_mdo_getRowAndColumn := (_07f7c73b_md_getRowAndColumn - _my_A)
    .long _my_A_mdo_getRowAndColumn
_my_A_mdo_test := (_07f7c73b_md_test - _my_A)
    .long _my_A_mdo_test

// constants
// int out
_my_A_coi_out := 0

// int err
_my_A_coi_err := 1

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
_07f7c73b_md_getRowAndColumn:
    pushl %ebp; movl %esp, %ebp
    
            movl 12(%ebp), %eax             // @this (Type A)
            movl _my_A_hvo_my_A(%eax), %ebx // inst vars offset (A)
            addl 4(%eax), %ebx              // @this.vars(A)
            
            movl _my_A_i_row(%ebx), %eax    // row
            movl %eax, 16(%ebp)             // return row
            movl _my_A_i_column(%ebx), %eax // column
            movl %eax, 20(%ebp)             // return column
    
    leave
    ret

// method test
_07f7c73b_md_test:
    pushl %ebp; movl %esp, %ebp
    
// TODO #3: inline method-indices in method-call-generation
//*/
        _my_core_Class_m_getName := 56
        _my_core_Runtime_m_getClassDesc := 48
        _my_core_Runtime_m_allocate := 56
        _my_core_Runtime_m_free := 64
        _my_core_Runtime_m_printChar := 72
        _my_core_Runtime_m_printString := 80
        _my_core_Runtime_m_printInt := 88
        _my_core_Runtime_m_printHex := 96
        _my_core_Runtime_m_destroyInstance := 104
        _my_core_Runtime_m_cast := 112
        _my_core_Runtime_m_createAndRunThread := 120
        _my_core_Runtime_m_createInstance := 128
//*/
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
            
            pushl _my_A_coi_out; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            pushl _my_A_coi_out; pushl 0x20 // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            movl _my_A_hvo_my_A(%ecx), %ebx     // inst vars offset (A)
            addl 4(%ecx), %ebx                  // @this.vars(A)
            pushl _my_A_coi_out; push _my_A_i_column(%ebx) // column
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl _my_A_coi_out; pushl 0x20 // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            pushl _my_A_coi_out; pushl 16(%ebp) // param row
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            subl 8, %esp    // return values of getRowAndColumn
            pushl %ecx; pushl _my_A_m_getRowAndColumn; call (%ecx)
        	addl 8, %esp
            
            pushl _my_A_coi_out; pushl 0x20 // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            popl %eax       // row from getRowAndColumn
            pushl _my_A_coi_out; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            pushl _my_A_coi_out; pushl 0x20 // ' '
            pushl %edx; pushl _my_core_Runtime_m_printChar; call (%edx)
            addl 16, %esp
            
            popl %eax       // column from getRowAndColumn
            pushl _my_A_coi_out; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printInt; call (%edx)
            addl 16, %esp
            
            movl 8(%ebp), %eax      // @class-desc "A"
            addl _my_A_coso_test, %eax
            pushl _my_A_coi_err; pushl %eax
            pushl %edx; pushl _my_core_Runtime_m_printString; call (%edx)
            addl 16, %esp
            
            popl %edx
            popl %ecx
    
    leave
    ret
