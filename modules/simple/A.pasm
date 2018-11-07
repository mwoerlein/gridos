// CLASS A extends Object
class_A_desc:
    .long handle_Class_A     # (class_A_string_classname - class_A_desc) // filled/adjusted on class loading
    .long class_A_desc       # (class_A_string_classname - class_A_desc) // filled/adjusted on class loading
    .long (class_A_vtab_A - class_A_desc)
    .long class_Object_desc  # (class_A_string_super1 - class_A_desc) // filled/adjusted on class loading
    .long (class_A_vtab_Object - class_A_desc)
    .long 0
class_A_vtab_A:
    .long 12; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_rt - class_Object_desc); .long 12
    .long 0; .long (class_A_method_init - class_A_desc); .long 4
    .long 0; .long (class_A_method_getRow - class_A_desc); .long 4
    .long 0; .long (class_A_method_test - class_A_desc); .long 4
class_A_vtab_Object:
    .long 12; .long (class_Object_method_getClass - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_hash - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_equals - class_Object_desc); .long 12
    .long 12; .long (class_Object_method_rt - class_Object_desc); .long 12
class_A_string_classname:
    .asciz "/my/A"
class_A_string_super1:
    .asciz "/my/Object"
// Method Offsets
A_m_getClass := (0 * 12)
A_m_hash     := (1 * 12)
A_m_equals   := (2 * 12)
A_m_rt       := (3 * 12)
A_m_init     := (4 * 12)
A_m_getRow   := (5 * 12)
A_m_test     := (6 * 12)
// Vars Offsets
A_i_column := 4
A_i_row    := 8
// Super Vars Offsets
A_vars_Object := 0

class_A_method_init:
    pushl %ebp; movl %esp, %ebp

    movl 8(%ebp), %eax          // this.vars(A)
    movl 16(%esp), %ebx         // param row
    movl %ebx, A_i_row(%eax)    // set this.row
    movl 20(%esp), %ebx         // param column
    movl %ebx, A_i_column(%eax) // set this.column
    
    leave
    ret

class_A_method_getRow:
    pushl %ebp; movl %esp, %ebp

    movl 8(%ebp), %eax       // this.vars(A)
    movl A_i_row(%eax), %eax // row
    movl %eax, 16(%ebp)      // return row
    
    leave
    ret

class_A_method_test:
    pushl %ebp; movl %esp, %ebp
    pushl %ecx

    movl 8(%ebp), %eax          // this.vars(A)
    movl A_i_column(%eax), %eax // column
    movl 16(%ebp), %ebx         // row
    
    movl  84, %ecx; call _print; add 1, %eax // 'T'
    movl 101, %ecx; call _print; add 1, %eax // 'e'
    movl 115, %ecx; call _print; add 1, %eax // 's'
    movl 116, %ecx; call _print; add 1, %eax // 't'
    
    popl %ecx
    leave
    ret

/* Static Instances */
handle_Class_A: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_A
    .long class_Class_vtab_Class
inst_Class_A:   // created on class loading
    .long (inst_Class_A_vars_Object - inst_Class_A) // @Super-Obj-Vars
    .long class_A_string_classname
inst_Class_A_vars_Object:    

// Obj-Handles
handle_A_1_A:
    .long _call_entry_unresolved_vtab
    .long class_A_desc
    .long inst_A_1_vars_A
    .long class_A_vtab_A

handle_A_1_Object:
    .long _call_entry_unresolved_vtab
    .long class_A_desc
    .long inst_A_1_vars_A
    .long class_A_vtab_Object

// Obj-Vars/Instances
inst_A_1_vars_A:
    .long (inst_A_1_vars_Object - inst_A_1_vars_A) // @Super-Obj-Vars
    .long 0 // column
    .long 0 // row
inst_A_1_vars_Object:
