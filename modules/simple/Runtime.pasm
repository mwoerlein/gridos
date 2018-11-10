// TODO: #9 improve/separate runtime injection
// CLASS Runtime extends Object
class_Runtime_desc:
    .long inst_Class_Runtime_handle_Class # (class_Runtime_string_classname - class_Runtime_desc) // filled/adjusted on class loading
    .long (class_Runtime_inst_tpl_end - class_Runtime_inst_tpl) // instance size
    .long (class_Runtime_inst_tpl - class_Runtime_desc)         // instance template offset
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)               // handle offset in instance 
class_Runtime_vtabs:
class_Runtime_vtabs_entry_Runtime:
    .long class_Runtime_desc   # (class_Class_string_classname - class_Runtime_desc)    // filled/adjusted on class loading
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
class_Runtime_handle_Runtime:
    .long (class_Runtime_inst_tpl_handle_Runtime - class_Runtime_inst_tpl)              // handle offset in instance 
class_Runtime_vtabs_entry_Object:
    .long class_Object_desc  # (class_Runtime_string_super1 - class_Runtime_desc)       // filled/adjusted on class loading
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
class_Runtime_handle_Object:
    .long (class_Runtime_inst_tpl_handle_Object - class_Runtime_inst_tpl)               // handle offset in instance 
class_Runtime_vtab_end_entry:
    .long 0
    .long 0
    .long 0
class_Runtime_vtab_Runtime:
class_Runtime_vtab_Runtime_method_getClass:
    .long (class_Object_method_getClass - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_hash:
    .long (class_Object_method_hash - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_equals:
    .long (class_Object_method_equals - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_rt:
    .long (class_Object_method_rt - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_setRt:
    .long (class_Object_method_setRt - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_findClass:
    .long (class_Runtime_method_findClass - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_createInstance:
    .long (class_Runtime_method_createInstance - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_destroyInstance:
    .long (class_Runtime_method_destroyInstance - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_allocate:
    .long (class_Runtime_method_allocate - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_free:
    .long (class_Runtime_method_free - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_printChar:
    .long (class_Runtime_method_printChar - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_printString:
    .long (class_Runtime_method_printString - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_printInt:
    .long (class_Runtime_method_printInt - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_printHex:
    .long (class_Runtime_method_printHex - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_errChar:
    .long (class_Runtime_method_errChar - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_errString:
    .long (class_Runtime_method_errString - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_errInt:
    .long (class_Runtime_method_errInt - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Runtime_method_errHex:
    .long (class_Runtime_method_errHex - class_Runtime_desc); .long (class_Runtime_vtabs_entry_Runtime - class_Runtime_desc)
class_Runtime_vtab_Object:
    .long (class_Object_method_getClass - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
    .long (class_Object_method_hash - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
    .long (class_Object_method_equals - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
    .long (class_Object_method_rt - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)
    .long (class_Object_method_setRt - class_Object_desc); .long (class_Runtime_vtabs_entry_Object - class_Runtime_desc)

class_Runtime_inst_tpl:
    .long class_Runtime_desc                // filled/adjusted on class loading
    .long 0  // Runtime_inst_meminfo        // filled during instatiation
class_Runtime_inst_tpl_handle_Runtime:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // Runtime_inst                // filled during instatiation
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
class_Runtime_inst_tpl_handle_Runtime_vars_Object:
    .long (class_Runtime_inst_tpl_vars_Object - class_Runtime_inst_tpl)  // @Super-Obj-Vars
class_Runtime_inst_tpl_handle_Runtime_vars_Runtime:
    .long (class_Runtime_inst_tpl_vars_Runtime - class_Runtime_inst_tpl) // @Runtime-Obj-Vars
class_Runtime_inst_tpl_handle_Object:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // Runtime_inst                // filled during instatiation
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
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
// Method Offsets
Runtime_m_getClass        := (class_Runtime_vtab_Runtime_method_getClass - class_Runtime_vtab_Runtime)
Runtime_m_hash            := (class_Runtime_vtab_Runtime_method_hash - class_Runtime_vtab_Runtime)
Runtime_m_equals          := (class_Runtime_vtab_Runtime_method_equals - class_Runtime_vtab_Runtime)
Runtime_m_rt              := (class_Runtime_vtab_Runtime_method_rt - class_Runtime_vtab_Runtime)
Runtime_m_setRt           := (class_Runtime_vtab_Runtime_method_setRt - class_Runtime_vtab_Runtime)
Runtime_m_findClass       := (class_Runtime_vtab_Runtime_method_findClass - class_Runtime_vtab_Runtime)
Runtime_m_createInstance  := (class_Runtime_vtab_Runtime_method_createInstance - class_Runtime_vtab_Runtime)
Runtime_m_destroyInstance := (class_Runtime_vtab_Runtime_method_destroyInstance - class_Runtime_vtab_Runtime)
Runtime_m_allocate        := (class_Runtime_vtab_Runtime_method_allocate - class_Runtime_vtab_Runtime)
Runtime_m_free            := (class_Runtime_vtab_Runtime_method_free - class_Runtime_vtab_Runtime)
Runtime_m_printChar       := (class_Runtime_vtab_Runtime_method_printChar - class_Runtime_vtab_Runtime)
Runtime_m_printString     := (class_Runtime_vtab_Runtime_method_printString - class_Runtime_vtab_Runtime)
Runtime_m_printInt        := (class_Runtime_vtab_Runtime_method_printInt - class_Runtime_vtab_Runtime)
Runtime_m_printHex        := (class_Runtime_vtab_Runtime_method_printHex - class_Runtime_vtab_Runtime)
Runtime_m_errChar         := (class_Runtime_vtab_Runtime_method_errChar - class_Runtime_vtab_Runtime)
Runtime_m_errString       := (class_Runtime_vtab_Runtime_method_errString - class_Runtime_vtab_Runtime)
Runtime_m_errInt          := (class_Runtime_vtab_Runtime_method_errInt - class_Runtime_vtab_Runtime)
Runtime_m_errHex          := (class_Runtime_vtab_Runtime_method_errHex - class_Runtime_vtab_Runtime)
// Vars Offsets
// Super Vars Offsets
handle_Runtime_vars_Runtime := (class_Runtime_inst_tpl_handle_Runtime_vars_Runtime - class_Runtime_inst_tpl_handle_Runtime)
handle_Runtime_vars_Object  := (class_Runtime_inst_tpl_handle_Runtime_vars_Object - class__inst_tpl_handle_Runtime)

// TODO: use loaded-class-registry
class_Runtime_method_findClass:
    pushl %ebp; movl %esp, %ebp;
    pushl %esi
    pushl %edi
    
_crmft_B:
    movl 16(%ebp), %esi       // param @classname
    movl class_B_string_classname, %edi
    call _string_compare
    addb 0, %al
    jnz _crmft_A
    movl inst_Class_B_handle_Class, 20(%ebp)  // return Class B
    jmp _crmf_return
    
_crmft_A:
    movl 16(%ebp), %esi       // param @classname
    movl class_A_string_classname, %edi
    call _string_compare
    addb 0, %al
    jnz _crmft_NONE
    movl inst_Class_A_handle_Class, 20(%ebp)  // return Class A
    jmp _crmf_return
    
_crmft_NONE:
    movl 0, 20(%ebp)  // return NULL
    
_crmf_return:
    popl %edi
    popl %esi
    leave
    ret
    
class_Runtime_method_createInstance:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx
    pushl %edx
_crmc_start:
    movl 0, 20(%ebp)          // default handle: NULL
    movl 12(%ebp), %ecx       // @this (Type Runtime)
    movl 16(%ebp), %edx       // param @classname

    movl 0, 20(%ebp)  // return Object handle
    addl -4, %esp  # return value of findClass
    pushl %edx
    pushl %ecx; pushl Runtime_m_findClass; call (%ecx)
	addl 12, %esp
    popl %edx                       // @class (Type Class)
    addl 0, %edx; jz _crmc_return   // return NULL if class not exists
    
    addl -4, %esp  # return value of instantiate
    pushl %edx; pushl Class_m_instantiate; call (%edx)
	addl 8, %esp
    popl %ecx                       // @object (type Object)
    addl 0, %ecx; jz _crmc_return   // return NULL if instance could not be generated
    
    addl -4, %esp  # return value of as
    pushl %ecx
    pushl %edx; pushl Class_m_cast; call (%edx)
	addl 12, %esp
    popl %ecx                       // @object (type <classname>)
    
    movl %ecx, 20(%ebp)             // return correct handle
    
_crmc_return:
    popl %edx
    popl %ecx
    leave
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

    pushl 16(%ebp)       // param c
    pushl _env_out; call _ostream_print_char
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printString:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param s
    pushl _env_out; call _ostream_print_string
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printInt:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_out; call _ostream_print_int
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_printHex:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_out; call _ostream_print_hex
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errChar:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param c
    pushl _env_err; call _ostream_print_char
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errString:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param s
    pushl _env_err; call _ostream_print_string
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errInt:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_err; call _ostream_print_int
    addl 8, %esp
    
    popad; leave
    ret

class_Runtime_method_errHex:
    pushl %ebp; movl %esp, %ebp; pushad

    pushl 16(%ebp)       // param i
    pushl _env_err; call _ostream_print_hex
    addl 8, %esp
    
    popad; leave
    ret

/* Static Instances */
inst_Class_Runtime_meminfo: // created on class loading
    .long inst_Class_Runtime
    .long (inst_Class_Runtime_end - inst_Class_Runtime)
inst_Class_Runtime:
    .long class_Class_desc
    .long inst_Class_Runtime_meminfo
inst_Class_Runtime_handle_Class:
    .long _call_entry_unresolved_vtab
    .long inst_Class_Runtime
    .long (class_Class_vtab_Class - class_Class_desc)
inst_Class_Runtime_handle_Class_vars_Object:
    .long (inst_Class_Runtime_vars_Object - inst_Class_Runtime) // @Super-Obj-Vars
inst_Class_Runtime_handle_Class_vars_Class:
    .long (inst_Class_Runtime_vars_Class - inst_Class_Runtime)  // @Class-Obj-Vars
inst_Class_Runtime_handle_Object:
    .long _call_entry_unresolved_vtab
    .long inst_Class_Runtime
    .long (class_Class_vtab_Object - class_Class_desc)
inst_Class_Runtime_handle_Object_vars_Object:
    .long (inst_Class_Runtime_vars_Object - inst_Class_Runtime) // @Object-Obj-Vars
inst_Class_Runtime_vars_Object:
    .long inst_Runtime_handle_Runtime  // Runtime-handle
inst_Class_Runtime_vars_Class:
    .long class_Runtime_string_classname // classname
    .long class_Runtime_desc // class desc
inst_Class_Runtime_end:

// Obj-Instances
inst_Runtime_meminfo:
    .long inst_Runtime
    .long (inst_Runtime_end - inst_Runtime)
inst_Runtime:
    .long class_Runtime_desc
    .long inst_Runtime_meminfo
inst_Runtime_handle_Runtime:
    .long _call_entry_unresolved_vtab
    .long inst_Runtime
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
inst_Runtime_handle_Runtime_vars_Object:
    .long (inst_Runtime_vars_Object - inst_Runtime)  // @Super-Obj-Vars
inst_Runtime_handle_Runtime_vars_Runtime:
    .long (inst_Runtime_vars_Runtime - inst_Runtime) // @Runtime-Obj-Vars
inst_Runtime_handle_Object:
    .long _call_entry_unresolved_vtab
    .long inst_Runtime
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
inst_Runtime_handle_Object_vars_Object:
    .long (inst_Runtime_vars_Object - inst_Runtime)  // @Object-Obj-Vars
inst_Runtime_vars_Object:
    .long inst_Runtime_handle_Runtime  // Runtime-handle
inst_Runtime_vars_Runtime:
inst_Runtime_end:
