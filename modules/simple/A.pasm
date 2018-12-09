/*[meta]
mimetype = text/x-pasm
description = class "/my/A"
[pool]
version = 0.1.0
class = true
*/
// class A
class_A_desc:
    .long 0x15AC1A55
    .long 0
    .long class_A_so_cn_A
    .long (class_A_cts - class_A_desc)
    .long (class_A_mts - class_A_desc)
    .long (class_A_inst_tpl - class_A_desc)
    .long (class_A_inst_tpl_end - class_A_inst_tpl)
    .long (class_A_inst_tpl_handle_Object - class_A_inst_tpl)
    .long (class_A_inst_tpl_handle_A - class_A_inst_tpl)

// class tab
class_A_cts:
_cAVEObject := (class_A_vtabs_entry_Object - class_A_desc)
class_A_vtabs_entry_Object:
    .long 0
    .long class_A_so_cn_Object
    .long (class_A_vtab_Object - class_A_desc)
    .long (class_A_inst_tpl_handle_Object - class_A_inst_tpl)
_cAVEA := (class_A_vtabs_entry_A - class_A_desc)
class_A_vtabs_entry_A:
    .long 0
    .long class_A_so_cn_A
    .long (class_A_vtab_A - class_A_desc)
    .long (class_A_inst_tpl_handle_A - class_A_inst_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
class_A_mts:
class_A_vtab_Object:
    .long class_Object_mo_getClass
    .long _cAVEObject
    .long class_Object_mo_hash
    .long _cAVEObject
    .long class_Object_mo_equals
    .long _cAVEObject
    .long class_Object_mo_rt
    .long _cAVEObject
    .long class_Object_mo_setRt
    .long _cAVEObject
class_A_vtab_A:
.global A_m_getClass := (class_A_vtab_A_method_getClass - class_A_vtab_A)
class_A_vtab_A_method_getClass:
    .long class_Object_mo_getClass
    .long _cAVEObject
.global A_m_hash := (class_A_vtab_A_method_hash - class_A_vtab_A)
class_A_vtab_A_method_hash:
    .long class_Object_mo_hash
    .long _cAVEObject
.global A_m_equals := (class_A_vtab_A_method_equals - class_A_vtab_A)
class_A_vtab_A_method_equals:
    .long class_Object_mo_equals
    .long _cAVEObject
.global A_m_rt := (class_A_vtab_A_method_rt - class_A_vtab_A)
class_A_vtab_A_method_rt:
    .long class_Object_mo_rt
    .long _cAVEObject
.global A_m_setRt := (class_A_vtab_A_method_setRt - class_A_vtab_A)
class_A_vtab_A_method_setRt:
    .long class_Object_mo_setRt
    .long _cAVEObject
.global A_m_init := (class_A_vtab_A_method_init - class_A_vtab_A)
class_A_vtab_A_method_init:
    .long class_A_mo_init
    .long _cAVEA
.global A_m_getRow := (class_A_vtab_A_method_getRow - class_A_vtab_A)
class_A_vtab_A_method_getRow:
    .long class_A_mo_getRow
    .long _cAVEA
.global A_m_test := (class_A_vtab_A_method_test - class_A_vtab_A)
class_A_vtab_A_method_test:
    .long class_A_mo_test
    .long _cAVEA

// constants
// string test
class_A_so_ct_test := (class_A_sct_test - class_A_desc)
class_A_sct_test:
    .asciz " Test\n"

// class-name Object
class_A_so_cn_Object := (class_A_scn_Object - class_A_desc)
class_A_scn_Object:
    .asciz "/my/Object"

// class-name A
class_A_so_cn_A := (class_A_scn_A - class_A_desc)
class_A_scn_A:
    .asciz "/my/A"

// instance template
class_A_inst_tpl:
    .long 0
    .long 0
class_A_inst_tpl_handle_Object:
    .long 0
    .long 0
    .long 0
class_A_inst_tpl_handle_Object_vars_Object:
    .long (class_A_inst_tpl_vars_Object - class_A_inst_tpl)
class_A_inst_tpl_handle_A:
    .long 0
    .long 0
    .long 0
handle_A_vars_Object := (class_A_inst_tpl_handle_A_vars_Object - class_A_inst_tpl_handle_A)
class_A_inst_tpl_handle_A_vars_Object:
    .long (class_A_inst_tpl_vars_Object - class_A_inst_tpl)
handle_A_vars_A := (class_A_inst_tpl_handle_A_vars_A - class_A_inst_tpl_handle_A)
class_A_inst_tpl_handle_A_vars_A:
    .long (class_A_inst_tpl_vars_A - class_A_inst_tpl)
class_A_inst_tpl_vars_Object:
// variable runtime
    .long 0
class_A_inst_tpl_vars_A:
// variable column
.global A_i_column := (class_A_inst_tpl_vars_A_column - class_A_inst_tpl_vars_A)
class_A_inst_tpl_vars_A_column:
    .long 0
// variable row
.global A_i_row := (class_A_inst_tpl_vars_A_row - class_A_inst_tpl_vars_A)
class_A_inst_tpl_vars_A_row:
    .long 0
class_A_inst_tpl_end:

// method definitions
// method init
.global class_A_mo_init := (class_A_method_init - class_A_desc)
class_A_method_init:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax               // @this (Type A)
    movl handle_A_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl 16(%esp), %eax         // param row
    movl %eax, A_i_row(%ebx)    // set this.row
    movl 20(%esp), %eax         // param column
    movl %eax, A_i_column(%ebx) // set this.column
    
    leave
    ret

// method getRow
.global class_A_mo_getRow := (class_A_method_getRow - class_A_desc)
class_A_method_getRow:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax               // @this (Type A)
    movl handle_A_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl A_i_row(%ebx), %eax // row
    movl %eax, 16(%ebp)      // return row
    
    leave
    ret

// method test
.global class_A_mo_test := (class_A_method_test - class_A_desc)
class_A_method_test:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %edx
    
    movl 12(%ebp), %ecx               // @this (Type A)
    
    subl 4, %esp  # return value of rt
    pushl %ecx; pushl A_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime (Type Runtime)
    
    subl 4, %esp  # return value of getClass
    pushl %ecx; pushl A_m_getClass; call (%ecx)
	addl 8, %esp
    popl %eax // handle_Class_(A|B) (Type Class)
/*
    subl 4, %esp  # return value of getClass
    pushl %eax; pushl Class_m_getClass; call (%eax)
	addl 8, %esp
    popl %eax // handle_Class_Class (Type Class)
*/
    subl 4, %esp  # return value of getName
    pushl %eax; pushl Class_m_getName; call (%eax)
	addl 8, %esp
    popl %eax // name cstring ref
    
    pushl %eax; pushl Runtime_c_out
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl Runtime_c_out // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    movl handle_A_vars_A(%ecx), %ebx  // inst vars offset (A)
    addl 4(%ecx), %ebx                // @this.vars(A)
    push A_i_column(%ebx); pushl Runtime_c_out // column
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl Runtime_c_out // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl 16(%ebp); pushl Runtime_c_out // row
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    movl 8(%ebp), %eax      // @class-desc "A"
    addl class_A_so_ct_test, %eax
    pushl %eax; pushl Runtime_c_err
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    popl %ecx
    
    leave
    ret
