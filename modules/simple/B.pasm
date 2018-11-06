// CLASS B extends A
class_B_desc:
    .long handle_Class_B # (class_Class_string_classname - class_B_desc) // filled/adjusted on class loading
    .long class_B_desc   # (class_Class_string_classname - class_B_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Class - class_B_desc)
    .long class_A_desc  # (class_B_string_super1 - class_B_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_B_desc)
    .long class_Object_desc  # (class_B_string_super2 - class_B_desc) // filled/adjusted on class loading
    .long (class_Class_vtab_Object - class_B_desc)
    .long 0
class_B_vtab_B:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
    .long 8; .long (class_A_method_run - class_A_desc); .long 12
    .long 8; .long (class_A_method_test - class_A_desc); .long 12
    .long 0; .long (class_B_method_getRow - class_B_desc); .long 4
class_B_vtab_A:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
    .long 8; .long (class_A_method_run - class_A_desc); .long 12
    .long 8; .long (class_A_method_test - class_A_desc); .long 12
    .long 0; .long (class_B_method_getRow - class_B_desc); .long 4
class_B_vtab_Object:
    .long 16; .long (class_Object_method_getClass - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_hash - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_equals - class_Object_desc); .long 20
    .long 16; .long (class_Object_method_rt - class_Object_desc); .long 20
class_B_string_classname:
    .asciz "/my/B"
class_B_string_super1:
    .asciz "/my/A"
class_B_string_super2:
    .asciz "/my/Object"
// Method Offsets
B_m_getClass := (0 * 12)
B_m_hash     := (1 * 12)
B_m_equals   := (2 * 12)
B_m_rt       := (3 * 12)
B_m_run      := (4 * 12)
B_m_test     := (5 * 12)
B_m_getRow   := (6 * 12)
// Super Vars Offsets
B_vars_A      := 0
B_vars_Object := 4

class_B_method_getRow:
    pushl %ebp; movl %esp, %ebp

    movl 8(%ebp), %eax           // this.vars(B)
    addl B_vars_A(%eax), %eax    // this.vars(A)
    movl A_i_row(%eax), %eax     // row
    addl %eax, %eax              // *2
    movl %eax, 16(%ebp)          // return row*2
    
    leave
    ret

/* Static Instances */
handle_Class_B: // created on class loading
    .long _call_entry_unresolved_vtab
    .long class_Class_desc
    .long inst_Class_B
    .long class_Class_vtab_Class
inst_Class_B:   // created on class loading
    .long (inst_Class_B_vars_Object - inst_Class_B) // @Super-Obj-Vars
    .long class_B_string_classname
inst_Class_B_vars_Object:
    
// Obj-Handles
handle_B_1_B:
    .long _call_entry_unresolved_vtab
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_B

handle_B_1_A:
    .long _call_entry_unresolved_vtab
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_A

handle_B_1_Object:
    .long _call_entry_unresolved_vtab
    .long class_B_desc
    .long inst_B_1_vars_B
    .long class_B_vtab_Object

// Obj-Vars/Instances
inst_B_1_vars_B:
    .long (inst_B_1_vars_A - inst_B_1_vars_B)      // @Super-Obj-Vars
    .long (inst_B_1_vars_Object - inst_B_1_vars_B) // @Super-Obj-Vars
inst_B_1_vars_A:
    .long (inst_B_1_vars_Object - inst_B_1_vars_A) // @Super-Obj-Vars
    .long 10 // column
    .long 2 // row
inst_B_1_vars_Object:
