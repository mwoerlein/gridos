// TODO: #9 improve/separate runtime injection
// CLASS Runtime extends Object
class_Runtime_desc:
    .long handle_Class_Runtime # (class_Runtime_string_classname - class_Runtime_desc) // filled/adjusted on class loading
    .long class_Runtime_desc   # (class_Runtime_string_classname - class_Runtime_desc) // filled/adjusted on class loading
    .long (class_Runtime_vtab_Runtime - class_Runtime_desc)
    .long class_Object_desc    # (class_Runtime_string_super1 - class_Runtime_desc) // filled/adjusted on class loading
    .long (class_Runtime_vtab_Object - class_Runtime_desc)
    .long 0
class_Runtime_vtab_Runtime:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
    .long 0; .long (class_Runtime_method_allocate - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_free - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printChar - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printString - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printInt - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_printHex - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errChar - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errString - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errInt - class_Runtime_desc); .long 4
    .long 0; .long (class_Runtime_method_errHex - class_Runtime_desc); .long 4
class_Runtime_vtab_Object:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
class_Runtime_string_classname:
    .asciz "/my/Runtime"
class_Runtime_string_super1:
    .asciz "/my/Object"
// Method Offsets
Runtime_m_getClass    := ( 0 * 12)
Runtime_m_hash        := ( 1 * 12)
Runtime_m_equals      := ( 2 * 12)
Runtime_m_rt          := ( 3 * 12)
Runtime_m_allocate    := ( 4 * 12)
Runtime_m_free        := ( 5 * 12)
Runtime_m_printChar   := ( 6 * 12)
Runtime_m_printString := ( 7 * 12)
Runtime_m_printInt    := ( 8 * 12)
Runtime_m_printHex    := ( 9 * 12)
Runtime_m_errChar     := (10 * 12)
Runtime_m_errString   := (11 * 12)
Runtime_m_errInt      := (12 * 12)
Runtime_m_errHex      := (13 * 12)
// Vars Offsets
// Super Vars Offsets
Runtime_vars_Object := 0

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
handle_Class_Runtime: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_Runtime
    .long class_Class_vtab_Class
inst_Class_Runtime:   // created on class loading
    .long (inst_Class_Runtime_vars_Object - inst_Class_Runtime) // @Super-Obj-Vars
    .long class_Runtime_string_classname
inst_Class_Runtime_vars_Object:

// Obj-Handles    
handle_Runtime:
    .long _call_entry_unresolved_vtab
    .long class_Runtime_desc
    .long inst_Runtime
    .long class_Runtime_vtab_Runtime

// Obj-Vars/Instances
inst_Runtime:
    .long (inst_Runtime_vars_Object - inst_Runtime)
inst_Runtime_vars_Object:
