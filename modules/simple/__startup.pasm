/*[meta]
mimetype = text/x-pasm
description = Dies ist ein erster Test mit Klassen
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
entry = true
*/
/* STARTUP */
entry:
    movw 0xc40, (cga_testline)
    
    call _init_Runtime
    movl classname_B, %ebx
    
    movl %eax, %edi
    
    subl 4, %esp  # return value of createInstance
    pushl %ebx
    pushl %edi; pushl Runtime_m_createInstance; call (%edi)
	addl 12, %esp
    popl %ecx; // inst_B (type B)
    addl 0, %ecx; jz halt // break if not instantiated
    
    // TODO: cast to thread
    
    pushl %ecx; pushl B_m_run; call (%ecx)
	addl 8, %esp
    
    pushl %ecx
    pushl %edi; pushl Runtime_m_destroyInstance; call (%edi)
	addl 12, %esp
    
    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt

classname_B:
    .asciz "/my/B"

print_cga_buffer  := 0xB8000
print_line_offset := 160
test_row := 10
cga_testline  := (print_cga_buffer + (test_row * print_line_offset))
