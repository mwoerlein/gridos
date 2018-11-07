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
    
    movl inst_A_1_handle_A, %ecx
    pushl 5
    pushl 2
    pushl %ecx; pushl A_m_init; call (%ecx)
	addl 16, %esp
    
    movl inst_B_1_handle_B, %ecx
    pushl 20
    pushl 2
    pushl %ecx; pushl B_m_init; call (%ecx)
	addl 16, %esp
    
    pushl %ecx; pushl B_m_run; call (%ecx)
	addl 8, %esp

    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt
