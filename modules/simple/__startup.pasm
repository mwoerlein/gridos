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
    
    addl -4, %esp  # return value of findClass
    pushl classname_B
    pushl %edi; pushl Runtime_m_createInstance; call (%edi)
	addl 12, %esp
    popl %ecx; // inst_B (type B)

    pushl 20
    pushl 2
    pushl %ecx; pushl B_m_init; call (%ecx)
	addl 16, %esp
	
	// TODO: instanciate A dynamically and call run(A_INST)
    movl inst_A_1_handle_A, %edx
    pushl 5
    pushl 2
    pushl %edx; pushl A_m_init; call (%edx)
	addl 16, %esp
    
    pushl %ecx; pushl B_m_run; call (%ecx)
	addl 8, %esp

    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt

classname_B:
    .asciz "/my/B"
classname_A:
    .asciz "/my/A"
classname_Object:
    .asciz "/my/Object"
