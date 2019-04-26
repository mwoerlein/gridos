/*[meta]
mimetype = text/x-pasm
description = class "my::core::OStream"
[pool]
class = true
version = 0.1.0
[pool_source]
unit = my::core::OStream
version = 0.1.0
author = Marc Woerlein <marc.woerlein@gmx.de>
*/
// class OStream
_my_core_OStream:
    .long 0x15AC1A55
    .long 0
    .long _my_core_OStream_coso_CLASSNAME
    .long (_13be4a12_cts - _my_core_OStream)
    .long (_13be4a12_mts - _my_core_OStream)
    .long (_13be4a12_mdt - _my_core_OStream)
    .long (_13be4a12_tpl - _my_core_OStream)
    .long (_13be4a12_tpl_end - _13be4a12_tpl)
    .long (_13be4a12_tpl_h_01a2e54e - _13be4a12_tpl)
    .long (_13be4a12_tpl_h_13be4a12 - _13be4a12_tpl)

// class tab
_13be4a12_cts:
_13be4a12_cto_01a2e54e := (_13be4a12_ct_01a2e54e - _my_core_OStream)
_13be4a12_ct_01a2e54e:
    .long 0
    .long _my_core_OStream_coso_string_1
    .long (_13be4a12_mt_01a2e54e - _my_core_OStream)
    .long (_13be4a12_tpl_h_01a2e54e - _13be4a12_tpl)
_13be4a12_cto_13be4a12 := (_13be4a12_ct_13be4a12 - _my_core_OStream)
_13be4a12_ct_13be4a12:
    .long 0
    .long _my_core_OStream_coso_CLASSNAME
    .long (_13be4a12_mt_13be4a12 - _my_core_OStream)
    .long (_13be4a12_tpl_h_13be4a12 - _13be4a12_tpl)
// class tab end
    .long 0
    .long 0
    .long 0
    .long 0

// method tabs
_13be4a12_mts:
_13be4a12_mt_01a2e54e:
    .long 0
    .long _13be4a12_cto_01a2e54e
    .long 4
    .long _13be4a12_cto_01a2e54e
    .long 8
    .long _13be4a12_cto_01a2e54e
    .long 12
    .long _13be4a12_cto_01a2e54e
    .long 16
    .long _13be4a12_cto_01a2e54e
    .long 20
    .long _13be4a12_cto_01a2e54e
_13be4a12_mt_13be4a12:
    .long 0
    .long _13be4a12_cto_01a2e54e
    .long 4
    .long _13be4a12_cto_01a2e54e
    .long 8
    .long _13be4a12_cto_01a2e54e
    .long 12
    .long _13be4a12_cto_01a2e54e
    .long 16
    .long _13be4a12_cto_01a2e54e
    .long 20
    .long _13be4a12_cto_01a2e54e
    .long 0
    .long _13be4a12_cto_13be4a12
    .long 4
    .long _13be4a12_cto_13be4a12
    .long 8
    .long _13be4a12_cto_13be4a12
    .long 12
    .long _13be4a12_cto_13be4a12
    .long 16
    .long _13be4a12_cto_13be4a12
    .long 20
    .long _13be4a12_cto_13be4a12
    .long 24
    .long _13be4a12_cto_13be4a12
    .long 28
    .long _13be4a12_cto_13be4a12
    .long 32
    .long _13be4a12_cto_13be4a12
    .long 36
    .long _13be4a12_cto_13be4a12
    .long 40
    .long _13be4a12_cto_13be4a12
    .long 44
    .long _13be4a12_cto_13be4a12
    .long 48
    .long _13be4a12_cto_13be4a12

// methods tab
_13be4a12_mdt:
    .long 0
    .long (_13be4a12_md_printInt - _my_core_OStream)
    .long (_13be4a12_md_printHex - _my_core_OStream)
    .long (_13be4a12_md_printCString - _my_core_OStream)
    .long (_13be4a12_md_print - _my_core_OStream)
    .long (_13be4a12_md_printNewline - _my_core_OStream)
    .long (_13be4a12_md__printInt - _my_core_OStream)
    .long (_13be4a12_md__printUInt - _my_core_OStream)
    .long (_13be4a12_md__printHex - _my_core_OStream)
    .long (_13be4a12_md__printUHex - _my_core_OStream)
    .long (_13be4a12_md__printCStringBuffer - _my_core_OStream)
    .long (_13be4a12_md__putChar - _my_core_OStream)
    .long (_13be4a12_md__getChar - _my_core_OStream)

// constants
// string CLASSNAME
_my_core_OStream_coso_CLASSNAME := (_13be4a12_cos_CLASSNAME - _my_core_OStream)
_13be4a12_cos_CLASSNAME:
    .asciz "my::core::OStream"

// string string_1
_my_core_OStream_coso_string_1 := (_13be4a12_cos_string_1 - _my_core_OStream)
_13be4a12_cos_string_1:
    .asciz "my::core::Object"

// instance template
_13be4a12_tpl:
    .long 0
    .long 0
_13be4a12_tpl_h_01a2e54e:
    .long 0
    .long 0
    .long 0
    .long (_13be4a12_tpl_vs_01a2e54e - _13be4a12_tpl)
_13be4a12_tpl_h_13be4a12:
    .long 0
    .long 0
    .long 0
_my_core_OStream_hvo_my_core_Object := (_13be4a12_tpl_hv_01a2e54e - _13be4a12_tpl_h_13be4a12)
_13be4a12_tpl_hv_01a2e54e:
    .long (_13be4a12_tpl_vs_01a2e54e - _13be4a12_tpl)
_my_core_OStream_hvo_my_core_OStream := (_13be4a12_tpl_hv_13be4a12 - _13be4a12_tpl_h_13be4a12)
_13be4a12_tpl_hv_13be4a12:
    .long (_13be4a12_tpl_vs_13be4a12 - _13be4a12_tpl)
_13be4a12_tpl_vs_01a2e54e:
// variable runtime
_my_core_Object_i_runtime := (_13be4a12_tpl_v_01a2e54e_runtime - _13be4a12_tpl_vs_01a2e54e)
_13be4a12_tpl_v_01a2e54e_runtime:
    .long 0
_13be4a12_tpl_vs_13be4a12:
_13be4a12_tpl_end:

// method definitions
// method printChar

// method printInt
_13be4a12_md_printInt:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    pushad
    jmp _13be4a12_md_printInt_bb_2
_13be4a12_md_printInt_bb_1:
    popad
    leave
    ret
_13be4a12_md_printInt_bb_2:
    movl 10, -4(%ebp)
    movl 0, -8(%ebp)
    subl 4, %esp
    pushl -8(%ebp)
    pushl -4(%ebp)
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 96; call (%eax)
    addl 20, %esp
    popl -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _13be4a12_md_printInt_bb_1
_13be4a12_md_printInt_bb_3:
    jmp _13be4a12_md_printInt_bb_1

// method printHex
_13be4a12_md_printHex:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _13be4a12_md_printHex_bb_2
_13be4a12_md_printHex_bb_1:
    popad
    leave
    ret
_13be4a12_md_printHex_bb_2:
    movl 0, -4(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 112; call (%eax)
    addl 16, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _13be4a12_md_printHex_bb_1
_13be4a12_md_printHex_bb_3:
    jmp _13be4a12_md_printHex_bb_1

// method printCString
_13be4a12_md_printCString:
    pushl %ebp; movl %esp, %ebp
    subl 12, %esp
    pushad
    jmp _13be4a12_md_printCString_bb_2
_13be4a12_md_printCString_bb_1:
    popad
    leave
    ret
_13be4a12_md_printCString_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 16(%ebp), %eax

    movl %eax, -4(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -12(%ebp)
    movl -12(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _13be4a12_md_printCString_bb_1
_13be4a12_md_printCString_bb_3:
    jmp _13be4a12_md_printCString_bb_1

// method print
_13be4a12_md_print:
    pushl %ebp; movl %esp, %ebp
    subl 20, %esp
    pushad
    jmp _13be4a12_md_print_bb_2
_13be4a12_md_print_bb_1:
    popad
    leave
    ret
_13be4a12_md_print_bb_2:
    subl 4, %esp
    movl 12(%ebp), %eax
    pushl %eax; pushl 32; call (%eax)
    addl 8, %esp
    popl -8(%ebp)
    movl 8(%ebp), %eax
    addl _my_core_OStream_coso_string_1, %eax
    movl %eax, -12(%ebp)
    subl 4, %esp
    pushl 16(%ebp)
    pushl -12(%ebp)
    movl -8(%ebp), %eax
    pushl %eax; pushl 120; call (%eax)
    addl 16, %esp
    popl -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -4(%ebp)
    subl 4, %esp
    pushl 12(%ebp)
    movl -4(%ebp), %eax
    pushl %eax; pushl 24; call (%eax)
    addl 12, %esp
    popl -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _13be4a12_md_print_bb_1
_13be4a12_md_print_bb_3:
    jmp _13be4a12_md_print_bb_1

// method printNewline
_13be4a12_md_printNewline:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _13be4a12_md_printNewline_bb_2
_13be4a12_md_printNewline_bb_1:
    popad
    leave
    ret
_13be4a12_md_printNewline_bb_2:
    movl 10, -4(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _13be4a12_md_printNewline_bb_1
_13be4a12_md_printNewline_bb_3:
    jmp _13be4a12_md_printNewline_bb_1

// method _printInt
_13be4a12_md__printInt:
    pushl %ebp; movl %esp, %ebp
    subl 24, %esp
    pushad
    movl 0, -16(%ebp)
    jmp _13be4a12_md__printInt_bb_2
_13be4a12_md__printInt_bb_1:
    popad
    leave
    ret
_13be4a12_md__printInt_bb_2:
    movl 0, -4(%ebp)
    movl 16(%ebp), %eax
    cmpl -4(%ebp), %eax
    jlt _13be4a12_md__printInt_bb_4
    jmp _13be4a12_md__printInt_bb_5
_13be4a12_md__printInt_bb_3:
    subl 4, %esp
    pushl 24(%ebp)
    pushl 20(%ebp)
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 104; call (%eax)
    addl 20, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, 28(%ebp)
    jmp _13be4a12_md__printInt_bb_1
_13be4a12_md__printInt_bb_4:
    movl 45, -8(%ebp)
    subl 4, %esp
    pushl -8(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -12(%ebp)
    movl -16(%ebp), %eax
    subl 16(%ebp), %eax
    movl %eax, -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _13be4a12_md__printInt_bb_3
_13be4a12_md__printInt_bb_5:
    jmp _13be4a12_md__printInt_bb_3
_13be4a12_md__printInt_bb_6:
    jmp _13be4a12_md__printInt_bb_1

// method _printUInt
_13be4a12_md__printUInt:
    pushl %ebp; movl %esp, %ebp
    subl 116, %esp
    pushad
    movl 1, -20(%ebp)
    movl 0, -72(%ebp)
    jmp _13be4a12_md__printUInt_bb_2
_13be4a12_md__printUInt_bb_1:
    popad
    leave
    ret
_13be4a12_md__printUInt_bb_2:
    movl 21, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 0, -16(%ebp)
    movl -16(%ebp), %eax
    movl %eax, -12(%ebp)
    movl -4(%ebp), %eax
movl %esp, %ebx; subl %eax, %esp
    movl %ebx, -12(%ebp)
    movl -12(%ebp), %eax
    subl -20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 0, -24(%ebp)
    pushl -24(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 16, %esp
    movl -12(%ebp), %eax
    subl 24(%ebp), %eax
    movl %eax, -32(%ebp)
    movl -32(%ebp), %eax
    movl %eax, -28(%ebp)
    movl 16(%ebp), %eax
    .byte 0x99 #//cdq
    movl 20(%ebp), %ebx
    .byte 0xf7; .byte 0xfb #//idiv %ebx
    movl %edx, -40(%ebp)
    movl -40(%ebp), %eax
    movl %eax, -36(%ebp)
    movl 10, -44(%ebp)
    movl -36(%ebp), %eax
    cmpl -44(%ebp), %eax
    jlt _13be4a12_md__printUInt_bb_4
    jmp _13be4a12_md__printUInt_bb_5
_13be4a12_md__printUInt_bb_3:
    jmp _13be4a12_md__printUInt_bb_8
_13be4a12_md__printUInt_bb_4:
    movl -12(%ebp), %eax
    subl -20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 48, -48(%ebp)
    movl -36(%ebp), %eax
    addl -48(%ebp), %eax
    movl %eax, -52(%ebp)
    pushl -52(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 16, %esp
    jmp _13be4a12_md__printUInt_bb_3
_13be4a12_md__printUInt_bb_5:
    movl -12(%ebp), %eax
    subl -20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 97, -56(%ebp)
    movl -36(%ebp), %eax
    addl -56(%ebp), %eax
    movl %eax, -60(%ebp)
    movl 10, -64(%ebp)
    movl -60(%ebp), %eax
    subl -64(%ebp), %eax
    movl %eax, -68(%ebp)
    pushl -68(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 16, %esp
    jmp _13be4a12_md__printUInt_bb_3
_13be4a12_md__printUInt_bb_6:
    jmp _13be4a12_md__printUInt_bb_14
_13be4a12_md__printUInt_bb_7:
    movl 16(%ebp), %eax
    .byte 0x99 #//cdq
    movl 20(%ebp), %ebx
    .byte 0xf7; .byte 0xfb #//idiv %ebx
    movl %edx, -80(%ebp)
    movl -80(%ebp), %eax
    movl %eax, -76(%ebp)
    movl 10, -84(%ebp)
    movl -76(%ebp), %eax
    cmpl -84(%ebp), %eax
    jlt _13be4a12_md__printUInt_bb_10
    jmp _13be4a12_md__printUInt_bb_11
_13be4a12_md__printUInt_bb_8:
    movl 16(%ebp), %eax
    .byte 0x99 #//cdq
    movl 20(%ebp), %ebx
    .byte 0xf7; .byte 0xfb #//idiv %ebx
    movl %eax, 16(%ebp)
    movl 16(%ebp), %eax
    cmpl -72(%ebp), %eax
    jne _13be4a12_md__printUInt_bb_7
    jmp _13be4a12_md__printUInt_bb_6
_13be4a12_md__printUInt_bb_9:
    jmp _13be4a12_md__printUInt_bb_8
_13be4a12_md__printUInt_bb_10:
    movl -12(%ebp), %eax
    subl -20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 48, -88(%ebp)
    movl -76(%ebp), %eax
    addl -88(%ebp), %eax
    movl %eax, -92(%ebp)
    pushl -92(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 16, %esp
    jmp _13be4a12_md__printUInt_bb_9
_13be4a12_md__printUInt_bb_11:
    movl -12(%ebp), %eax
    subl -20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 97, -96(%ebp)
    movl -76(%ebp), %eax
    addl -96(%ebp), %eax
    movl %eax, -100(%ebp)
    movl 10, -104(%ebp)
    movl -100(%ebp), %eax
    subl -104(%ebp), %eax
    movl %eax, -108(%ebp)
    pushl -108(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 16, %esp
    jmp _13be4a12_md__printUInt_bb_9
_13be4a12_md__printUInt_bb_12:
    subl 4, %esp
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 128; call (%eax)
    addl 12, %esp
    popl -116(%ebp)
    movl -4(%ebp), %eax
addl %eax, %esp
    movl 12(%ebp), %eax
    movl %eax, 28(%ebp)
    jmp _13be4a12_md__printUInt_bb_1
_13be4a12_md__printUInt_bb_13:
    movl -12(%ebp), %eax
    subl -20(%ebp), %eax
    movl %eax, -12(%ebp)
    movl 48, -112(%ebp)
    pushl -112(%ebp)
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 136; call (%eax)
    addl 16, %esp
    jmp _13be4a12_md__printUInt_bb_14
_13be4a12_md__printUInt_bb_14:
    movl -12(%ebp), %eax
    cmpl -28(%ebp), %eax
    jgt _13be4a12_md__printUInt_bb_13
    jmp _13be4a12_md__printUInt_bb_12
_13be4a12_md__printUInt_bb_15:
    jmp _13be4a12_md__printUInt_bb_1

// method _printHex
_13be4a12_md__printHex:
    pushl %ebp; movl %esp, %ebp
    subl 24, %esp
    pushad
    movl 0, -16(%ebp)
    jmp _13be4a12_md__printHex_bb_2
_13be4a12_md__printHex_bb_1:
    popad
    leave
    ret
_13be4a12_md__printHex_bb_2:
    movl 0, -4(%ebp)
    movl 16(%ebp), %eax
    cmpl -4(%ebp), %eax
    jlt _13be4a12_md__printHex_bb_4
    jmp _13be4a12_md__printHex_bb_5
_13be4a12_md__printHex_bb_3:
    subl 4, %esp
    pushl 20(%ebp)
    pushl 16(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 120; call (%eax)
    addl 16, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _13be4a12_md__printHex_bb_1
_13be4a12_md__printHex_bb_4:
    movl 45, -8(%ebp)
    subl 4, %esp
    pushl -8(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -12(%ebp)
    movl -16(%ebp), %eax
    subl 16(%ebp), %eax
    movl %eax, -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, 16(%ebp)
    jmp _13be4a12_md__printHex_bb_3
_13be4a12_md__printHex_bb_5:
    jmp _13be4a12_md__printHex_bb_3
_13be4a12_md__printHex_bb_6:
    jmp _13be4a12_md__printHex_bb_1

// method _printUHex
_13be4a12_md__printUHex:
    pushl %ebp; movl %esp, %ebp
    subl 24, %esp
    pushad
    jmp _13be4a12_md__printUHex_bb_2
_13be4a12_md__printUHex_bb_1:
    popad
    leave
    ret
_13be4a12_md__printUHex_bb_2:
    movl 48, -4(%ebp)
    subl 4, %esp
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -8(%ebp)
    movl 120, -12(%ebp)
    subl 4, %esp
    pushl -12(%ebp)
    movl -8(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -16(%ebp)
    movl 16, -20(%ebp)
    subl 4, %esp
    pushl 20(%ebp)
    pushl -20(%ebp)
    pushl 16(%ebp)
    movl -16(%ebp), %eax
    pushl %eax; pushl 104; call (%eax)
    addl 20, %esp
    popl -24(%ebp)
    movl -24(%ebp), %eax
    movl %eax, 24(%ebp)
    jmp _13be4a12_md__printUHex_bb_1
_13be4a12_md__printUHex_bb_3:
    jmp _13be4a12_md__printUHex_bb_1

// method _printCStringBuffer
_13be4a12_md__printCStringBuffer:
    pushl %ebp; movl %esp, %ebp
    subl 28, %esp
    pushad
    movl 1, -16(%ebp)
    movl 0, -24(%ebp)
    jmp _13be4a12_md__printCStringBuffer_bb_2
_13be4a12_md__printCStringBuffer_bb_1:
    popad
    leave
    ret
_13be4a12_md__printCStringBuffer_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    jmp _13be4a12_md__printCStringBuffer_bb_5
_13be4a12_md__printCStringBuffer_bb_3:
    movl 12(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _13be4a12_md__printCStringBuffer_bb_1
_13be4a12_md__printCStringBuffer_bb_4:
    subl 4, %esp
    pushl -4(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 48; call (%eax)
    addl 12, %esp
    popl -28(%ebp)
    jmp _13be4a12_md__printCStringBuffer_bb_5
_13be4a12_md__printCStringBuffer_bb_5:
    movl 16(%ebp), %eax
    movl %eax, -12(%ebp)
    movl -12(%ebp), %eax
    addl -16(%ebp), %eax
    movl %eax, 16(%ebp)
    subl 4, %esp
    pushl -12(%ebp)
    movl 12(%ebp), %eax
    pushl %eax; pushl 144; call (%eax)
    addl 12, %esp
    popl -20(%ebp)
    movl -20(%ebp), %eax
    movl %eax, -4(%ebp)
    movl -20(%ebp), %eax
    cmpl -24(%ebp), %eax
    jne _13be4a12_md__printCStringBuffer_bb_4
    jmp _13be4a12_md__printCStringBuffer_bb_3
_13be4a12_md__printCStringBuffer_bb_6:
    jmp _13be4a12_md__printCStringBuffer_bb_1

// method _putChar
_13be4a12_md__putChar:
    pushl %ebp; movl %esp, %ebp
    pushad
    jmp _13be4a12_md__putChar_bb_2
_13be4a12_md__putChar_bb_1:
    popad
    leave
    ret
_13be4a12_md__putChar_bb_2:
    movl 16(%ebp), %eax
    movl 20(%ebp), %ebx
movb %bl, (%eax)
    jmp _13be4a12_md__putChar_bb_1

// method _getChar
_13be4a12_md__getChar:
    pushl %ebp; movl %esp, %ebp
    subl 8, %esp
    pushad
    jmp _13be4a12_md__getChar_bb_2
_13be4a12_md__getChar_bb_1:
    popad
    leave
    ret
_13be4a12_md__getChar_bb_2:
    movl 0, -8(%ebp)
    movl -8(%ebp), %eax
    movl %eax, -4(%ebp)
    movl 16(%ebp), %eax
    movl -4(%ebp), %ebx
movb (%eax), %bl
    movl %ebx, -4(%ebp)
    movl -4(%ebp), %eax
    movl %eax, 20(%ebp)
    jmp _13be4a12_md__getChar_bb_1
_13be4a12_md__getChar_bb_3:
    jmp _13be4a12_md__getChar_bb_1
