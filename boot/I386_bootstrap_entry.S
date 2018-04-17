.extern _Z9bootstrapP7memlist
.text
.global _bootstrap
_bootstrap:
	pushl %eax                   # arg *memlist
	call _Z9bootstrapP7memlist
_halt:
	hlt
	jmp _halt
