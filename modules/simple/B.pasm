/*[meta]
mimetype = text/x-pasm
description = class "/my/B"
[pool]
version = 0.1.0
class = true
*/
// class B
class_B_desc:
    .long 0
    .long class_B_so_cn_B
    .long (class_B_inst_tpl_end - class_B_inst_tpl)
    .long (class_B_inst_tpl - class_B_desc)
    .long (class_B_inst_tpl_handle_Object - class_B_inst_tpl)
    .long (class_B_inst_tpl_handle_B - class_B_inst_tpl)
    .long 0x15AC1A55

class_B_vtabs:
class_B_vtabs_entry_Object:
    .long 0
    .long class_B_so_cn_Object
    .long (class_B_vtab_Object - class_B_desc)
    .long (class_B_inst_tpl_handle_Object - class_B_inst_tpl)
class_B_vtabs_entry_Thread:
    .long 0
    .long class_B_so_cn_Thread
    .long (class_B_vtab_Thread - class_B_desc)
    .long (class_B_inst_tpl_handle_Thread - class_B_inst_tpl)
class_B_vtabs_entry_A:
    .long 0
    .long class_B_so_cn_A
    .long (class_B_vtab_A - class_B_desc)
    .long (class_B_inst_tpl_handle_A - class_B_inst_tpl)
class_B_vtabs_entry_B:
    .long 0
    .long class_B_so_cn_B
    .long (class_B_vtab_B - class_B_desc)
    .long (class_B_inst_tpl_handle_B - class_B_inst_tpl)
class_B_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0

_cBVEObject := (class_B_vtabs_entry_Object - class_B_desc)
_cBVEThread := (class_B_vtabs_entry_Thread - class_B_desc)
_cBVEA := (class_B_vtabs_entry_A - class_B_desc)
_cBVEB := (class_B_vtabs_entry_B - class_B_desc)
class_B_vtab_Object:
    .long class_Object_mo_getClass
    .long _cBVEObject
    .long class_Object_mo_hash
    .long _cBVEObject
    .long class_Object_mo_equals
    .long _cBVEObject
    .long class_Object_mo_rt
    .long _cBVEObject
    .long class_Object_mo_setRt
    .long _cBVEObject
class_B_vtab_Thread:
    .long class_Object_mo_getClass
    .long _cBVEObject
    .long class_Object_mo_hash
    .long _cBVEObject
    .long class_Object_mo_equals
    .long _cBVEObject
    .long class_Object_mo_rt
    .long _cBVEObject
    .long class_Object_mo_setRt
    .long _cBVEObject
    .long class_B_mo_run
    .long _cBVEB
class_B_vtab_A:
    .long class_Object_mo_getClass
    .long _cBVEObject
    .long class_Object_mo_hash
    .long _cBVEObject
    .long class_Object_mo_equals
    .long _cBVEObject
    .long class_Object_mo_rt
    .long _cBVEObject
    .long class_Object_mo_setRt
    .long _cBVEObject
    .long class_A_mo_init
    .long _cBVEA
    .long class_B_mo_getRow
    .long _cBVEB
    .long class_A_mo_test
    .long _cBVEA
class_B_vtab_B:
.global B_m_getClass := (class_B_vtab_B_method_getClass - class_B_vtab_B)
class_B_vtab_B_method_getClass:
    .long class_Object_mo_getClass
    .long _cBVEObject
.global B_m_hash := (class_B_vtab_B_method_hash - class_B_vtab_B)
class_B_vtab_B_method_hash:
    .long class_Object_mo_hash
    .long _cBVEObject
.global B_m_equals := (class_B_vtab_B_method_equals - class_B_vtab_B)
class_B_vtab_B_method_equals:
    .long class_Object_mo_equals
    .long _cBVEObject
.global B_m_rt := (class_B_vtab_B_method_rt - class_B_vtab_B)
class_B_vtab_B_method_rt:
    .long class_Object_mo_rt
    .long _cBVEObject
.global B_m_setRt := (class_B_vtab_B_method_setRt - class_B_vtab_B)
class_B_vtab_B_method_setRt:
    .long class_Object_mo_setRt
    .long _cBVEObject
.global B_m_run := (class_B_vtab_B_method_run - class_B_vtab_B)
class_B_vtab_B_method_run:
    .long class_B_mo_run
    .long _cBVEB
.global B_m_init := (class_B_vtab_B_method_init - class_B_vtab_B)
class_B_vtab_B_method_init:
    .long class_A_mo_init
    .long _cBVEA
.global B_m_getRow := (class_B_vtab_B_method_getRow - class_B_vtab_B)
class_B_vtab_B_method_getRow:
    .long class_B_mo_getRow
    .long _cBVEB
.global B_m_test := (class_B_vtab_B_method_test - class_B_vtab_B)
class_B_vtab_B_method_test:
    .long class_A_mo_test
    .long _cBVEA
.global B_m_doIt := (class_B_vtab_B_method_doIt - class_B_vtab_B)
class_B_vtab_B_method_doIt:
    .long class_B_mo_doIt
    .long _cBVEB

class_B_so_cn_Object := (class_B_string_cn_Object - class_B_desc)
class_B_string_cn_Object:
    .asciz "/my/Object"

class_B_so_cn_Thread := (class_B_string_cn_Thread - class_B_desc)
class_B_string_cn_Thread:
    .asciz "/my/Thread"

class_B_so_cn_A := (class_B_string_cn_A - class_B_desc)
class_B_string_cn_A:
    .asciz "/my/A"

class_B_so_cn_B := (class_B_string_cn_B - class_B_desc)
class_B_string_cn_B:
    .asciz "/my/B"

class_B_inst_tpl:
    .long 0
    .long 0
class_B_inst_tpl_handle_Object:
    .long 0
    .long 0
    .long 0
class_B_inst_tpl_handle_Object_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl)
class_B_inst_tpl_handle_Thread:
    .long 0
    .long 0
    .long 0
class_B_inst_tpl_handle_Thread_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl)
class_B_inst_tpl_handle_Thread_vars_Thread:
    .long (class_B_inst_tpl_vars_Thread - class_B_inst_tpl)
class_B_inst_tpl_handle_A:
    .long 0
    .long 0
    .long 0
class_B_inst_tpl_handle_A_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl)
class_B_inst_tpl_handle_A_vars_A:
    .long (class_B_inst_tpl_vars_A - class_B_inst_tpl)
class_B_inst_tpl_handle_B:
    .long 0
    .long 0
    .long 0
handle_B_vars_Object := (class_B_inst_tpl_handle_B_vars_Object - class_B_inst_tpl_handle_B)
class_B_inst_tpl_handle_B_vars_Object:
    .long (class_B_inst_tpl_vars_Object - class_B_inst_tpl)
handle_B_vars_Thread := (class_B_inst_tpl_handle_B_vars_Thread - class_B_inst_tpl_handle_B)
class_B_inst_tpl_handle_B_vars_Thread:
    .long (class_B_inst_tpl_vars_Thread - class_B_inst_tpl)
handle_B_vars_A := (class_B_inst_tpl_handle_B_vars_A - class_B_inst_tpl_handle_B)
class_B_inst_tpl_handle_B_vars_A:
    .long (class_B_inst_tpl_vars_A - class_B_inst_tpl)
handle_B_vars_B := (class_B_inst_tpl_handle_B_vars_B - class_B_inst_tpl_handle_B)
class_B_inst_tpl_handle_B_vars_B:
    .long (class_B_inst_tpl_vars_B - class_B_inst_tpl)
class_B_inst_tpl_vars_Object:
    .long 0 // runtime
class_B_inst_tpl_vars_Thread:
class_B_inst_tpl_vars_A:
    .long 0 // column
    .long 0 // row
class_B_inst_tpl_vars_B:
class_B_inst_tpl_end:

// method-def run
.global class_B_mo_run := (class_B_method_run - class_B_desc)
class_B_method_run:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %edx
    pushl %edi
    
    movl 12(%ebp), %ecx # @this (Type B)
    
    subl 4, %esp  # return value of rt
    pushl %ecx; pushl B_m_rt; call (%ecx)
	addl 8, %esp
    popl %edi   # Runtime(Type Runtime)
    
    pushl 20
    pushl 2
    pushl %ecx; pushl B_m_init; call (%ecx)
	addl 16, %esp
	
    movl 8(%ebp), %eax          // @class-desc "B"
    addl class_B_so_cn_A, %eax  // "/my/A"
    subl 4, %esp  # return value of createInstance
    pushl %eax
    pushl %edi; pushl Runtime_m_createInstance; call (%edi)
	addl 12, %esp
    popl %edx; // inst_A (type A)
    
    pushl 5
    pushl 2
    pushl %edx; pushl A_m_init; call (%edx)
	addl 16, %esp
    
    pushl %edx
    pushl %ecx; pushl B_m_doIt; call (%ecx)
	addl 12, %esp
    
    pushl %edx
    pushl %edi; pushl Runtime_m_destroyInstance; call (%edi)
	addl 12, %esp
    
    popl %edi
    popl %edx
    popl %ecx
    
    leave
    ret

// method-def doIt
.global class_B_mo_doIt := (class_B_method_doIt - class_B_desc)
class_B_method_doIt:
    pushl %ebp; movl %esp, %ebp
    
    pushl %ecx
    pushl %edx
    
    movl 12(%ebp), %ecx # @this (Type B)
    
    subl 4, %esp  # return value of rt
    pushl %ecx; pushl B_m_rt; call (%ecx)
	addl 8, %esp
    popl %edx   # Runtime(Type Runtime)
    
    pushl 0x40; pushl _err // '@'
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    movl 8(%ebp), %eax         // @class-desc "B"
    addl class_B_so_doit, %eax // "DoIt "
    pushl %eax; pushl _out
    pushl %edx; pushl Runtime_m_printString; call (%edx)
    addl 16, %esp
    
    subl 4, %esp  # return value of equals
    pushl 12(%ebp) # @this (Type B)
    pushl %ecx; pushl B_m_equals; call (%ecx)
    addl 12, %esp
    popl %eax
    
    pushl %eax; pushl _out
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _out // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    subl 4, %esp  # return value of equals
    pushl 16(%ebp) # param @a (Type A)
    pushl %ecx; pushl B_m_equals; call (%ecx)
    addl 12, %esp
    popl %eax
    
    pushl %eax; pushl _out
    pushl %edx; pushl Runtime_m_printInt; call (%edx)
    addl 16, %esp
    
    subl 4, %esp  # return value of allocate
    pushl 0x124
    pushl %edx; pushl Runtime_m_allocate; call (%edx)
	addl 12, %esp
    popl %esi
    
    pushl 0x20; pushl _out // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl %esi; pushl _out
    pushl %edx; pushl Runtime_m_printHex; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _out // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl (%esi); pushl _out
    pushl %edx; pushl Runtime_m_printHex; call (%edx)
    addl 16, %esp
    
    pushl 0x20; pushl _out // ' '
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl 4(%esi); pushl _out
    pushl %edx; pushl Runtime_m_printHex; call (%edx)
    addl 16, %esp
    
    pushl 0xa; pushl _out // '/n'
    pushl %edx; pushl Runtime_m_printChar; call (%edx)
    addl 16, %esp
    
    pushl %esi
    pushl %edx; pushl Runtime_m_free; call (%edx)
    addl 12, %esp
    
    subl 4, %esp  # return value of getRow
    pushl %ecx; pushl B_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl B_m_test; call (%ecx)
	addl 12, %esp
    
    movl 16(%ebp), %ecx # param @a (Type A)
	
    subl 4, %esp  # return value of getRow
    pushl %ecx; pushl A_m_getRow; call (%ecx)
	addl 8, %esp
    popl %eax
    
    pushl %eax     # row
    pushl %ecx; pushl A_m_test; call (%ecx)
	addl 12, %esp
	
    popl %edx
    popl %ecx
    
    leave
    ret

// method-def getRow
.global class_B_mo_getRow := (class_B_method_getRow - class_B_desc)
class_B_method_getRow:
    pushl %ebp; movl %esp, %ebp
    
    movl 12(%ebp), %eax               // @this (Type B)
    movl handle_B_vars_A(%eax), %ebx  // inst vars offset (A)
    addl 4(%eax), %ebx                // @this.vars(A)
    
    movl A_i_row(%ebx), %eax     // row
    addl %eax, %eax              // *2
    movl %eax, 16(%ebp)          // return row*2
    
    leave
    ret

class_B_so_doit := (class_B_string_doit - class_B_desc)
class_B_string_doit:
    .asciz "DoIt "

