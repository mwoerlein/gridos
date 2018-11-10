/*[meta]
mimetype = text/x-pasm
description = Dies ist ein erster Test mit Klassen
author = Marc Woerlein<marc.woerlein@gmx.de>
[pool]
version = 0.2.0+20181102070000
*/
/* STARTUP */
entry:
    movw 0xc40, (cga_testline)
    
    movl inst_Runtime_handle_Runtime, %edi
    
    addl -4, %esp  # return value of createInstance
    pushl classname_B
    pushl %edi; pushl Runtime_m_createInstance; call (%edi)
	addl 12, %esp
    popl %ecx; // inst_B (type B)
    
    pushl 20
    pushl 2
    pushl %ecx; pushl B_m_init; call (%ecx)
	addl 16, %esp
	
    addl -4, %esp  # return value of createInstance
    pushl classname_A
    pushl %edi; pushl Runtime_m_createInstance; call (%edi)
	addl 12, %esp
    popl %edx; // inst_A (type A)
    
    pushl 5
    pushl 2
    pushl %edx; pushl A_m_init; call (%edx)
	addl 16, %esp
    
    pushl %edx    
    pushl %ecx; pushl B_m_run; call (%ecx)
	addl 12, %esp
    
    pushl %edx
    pushl %edi; pushl Runtime_m_destroyInstance; call (%edi)
	addl 12, %esp
    
    pushl %ecx
    pushl %edi; pushl Runtime_m_destroyInstance; call (%edi)
	addl 12, %esp
    
    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt

classname_B:
    .asciz "/my/B"
classname_A:
    .asciz "/my/A"
