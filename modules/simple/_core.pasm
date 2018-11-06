/* ********* ABI **********
 * caller-saved: %eax, %ebx
 * callee-saved: others
 * Stack-Frame:
 * | caller prepared                                                                | call         | callee prepared                          :
 * |Ret N|...|Ret 2|Ret 1|Param N|...|Param 2|Param 1|@Obj-Handle|Method #/@Obj-Vars|@caller return|caller %ebp|Local 1|Local 2|...|saved regs|tmp-data/further frames
 *                                                                                                             ^callee %ebp                   ^callee %esp
 */
/* *** Class-Desc unres. **
 * 31                     0
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-classname-Offset
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | Super1-classname-Offset
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | SuperN-classname-Offset
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 */
/* **** VTab unresolved ***
 * 31                     0
 * +----------------------+
 * | Meth 0 - Var Offset
 * +----------------------+
 * | Meth 0 - Method Offset
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | Meth 1 - Var Offset
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
 * | @Class-Desc
 * +----------------------+
 * | Class-VTab-Offset
 * +----------------------+
 * | @Super1-Desc
 * +----------------------+
 * | Super1-VTab-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | @SuperN-Desc
 * +----------------------+
 * | SuperN-VTab-Offset
 * +----------------------+
 */
/* ***** VTab resolved ****
 * 31                     0
 * +----------------------+
 * | Meth 0 - Var Offset
 * +----------------------+
 * | Meth 0 - @Method
 * +----------------------+
 * | Meth 0 - Class-Desc-Offset
 * +----------------------+
 * | Meth 1 - Var Offset
 * +----------------------+
 * | Meth 1 - @Method
 * +----------------------+
 * | Meth 1 - Class-Desc-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 */
/* ****** Obj-Handle ******
 * +----------------------+
 * | @Call-Entry
 * +----------------------+
 * | @Obj-Class-Desc
 * +----------------------+
 * | @Obj-Class-Vars
 * +----------------------+
 * | @Ref-Class-VTab
 * +----------------------+
 */
/* ******* Obj-Vars *******
 * +----------------------+
 * | Super1-Obj-Vars-Offset
 * +----------------------+
 * | Super2-Obj-Vars-Offset
 * +----------------------+
 * | ...
 * +----------------------+
 * | SuperN-Obj-Vars-Offset
 * +----------------------+
 * | This-Var1
 * +----------------------+
 * | This-Var4
 * +----------------------+
 * | This-Var2 | This-Var3
 * +----------------------+
 * | S1.-Super1-Obj-Vars-Offset
 * +----------------------+
 * | Super1-Var1
 * +----------------------+
 * | ...
 * +----------------------+
 */
// TODO: #9 improve/separate RTTI
/* Core/RTTI */
    
// Class Object
class_Object_desc:
    .long handle_Class_Object # (class_Object_string_classname - class_Object_desc) // filled/adjusted on class loading
    .long class_Object_desc   # (class_Object_string_classname - class_Object_desc) // filled/adjusted on class loading
    .long (class_Object_vtab_Object - class_Object_desc)
    .long 0
class_Object_vtab_Object:
    .long 0; .long (class_Object_method_getClass - class_Object_desc); .long 4
    .long 0; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 0; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 0; .long (class_Object_method_rt - class_Object_desc); .long 12
class_Object_string_classname:
    .asciz "/my/Object"
// Method Offsets
Object_m_getClass := (0 * 12)
Object_m_hash     := (1 * 12)
Object_m_equals   := (2 * 12)
Object_m_rt       := (3 * 12)
// Vars Offsets

class_Object_method_getClass:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this
    movl 4(%eax), %eax     // @class desc
    movl (%eax), %eax      // @class handle
    movl %eax, 16(%ebp)    // return @class handle
    
    leave
    ret

class_Object_method_hash:
    pushl %ebp; movl %esp, %ebp;

    movl 12(%ebp), %eax    // @this
    movl 8(%eax), %eax     // @this.vars(<class>)
    movl %eax, 16(%ebp)    // return obj vars as hash
    
    leave
    ret

class_Object_method_equals:
    pushl %ebp; movl %esp, %ebp;
    
    movl 0, 20(%ebp)       // default return: false

    movl 12(%ebp), %eax    // @this
    movl 8(%eax), %eax     // @this.vars(<class>)
    
    movl 16(%ebp), %ebx    // @obj
    movl 8(%ebx), %ebx     // @obj.vars(<class>)
    .byte 0x29; .byte 0xc3 #// subl %eax, %ebx
    
    jnz class_Object_method_equals_ret
    movl 1, 20(%ebp)       // return true
        
class_Object_method_equals_ret:    
    leave
    ret

class_Object_method_rt:
    pushl %ebp; movl %esp, %ebp;

// TODO: #9 improve/separate runtime injection
    movl handle_Runtime, 16(%ebp)    // return @runtime handle
    
    leave
    ret

// CLASS Class extends Object
class_Class_desc:
    .long handle_Class_Class # (class_Class_string_classname - class_Class_desc) // filled/adjusted on class loading
    .long class_Class_desc   # (class_Class_string_classname - class_Class_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Class - class_Class_desc)
    .long class_Object_desc  # (class_Class_string_super1 - class_Class_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_Class_desc)
    .long 0
class_Class_vtab_Class:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
    .long 0; .long (class_Class_method_getName - class_Class_desc); .long 4
class_Class_vtab_Object:
    .long 4; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 4; .long (class_Object_method_rt - class_Object_desc); .long 12
class_Class_string_classname:
    .asciz "/my/Class"
class_Class_string_super1:
    .asciz "/my/Object"
    
// Method Offsets
Class_m_getClass   := (0 * 12)
Class_m_hash       := (1 * 12)
Class_m_equals     := (2 * 12)
Class_m_rt         := (3 * 12)
Class_m_getName    := (4 * 12)
// Vars Offsets
Class_i_name := 4
// Super Vars Offsets
Class_vars_Object := 0

class_Class_method_getName:
    pushl %ebp; movl %esp, %ebp;

    movl 8(%ebp), %eax            // this.vars(Class)
    movl Class_i_name(%eax), %eax // load reference to cstring-ref
    movl %eax, 16(%ebp)           // return cstring-ref
    
    leave
    ret


/* STATIC HELPER */
_call_entry_resolved_vtab:
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%esp), %eax	        # get method-offset number
	addl 12(%ebx), %eax         # get vtab-entry
	movl 8(%ebx), %ebx          # load obj vars
	addl 0(%eax), %ebx          # add var offset
	movl %ebx, 4(%esp)          # store vars in stack
	jmp 4(%eax)                 # goto method

_call_entry_unresolved_vtab:
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%esp), %eax	        # get method-offset number
	addl 12(%ebx), %eax         # get vtab-entry
	
	movl 8(%ebx), %ebx          # load obj vars
	addl 0(%eax), %ebx          # add var offset
	movl %ebx, 4(%esp)          # store vars in stack
	
	movl 8(%esp), %ebx	        # load object handle
	movl 4(%ebx), %ebx	        # get class-desc
	addl 8(%eax), %ebx          # get method-class-desc-addr
	movl (%ebx), %ebx           # get method-class-desc
	addl 4(%eax), %ebx          # compute method-addr
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
	
print_cga_buffer  := 0xB8000
print_line_offset := 160
print_cga_color   := 15
test_row := 10
cga_testline  := (print_cga_buffer + (test_row * print_line_offset))


/* Static Instances */
handle_Class_Object: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_Object
    .long class_Class_vtab_Class
inst_Class_Object:   // created on class loading
    .long (inst_Class_Object_vars_Object - inst_Class_Object) // @Super-Obj-Vars
    .long class_Object_string_classname
inst_Class_Object_vars_Object:    

handle_Class_Class: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_Class
    .long class_Class_vtab_Class
inst_Class_Class:   // created on class loading
    .long (inst_Class_Class_vars_Object - inst_Class_Class) // @Super-Obj-Vars
    .long class_Class_string_classname
inst_Class_Class_vars_Object:    

