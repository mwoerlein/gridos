/* ********* ABI **********
 * caller-saved: %eax, %ebx
 * callee-saved: others
 * Stack-Frame:
 * | caller prepared                                                           | call         | callee prepared                          :
 * |Ret N|...|Ret 2|Ret 1|Param N|...|Param 2|Param 1|@Obj-Handle|Method Offset|@caller return|caller %ebp|Local 1|Local 2|...|saved regs|tmp-data/further frames
 *                                                                                                        ^callee %ebp                   ^callee %esp
 */
/* *** Class-Desc unres. **
 * 31                     0
 * +----------------------+
 * | 0
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | instance size
 * +----------------------+
 * | instance-template-Offset
 * +----------------------+
 * | Object-Handle-Offset
 * +----------------------+
 * | Class-Handle-Offset
 * +======================+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Class-Handle-Offset
 * +----------------------+
 * | Super1-classname-Offset
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | Super1-Handle-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | SuperN-classname-Offset
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 * | SuperN-Handle-Offset
 * +----------------------+
 */
/* **** VTab unresolved ***
 * 31                     0
 * +----------------------+
 * | Meth 0 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | Meth 1 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ** Class-Desc resolved *
 * 31                     0
 * +----------------------+
 * | @Class-Handle
 * +----------------------+
 * | @Class-classname
 * +----------------------+
 * | instance size
 * +----------------------+
 * | instance-template-Offset
 * +----------------------+
 * | Object-Handle-Offset
 * +======================+
 * | @Class-Desc
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Class-Handle-Offset
 * +----------------------+
 * | @Super1-Desc
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | Super1-Handle-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | @SuperN-Desc
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 * | SuperN-Handle-Offset
 * +----------------------+
 */
/* ***** VTab resolved ****
 * 31                     0
 * +----------------------+
 * | Meth 0 - @Method
 * +----------------------+
 * | Meth 0 - Class-Handle-Offset
 * +----------------------+
 * | Meth 1 - @Method
 * +----------------------+
 * | Meth 1 - Class-Handle-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ******* Instance *******
 * +----------------------+
 * | @Obj-Class-Desc
 * +----------------------+
 * | @Inst-MemInfo
 * +======================+ < Ref Class
 * | @Call-Entry
 * +----------------------+
 * | @Inst
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Object-Vars-Offset
 * +----------------------+
 * | SuperN-Vars-Offset
 * +----------------------+
 * | ..
 * +----------------------+
 * | Super1-Vars-Offset
 * +----------------------+
 * | Class-Vars-Offset
 * +======================+ < Ref Super1
 * | @Call-Entry
 * +----------------------+
 * | @Inst
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | Object-Vars-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | Super1-Super1-Vars-Offset
 * +----------------------+
 * | Super1-Class-Vars-Offset
 * +======================+ < Ref ...
 * | ...
 * +======================+ < Ref Object
 * | ...
 * +======================+ < Vars Object
 * | ...
 * +----------------------+ < Vars ...
 * | ...
 * +----------------------+ < Vars Super1
 * | Super1-Var1
 * +----------------------+
 * | ...
 * +----------------------+ < Vars Class
 * | This-Var1
 * +----------------------+
 * | This-Var4
 * +----------------------+
 * | This-Var2 | This-Var3
 * +----------------------+
 * | ...
 * +----------------------+
 */
// TODO: #9 improve/separate RTTI
/* Core/RTTI */
    
// Class Object
class_Object_desc:
    .long 0
    .long class_Object_string_classname # (class_Object_string_classname - class_Object_desc) // filled/adjusted on class loading
    .long (class_Object_inst_tpl_end - class_Object_inst_tpl) // instance size
    .long (class_Object_inst_tpl - class_Object_desc)         // instance template offset
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)             // handle offset in instance 
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)             // handle offset in instance 
class_Object_vtabs:
class_Object_vtabs_entry_Object:
    .long class_Object_desc   # (class_Class_string_classname - class_Object_desc)  // filled/adjusted on class loading
    .long (class_Object_vtab_Object - class_Object_desc)
    .long (class_Object_inst_tpl_handle_Object - class_Object_inst_tpl)             // handle offset in instance 
class_Object_vtab_end_entry:
    .long 0
    .long 0
    .long 0
class_Object_vtab_Object:
class_Object_vtab_Object_method_getClass:
    .long (class_Object_method_getClass - class_Object_desc); .long _cObjectVEObject
class_Object_vtab_Object_method_hash:
    .long (class_Object_method_hash - class_Object_desc); .long _cObjectVEObject
class_Object_vtab_Object_method_equals:
    .long (class_Object_method_equals - class_Object_desc); .long _cObjectVEObject
class_Object_vtab_Object_method_rt:
    .long (class_Object_method_rt - class_Object_desc); .long _cObjectVEObject
class_Object_vtab_Object_method_setRt:
    .long (class_Object_method_setRt - class_Object_desc); .long _cObjectVEObject

_cObjectVEObject := (class_Object_vtabs_entry_Object - class_Object_desc)

class_Object_inst_tpl:
    .long class_Object_desc                // filled/adjusted on class loading
    .long 0  // Object_inst_meminfo        // filled during instatiation
class_Object_inst_tpl_handle_Object:
    .long _call_entry_unresolved_vtab      // filled/adjusted on class loading
    .long 0  // Object_inst                // filled during instatiation
    .long (class_Object_vtab_Object - class_Object_desc)
class_Object_inst_tpl_handle_Object_vars_Object:
    .long (class_Object_inst_tpl_vars_Object - class_Object_inst_tpl) // @Super-Obj-Vars
class_Object_inst_tpl_vars_Object:
class_Object_inst_tpl_vars_Object_runtime:
    .long 0  // Runtime-handle
class_Object_inst_tpl_end:

class_Object_string_classname:
    .asciz "/my/Object"
// Method Offsets
Object_m_getClass := (class_Object_vtab_Object_method_getClass - class_Object_vtab_Object)
Object_m_hash     := (class_Object_vtab_Object_method_hash - class_Object_vtab_Object)
Object_m_equals   := (class_Object_vtab_Object_method_equals - class_Object_vtab_Object)
Object_m_rt       := (class_Object_vtab_Object_method_rt - class_Object_vtab_Object)
Object_m_setRt    := (class_Object_vtab_Object_method_setRt - class_Object_vtab_Object)
// Vars Offsets
Object_i_runtime  := (class_Object_inst_tpl_vars_Object_runtime - class_Object_inst_tpl_vars_Object)
// Super Vars Offsets
handle_Object_vars_Object := (class_Object_inst_tpl_handle_Object_vars_Object - class_Object_inst_tpl_handle_Object)

class_Object_method_getClass:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl (%eax), %eax      // @class desc
    movl (%eax), %eax      // @class handle
    movl %eax, 16(%ebp)    // return @class handle
    
    leave
    ret

class_Object_method_hash:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    movl %eax, 16(%ebp)    // return obj vars as hash
    
    leave
    ret

class_Object_method_equals:
    pushl %ebp; movl %esp, %ebp;
    
    movl 0, 20(%ebp)       // default return: false

    movl 12(%ebp), %eax    // @this (Type Object)
    movl 4(%eax), %eax     // @this
    
    movl 16(%ebp), %ebx    // @obj (Type ANY)
    movl 4(%ebx), %ebx     // @obj
    
    .byte 0x29; .byte 0xc3 #// subl %eax, %ebx
    
    jnz class_Object_method_equals_ret
    movl 1, 20(%ebp)       // return true
        
class_Object_method_equals_ret:    
    leave
    ret

class_Object_method_rt:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                         // @this (Type Object)
    movl handle_Object_vars_Object(%eax), %ebx  // inst vars offset (Object)
    addl 4(%eax), %ebx                          // @this.vars(Object)
    movl Object_i_runtime(%ebx), %eax           // load @runtime (Type Runtime)
    movl %eax, 16(%ebp)                         // return @runtime (Type Runtime)
    
    leave
    ret

class_Object_method_setRt:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                         // @this (Type Object)
    movl handle_Object_vars_Object(%eax), %ebx  // inst vars offset (Object)
    addl 4(%eax), %ebx                          // @this.vars(Object)
    movl 16(%ebp), %eax                         // arg @runtime (Type Runtime)
    movl %eax, Object_i_runtime(%ebx)           // store @runtime (Type Runtime)
    
    leave
    ret

class_vtabs_offset := (class_Class_vtabs - class_Class_desc)
class_vtab_size := (class_Class_vtabs_entry_Object - class_Class_vtabs_entry_Class)
class_vtab_handle_offset := (class_Class_handle_Class - class_Class_vtabs_entry_Class)
class_name_offset := (class_Class_name - class_Class_desc)
class_instance_size_offset := (class_Class_instance_size - class_Class_desc)
class_instance_tpl_offset_offset := (class_Class_instance_tpl_offset - class_Class_desc)
class_instance_Object_handle_offset := (class_Class_instance_Object_handle_offset - class_Class_desc)
class_instance_class_handle_offset := (class_Class_instance_class_handle_offset - class_Class_desc)

// CLASS Class extends Object
class_Class_desc:
    .long 0
class_Class_name:
    .long class_Class_string_classname # (class_Class_string_classname - class_Class_desc) // filled/adjusted on class loading
class_Class_instance_size:
    .long (class_Class_inst_tpl_end - class_Class_inst_tpl) // instance size
class_Class_instance_tpl_offset:
    .long (class_Class_inst_tpl - class_Class_desc)         // instance template offset
class_Class_instance_Object_handle_offset:
    .long (class_Class_inst_tpl_handle_Object - class_Class_inst_tpl)            // handle offset in instance 
class_Class_instance_class_handle_offset:
    .long (class_Class_inst_tpl_handle_Class - class_Class_inst_tpl)             // handle offset in instance 
class_Class_vtabs:
class_Class_vtabs_entry_Class:
    .long class_Class_desc   # (class_Class_string_classname - class_Class_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Class - class_Class_desc)
class_Class_handle_Class:
    .long (class_Class_inst_tpl_handle_Class - class_Class_inst_tpl)             // handle offset in instance 
class_Class_vtabs_entry_Object:
    .long class_Object_desc  # (class_Class_string_super1 - class_Class_desc)    // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_Class_desc)
    .long (class_Class_inst_tpl_handle_Object - class_Class_inst_tpl)            // handle offset in instance 
class_Class_vtab_end_entry:
    .long 0
    .long 0
    .long 0
class_Class_vtab_Class:
class_Class_vtab_Class_method_getClass:
    .long (class_Object_method_getClass - class_Object_desc); .long _cClassVEObject
class_Class_vtab_Class_method_hash:
    .long (class_Object_method_hash - class_Object_desc); .long _cClassVEObject
class_Class_vtab_Class_method_equals:
    .long (class_Object_method_equals - class_Object_desc); .long _cClassVEObject
class_Class_vtab_Class_method_rt:
    .long (class_Object_method_rt - class_Object_desc); .long _cClassVEObject
class_Class_vtab_Class_method_setRt:
    .long (class_Object_method_setRt - class_Object_desc); .long _cClassVEObject
class_Class_vtab_Class_method_getDesc:
    .long (class_Class_method_getDesc - class_Class_desc); .long _cClassVEClass
class_Class_vtab_Class_method_setDesc:
    .long (class_Class_method_setDesc - class_Class_desc); .long _cClassVEClass
class_Class_vtab_Class_method_getName:
    .long (class_Class_method_getName - class_Class_desc); .long _cClassVEClass
class_Class_vtab_Class_method_cast:
    .long (class_Class_method_cast - class_Class_desc); .long _cClassVEClass
class_Class_vtab_Object:
    .long (class_Object_method_getClass - class_Object_desc); .long _cClassVEObject
    .long (class_Object_method_hash - class_Object_desc); .long _cClassVEObject
    .long (class_Object_method_equals - class_Object_desc); .long _cClassVEObject
    .long (class_Object_method_rt - class_Object_desc); .long _cClassVEObject
    .long (class_Object_method_setRt - class_Object_desc); .long _cClassVEObject

_cClassVEObject := (class_Class_vtabs_entry_Object - class_Class_desc)
_cClassVEClass := (class_Class_vtabs_entry_Class - class_Class_desc)

class_Class_inst_tpl:
    .long class_Class_desc                  // filled/adjusted on class loading
    .long 0  // Class_inst_meminfo          // filled during instatiation
class_Class_inst_tpl_handle_Class:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // Class_inst                  // filled during instatiation
    .long (class_Class_vtab_Class - class_Class_desc)
class_Class_inst_tpl_handle_Class_vars_Object:
    .long (class_Class_inst_tpl_vars_Object - class_Class_inst_tpl) // @Super-Obj-Vars
class_Class_inst_tpl_handle_Class_vars_Class:
    .long (class_Class_inst_tpl_vars_Class - class_Class_inst_tpl)  // @Class-Obj-Vars
class_Class_inst_tpl_handle_Object:
    .long _call_entry_unresolved_vtab       // filled/adjusted on class loading
    .long 0  // Class_inst                  // filled during instatiation
    .long (class_Class_vtab_Object - class_Class_desc)
class_Class_inst_tpl_handle_Object_vars_Object:
    .long (class_Class_inst_tpl_vars_Object - class_Class_inst_tpl) // @Object-Obj-Vars
class_Class_inst_tpl_vars_Object:
    .long 0  // Runtime-handle
class_Class_inst_tpl_vars_Class:
class_Class_inst_tpl_vars_Class_desc:
    .long 0  // class desc
class_Class_inst_tpl_end:

class_Class_string_classname:
    .asciz "/my/Class"
class_Class_string_super1:
    .asciz "/my/Object"
    
// Method Offsets
Class_m_getClass    := (class_Class_vtab_Class_method_getClass - class_Class_vtab_Class)
Class_m_hash        := (class_Class_vtab_Class_method_hash - class_Class_vtab_Class)
Class_m_equals      := (class_Class_vtab_Class_method_equals - class_Class_vtab_Class)
Class_m_rt          := (class_Class_vtab_Class_method_rt - class_Class_vtab_Class)
Class_m_setRt       := (class_Class_vtab_Class_method_setRt - class_Class_vtab_Class)
Class_m_getDesc     := (class_Class_vtab_Class_method_getDesc - class_Class_vtab_Class)
Class_m_setDesc     := (class_Class_vtab_Class_method_setDesc - class_Class_vtab_Class)
Class_m_getName     := (class_Class_vtab_Class_method_getName - class_Class_vtab_Class)
Class_m_cast        := (class_Class_vtab_Class_method_cast - class_Class_vtab_Class)
// Vars Offsets
Class_i_name := (class_Class_inst_tpl_vars_Class_name - class_Class_inst_tpl_vars_Class)
Class_i_desc := (class_Class_inst_tpl_vars_Class_desc - class_Class_inst_tpl_vars_Class)
// Super Vars Offsets
handle_Class_vars_Class  := (class_Class_inst_tpl_handle_Class_vars_Class - class_Class_inst_tpl_handle_Class)
handle_Class_vars_Object := (class_Class_inst_tpl_handle_Class_vars_Object - class_Class_inst_tpl_handle_Class)

class_Class_method_getDesc:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                       // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx                        // @this.vars(Class)
    movl Class_i_desc(%ebx), %eax // @class desc
    movl %eax, 16(%ebp)           // return @class desc
    
    leave
    ret

class_Class_method_setDesc:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                       // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx                        // @this.vars(Class)
    movl 16(%ebp), %eax           // param @class desc
    movl %eax, Class_i_desc(%ebx) // store @class desc
    movl 12(%ebp), %ebx           // @this (Type Class)
    movl %ebx, (%eax)             // store @instace in class desc
    
    leave
    ret

class_Class_method_getName:
    pushl %ebp; movl %esp, %ebp;
    
    movl 12(%ebp), %eax                       // @this (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx                        // @this.vars(Class)
    movl Class_i_desc(%ebx), %eax             // @class desc
    movl class_name_offset(%eax), %eax        // load reference to cstring
    movl %eax, 16(%ebp)                       // return cstring-ref
    
    leave
    ret

class_Class_method_cast:
    pushl %ebp; movl %esp, %ebp;
    pushl %ecx
_ccmc_start:
    movl 0, 20(%ebp)                // not-found default handle: NULL
    movl 12(%ebp), %eax             // @class (Type Class)
    movl handle_Class_vars_Class(%eax), %ebx  // inst vars offset (Class)
    addl 4(%eax), %ebx              // @this.vars(Class)
    movl Class_i_desc(%ebx), %ecx   // @class desc
    movl 16(%ebp), %eax             // @obj (Type ANY)
    movl 4(%eax), %ebx              // @obj
    movl (%ebx), %eax               // @obj-class desc
    addl class_vtabs_offset, %eax   // @obj-class vtabs
_ccmc_loop:
    .byte 0x39; .byte 0x08 #// cmpl (%eax), %ecx
    je _ccmc_found
    addl class_vtab_size, %eax
    .byte 0x83; .byte 0x38; .byte 0x00 #// cmpl 0, (%eax)
    je _ccmc_return
    jmp _ccmc_loop
_ccmc_found:
    addl class_vtab_handle_offset(%eax), %ebx
    movl %ebx, 20(%ebp)     // return correct handle
_ccmc_return:
    popl %ecx
    leave
    ret


/* STATIC HELPER */
_call_entry_resolved_vtab:
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%ebx), %eax          # get object
	movl 0(%eax), %eax          # get class-desc
	addl 8(%ebx), %eax          # get vtab
	addl 4(%esp), %eax	        # get vtab-entry by adding method-offset number
	movl 4(%ebx), %ebx	        # get object
	addl 4(%eax), %ebx          # compute method-@this
	movl %ebx, 8(%esp)          # store method-@this
	jmp (%eax)                  # goto method

_call_entry_unresolved_vtab:
	pushl %ecx
	movl 12(%esp), %ebx	        # load object handle
	movl 4(%ebx), %eax          # get object
	movl 0(%eax), %eax          # get class-desc
	addl 8(%ebx), %eax          # get vtab
	addl 8(%esp), %eax	        # get vtab-entry by adding method-offset number
	movl 4(%ebx), %ecx	        # get object
	movl 0(%ecx), %ebx	        # get class-desc
	addl 4(%eax), %ebx          # get method-class-context
	addl 8(%ebx), %ecx          # compute method-@this
	movl %ecx, 12(%esp)         # store method-@this
	movl 0(%ebx), %ebx          # get method-class-desc
	addl 0(%eax), %ebx          # compute method-addr
	popl %ecx
	jmp %ebx                    # goto method

_print: # %eax:column, %ebx:row, %cl:character
    pushl %ebx
    pushl %ecx
	.byte 0x69; .byte 0xdb; .long print_line_offset #// imull print_line_offset, %ebx
	movb print_cga_color, %ch
	movw %cx, print_cga_buffer(%ebx,%eax,2)
	popl %ecx
	popl %ebx
	ret

_string_compare: # %esi:string 1, %edi:string 2, return %al:<0, =0, >0
    addl -1, %edi
_string_compare_loop:   	
    addl 1, %edi
    lodsb
    .byte 0x2a; .byte 0x07 #// subb (%edi), %al
    jnz _string_compare_return // differrent chars
    addb (%edi), %al
    jnz _string_compare_loop  // not end of string
_string_compare_return:
    ret
	
print_cga_buffer  := 0xB8000
print_line_offset := 160
print_cga_color   := 15
test_row := 10
cga_testline  := (print_cga_buffer + (test_row * print_line_offset))


