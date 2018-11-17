// TODO: #9 improve/separate runtime injection
// CLASS Runtime extends Object
class_Runtime_desc:
    .long 0 // @class (Type Class) filled by class instantiation
    .long class_Runtime_so_classname
    .long (class_Runtime_inst_tpl_end - class_Runtime_inst_tpl) // instance size
    .long (class_Runtime_inst_tpl - class_Runtime_desc)         // instance template offset
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)               // handle offset in instance 
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)              // handle offset in instance 
    .long 0x15AC1A55
class_Runtime_vtabs:
class_Runtime_vtabs_entry_Runtime:
    .long 0 // @class-desc filled on class loading
    .long class_Runtime_so_classname
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)              // handle offset in instance 
class_Runtime_vtabs_entry_Object:
    .long 0 // @class-desc filled on class loading
    .long class_Runtime_so_super1
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)               // handle offset in instance 
class_Runtime_vtab_end_entry:
    .long 0
    .long 0
    .long 0
    .long 0
class_Runtime_vtab_Runtime:
class_Runtime_vtab_Runtime_method_getClass:
    .long class_Object_mo_getClass; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_hash:
    .long class_Object_mo_hash; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_equals:
    .long class_Object_mo_equals; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_rt:
    .long class_Object_mo_rt; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_setRt:
    .long class_Object_mo_setRt; .long _cRuntimeVEObject
class_Runtime_vtab_Runtime_method_getClassDesc:
    .long class_Runtime_mo_getClassDesc; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_createInstance:
    .long class_Runtime_mo_createInstance; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_destroyInstance:
    .long class_Runtime_mo_destroyInstance; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_allocate:
    .long class_Runtime_mo_allocate; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_free:
    .long class_Runtime_mo_free; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printChar:
    .long class_Runtime_mo_printChar; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printString:
    .long class_Runtime_mo_printString; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printInt:
    .long class_Runtime_mo_printInt; .long _cRuntimeVERuntime
class_Runtime_vtab_Runtime_method_printHex:
    .long class_Runtime_mo_printHex; .long _cRuntimeVERuntime
class_Runtime_vtab_Object:
    .long class_Object_mo_getClass; .long _cRuntimeVEObject
    .long class_Object_mo_hash; .long _cRuntimeVEObject
    .long class_Object_mo_equals; .long _cRuntimeVEObject
    .long class_Object_mo_rt; .long _cRuntimeVEObject
    .long class_Object_mo_setRt; .long _cRuntimeVEObject

_cRuntimeVEObject := (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
_cRuntimeVERuntime := (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)

class_Runtime_mo_getClassDesc    := (class_Runtime_method_getClassDesc - class_Runtime_desc)
class_Runtime_mo_createInstance  := (class_Runtime_method_createInstance - class_Runtime_desc)
class_Runtime_mo_destroyInstance := (class_Runtime_method_destroyInstance - class_Runtime_desc)
class_Runtime_mo_allocate        := (class_Runtime_method_allocate - class_Runtime_desc)
class_Runtime_mo_free            := (class_Runtime_method_free - class_Runtime_desc)
class_Runtime_mo_printChar       := (class_Runtime_method_printChar - class_Runtime_desc)
class_Runtime_mo_printString     := (class_Runtime_method_printString - class_Runtime_desc)
class_Runtime_mo_printInt        := (class_Runtime_method_printInt - class_Runtime_desc)
class_Runtime_mo_printHex        := (class_Runtime_method_printHex - class_Runtime_desc)

class_Runtime_so_classname := (class_Runtime_string_classname - class_Runtime_desc)
class_Runtime_so_super1 := (class_Runtime_string_super1 - class_Runtime_desc)
class_Runtime_so_class := (class_Runtime_string_class - class_Runtime_desc)

class_Runtime_inst_tpl:
    .long 0  // @class-desc
    .long 0  // @meminfo
class_Runtime_inst_tpl_handle_Runtime:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Runtime_inst_tpl_handle_Runtime_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)  // @Super-Obj-Vars
class_Runtime_inst_tpl_handle_Runtime_vars_Runtime:
    .long (class_Runtime_inst_tpl_vars_Runtime - class_Runtime_inst_tpl) // @Runtime-Obj-Vars
class_Runtime_inst_tpl_handle_Object:
    .long 0  // _call_entry
    .long 0  // @inst
    .long 0  // vtab-offset
class_Runtime_inst_tpl_handle_Object_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)  // @Object-Obj-Vars
class_Runtime_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_Runtime_inst_tpl_vars_Runtime:
class_Runtime_inst_tpl_end:

class_Runtime_string_classname:
    .asciz "/my/Runtime"
class_Runtime_string_super1:
    .asciz "/my/Object"
class_Runtime_string_class:
    .asciz "/my/Class"

// Method Offsets
Runtime_m_getClass        := (class_Runtime_vtab_Runtime_method_getClass - class_Runtime_vtab_Runtime)
Runtime_m_hash            := (class_Runtime_vtab_Runtime_method_hash - class_Runtime_vtab_Runtime)
Runtime_m_equals          := (class_Runtime_vtab_Runtime_method_equals - class_Runtime_vtab_Runtime)
Runtime_m_rt              := (class_Runtime_vtab_Runtime_method_rt - class_Runtime_vtab_Runtime)
Runtime_m_setRt           := (class_Runtime_vtab_Runtime_method_setRt - class_Runtime_vtab_Runtime)
Runtime_m_getClassDesc    := (class_Runtime_vtab_Runtime_method_getClassDesc - class_Runtime_vtab_Runtime)
Runtime_m_createInstance  := (class_Runtime_vtab_Runtime_method_createInstance - class_Runtime_vtab_Runtime)
Runtime_m_destroyInstance := (class_Runtime_vtab_Runtime_method_destroyInstance - class_Runtime_vtab_Runtime)
Runtime_m_allocate        := (class_Runtime_vtab_Runtime_method_allocate - class_Runtime_vtab_Runtime)
Runtime_m_free            := (class_Runtime_vtab_Runtime_method_free - class_Runtime_vtab_Runtime)
Runtime_m_printChar       := (class_Runtime_vtab_Runtime_method_printChar - class_Runtime_vtab_Runtime)
Runtime_m_printString     := (class_Runtime_vtab_Runtime_method_printString - class_Runtime_vtab_Runtime)
Runtime_m_printInt        := (class_Runtime_vtab_Runtime_method_printInt - class_Runtime_vtab_Runtime)
Runtime_m_printHex        := (class_Runtime_vtab_Runtime_method_printHex - class_Runtime_vtab_Runtime)
// Vars Offsets
// Super Vars Offsets
handle_Runtime_vars_Runtime := (class_Runtime_inst_tpl_handle_Runtime_vars_Runtime - class_Runtime_inst_tpl_handle_Runtime)
handle_Runtime_vars_Object  := (class_Runtime_inst_tpl_handle_Runtime_vars_Object - class_Runtime_inst_tpl_handle_Runtime)

class_Runtime_method_getClassDesc:
    pushl %ebp; movl %esp, %ebp; pushad
    
    pushl 16(%ebp)       // @classname
    pushl _env_runtime; call _runtime_findClass
    addl 8, %esp
    movl %eax, 20(%ebp)  // return @class desc
    
    popad; leave
    ret

class_Runtime_method_createInstance:
    pushl %ebp; movl %esp, %ebp; pushad
_crmci_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %esi       // @this (Type Runtime)
    
    addl -4, %esp  # return value of getClassDesc
    pushl 16(%ebp)  // param @classname
    pushl %esi; pushl Runtime_m_getClassDesc; call (%esi)
	addl 12, %esp
    popl %edx       // @class-desc
    addl 0, %edx; jz _crmci_return  // return NULL if class not exists
    
    .byte 0x83; .byte 0x3a; .byte 0x00 #// cmpl 0, (%edx)
    jnz _crmci_instantiate // class already initialized
    
    movl 8(%ebp), %eax      // @class-desc "Runtime"
    addl class_Runtime_so_class, %eax
    addl -4, %esp  # return value of createInstance
    pushl %eax // @classname
    pushl %esi; pushl Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %eax   // @class (Type Class)
    addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
    
    pushl %edx                      // @class-desc
    pushl %eax; pushl Class_m_setDesc; call (%eax)
	addl 12, %esp
    
_crmci_instantiate:
    movl class_instance_size_offset(%edx), %eax // instance size
    
    addl -4, %esp  # return value of allocate
    pushl %eax
    pushl %esi; pushl Runtime_m_allocate; call (%esi)
	addl 12, %esp
    popl %eax                       // @object-meminfo
    addl 0, %eax; jz _crmci_return
    
    pushl %esi // @Runtime for later setRt
    call _crh_instantiate // %eax: @object-meminfo %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
    
    addl 0, %esi; jz _crmci_return  // return NULL if instance could not be generated
    movl %esi, 20(%ebp)             // return correct handle
    
_crmci_return:
    popad; leave
    ret

_crh_instantiate: // %eax: @object-meminfo %edx: @Class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    movl (%eax), %edi   // @object
    movl %edx, %esi
    addl class_instance_tpl_offset_offset(%edx), %esi // @instance tpl
    movl class_instance_size_offset(%edx), %ecx // instance size
    .byte 0xf3; .byte 0xa4 #// rep movsb // copy template to object
    
    movl (%eax), %edi   // @object
    movl %edx, (%edi)   // store @class desc in instance 
    movl %eax, 4(%edi)  // store @meminfo in instance
    
    movl %edx, %eax                 // @obj-class desc
    addl class_vtabs_offset, %eax   // @obj-class vtabs entry
_crhi_loop:
    movl _cvte_ho(%eax), %ebx
    movl _cvte_vto(%eax), %ecx
    movl _call_entry, (%edi, %ebx)  // store @call-entry in handle
    movl %edi, 4(%edi, %ebx)        // store @object in handle
    movl %ecx, 8(%edi, %ebx)        // store vtab-offset in handle
    addl _cvte_size, %eax
    .byte 0x83; .byte 0x38; .byte 0x00 #// cmpl 0, (%eax)
    jne _crhi_loop
    
    movl %edi, %esi
    addl class_instance_Object_handle_offset(%edx), %edi // @object (Type Object)
    addl class_instance_class_handle_offset(%edx), %esi // @object (Type <class>)
    ret
    
class_Runtime_method_destroyInstance:
    pushl %ebp; movl %esp, %ebp

    movl 16(%ebp), %eax       // @obj (Type ANY)
    movl 4(%eax), %eax        // @obj
    movl 12(%ebp), %ebx       // @this (Type Runtime)

    pushl 4(%eax)             // @obj meminfo
    pushl %ebx; pushl Runtime_m_free; call (%ebx)
    addl 12, %esp
    
    leave
    ret
    
class_Runtime_method_allocate:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param size
    pushl _env_allocator; call _allocator_allocate
    addl 8, %esp
    movl %eax, 20(%ebp)  // return info
    
    popad; leave
    ret

class_Runtime_method_free:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param info
    pushl _env_allocator; call _allocator_free
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printChar:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl _env_out, %eax
    .byte 0x83; .byte 0x7d; .byte 0x10; .byte 0x00 #// cmpl 0, 16(%ebp)
    je _crmpc_1
    movl _env_err, %eax
_crmpc_1:
    pushl 20(%ebp)       // param c
    pushl %eax; call _ostream_print_char
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printString:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl _env_out, %eax
    .byte 0x83; .byte 0x7d; .byte 0x10; .byte 0x00 #// cmpl 0, 16(%ebp)
    je _crmps_1
    movl _env_err, %eax
_crmps_1:
    pushl 20(%ebp)       // param s
    pushl %eax; call _ostream_print_string
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printInt:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl _env_out, %eax
    .byte 0x83; .byte 0x7d; .byte 0x10; .byte 0x00 #// cmpl 0, 16(%ebp)
    je _crmpi_1
    movl _env_err, %eax
_crmpi_1:
    pushl 20(%ebp)       // param i
    pushl %eax; call _ostream_print_int
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printHex:
    pushl %ebp; movl %esp, %ebp; pushad
    
    movl _env_out, %eax
    .byte 0x83; .byte 0x7d; .byte 0x10; .byte 0x00 #// cmpl 0, 16(%ebp)
    je _crmph_1
    movl _env_err, %eax
_crmph_1:
    pushl 20(%ebp)       // param i
    pushl %eax; call _ostream_print_hex
    addl 8, %esp
    
    popad; leave
    ret

_init_Runtime:
    pushl %ebp; movl %esp, %ebp; addl -8, %esp; pushad
    movl 0, -4(%ebp) // default result: NULL
    
    movl class_Class_desc, %edx
    pushl class_instance_size_offset(%edx) // instance size
    pushl _env_allocator; call _allocator_allocate
    addl 8, %esp
    addl 0, %eax; jz _iR_return  // return NULL on allocate error
    
    movl class_Class_desc, %edx
    call _crh_instantiate // %eax: @object-meminfo %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
	movl %edi, -8(%ebp) // store @Class (Type Object)
	
    pushl class_Class_desc
    pushl %esi; pushl Class_m_setDesc; call (%esi)
	addl 12, %esp
	
    movl class_Runtime_desc, %edx
    pushl class_instance_size_offset(%edx) // instance size
    pushl _env_allocator; call _allocator_allocate
    addl 8, %esp
    addl 0, %eax; jz _iR_return  // return NULL on allocate error
    
    movl class_Runtime_desc, %edx
    call _crh_instantiate // %eax: @object-meminfo %edx: @class-desc, return %edi: @object (Type Object) %esi: @object (Type <class>)
    
    pushl %esi
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
	
	movl -8(%ebp), %edi // load @Class (Type Object)
    pushl %esi
    pushl %edi; pushl Object_m_setRt; call (%edi)
	addl 12, %esp
    
    movl class_Runtime_desc, %eax
    addl class_Runtime_so_class, %eax
    addl -4, %esp  # return value of createInstance
    pushl %eax // @classname
    pushl %esi; pushl Runtime_m_createInstance; call (%esi)
	addl 12, %esp
    popl %eax   // @class (Type Class)
    addl 0, %eax; jz _crmci_return  // return NULL if class could not be initialized
    
    pushl class_Runtime_desc
    pushl %eax; pushl Class_m_setDesc; call (%eax)
	addl 12, %esp
	
    movl %esi, -4(%ebp) // store @runtime (Type Runtime) as result
_iR_return:
    popad
    movl -4(%ebp), %eax // return @runtime (Type Runtime)
    leave
    ret
