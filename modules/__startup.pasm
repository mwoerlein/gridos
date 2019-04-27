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
// TODO #3: inline method-indices in method-call-generation
//*/
    _sys_core_Runtime_m_createAndRunThread := 104
//*/
    movw 0xc40, (cga_testline)
    
    pushl %ebx
    pushl %eax; pushl _sys_core_Runtime_m_createAndRunThread; call (%eax)
	addl 12, %esp
    
    movw 0xf40, (cga_testline)
halt:
	hlt
	jmp halt

print_cga_buffer  := 0xB8000
print_line_offset := 160
test_row := 10
cga_testline  := (print_cga_buffer + (test_row * print_line_offset))
