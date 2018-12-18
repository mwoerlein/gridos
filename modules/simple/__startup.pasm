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
    
    movl %eax, %edi
    
    subl 4, %esp  # return value of createThread
    pushl %ebx
    pushl %edi; pushl _my_core_Runtime_m_createThread; call (%edi)
	addl 12, %esp
    popl %ecx; // @instance (type "Thread")
    addl 0, %ecx; jz halt // break if not instantiated
    
    pushl %ecx; pushl _my_core_Thread_m_run; call (%ecx)
	addl 8, %esp
    
    pushl %ecx
    pushl %edi; pushl _my_core_Runtime_m_destroyInstance; call (%edi)
	addl 12, %esp
    
    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt

print_cga_buffer  := 0xB8000
print_line_offset := 160
test_row := 10
cga_testline  := (print_cga_buffer + (test_row * print_line_offset))
