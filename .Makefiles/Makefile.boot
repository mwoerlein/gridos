include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
#STARTUP_LIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a
STARTUP_LIBS = KernelJIT.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

LOADER_PARTS = dynamic_settings settings stage0 stage1
LOADER_PASMS = $(patsubst %,$(BOOTDIR)/$(MASCHINE)_loader_%.pasm, $(LOADER_PARTS))
#MODSIMPLE_PARTS = __startup _core Runtime A B
MODSIMPLE_PARTS = __startup Runtime Object_globals Class_globals A_globals B_globals
MODSIMPLE_OBJECT_PARTS = Object
MODSIMPLE_CLASS_PARTS = Class Object_globals
MODSIMPLE_RUNTIME_PARTS = __fake_statics Runtime Object_globals Class_globals
MODSIMPLE_A_PARTS = A Object_globals Class_globals Runtime_globals
MODSIMPLE_B_PARTS = B Object_globals Class_globals Runtime_globals A_globals
MODSIMPLE_PASMS = $(patsubst %,$(MODDIR)/simple/%.pasm, $(MODSIMPLE_PARTS))
MODSIMPLE_OBJECT_PASMS = $(patsubst %,$(MODDIR)/simple/%.pasm, $(MODSIMPLE_OBJECT_PARTS))
MODSIMPLE_CLASS_PASMS = $(patsubst %,$(MODDIR)/simple/%.pasm, $(MODSIMPLE_CLASS_PARTS))
MODSIMPLE_RUNTIME_PASMS = $(patsubst %,$(MODDIR)/simple/%.pasm, $(MODSIMPLE_RUNTIME_PARTS))
MODSIMPLE_A_PASMS = $(patsubst %,$(MODDIR)/simple/%.pasm, $(MODSIMPLE_A_PARTS))
MODSIMPLE_B_PASMS = $(patsubst %,$(MODDIR)/simple/%.pasm, $(MODSIMPLE_B_PARTS))

$(MODDIR)/simple/Runtime_globals.pasm: $(MODSIMPLE_RUNTIME_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_RUNTIME_PASMS) | $(BINDIR)/pasm -g $@ -o /dev/null -

$(MODDIR)/simple/Object_globals.pasm $(BOOTDIR)/Object.pbc: $(MODSIMPLE_OBJECT_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_OBJECT_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/Object.pbc -
#	cat $(MODSIMPLE_OBJECT_PASMS) > $(BOOTDIR)/Object.pbc

$(MODDIR)/simple/Class_globals.pasm $(BOOTDIR)/Class.pbc: $(MODSIMPLE_CLASS_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_CLASS_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/Class.pbc -
#	cat $(MODSIMPLE_CLASS_PASMS) > $(BOOTDIR)/Class.pbc

$(MODDIR)/simple/A_globals.pasm $(BOOTDIR)/A.pbc: $(MODSIMPLE_A_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_A_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/A.pbc -
#	cat $(MODSIMPLE_A_PASMS) > $(BOOTDIR)/A.pbc

$(MODDIR)/simple/B_globals.pasm $(BOOTDIR)/B.pbc: $(MODSIMPLE_B_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_B_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/B.pbc -
#	cat $(MODSIMPLE_B_PASMS) > $(BOOTDIR)/B.pbc

$(BOOTDIR)/mod_store.block: $(BOOTDIR)/A.pbc $(BOOTDIR)/B.pbc
	echo "creating $@"
	$(BINDIR)/store -o $@ -a 512 $(BOOTDIR)/A.pbc $(BOOTDIR)/B.pbc 

$(BOOTDIR)/mod_kernel.block: $(BOOTDIR)/Object.pbc $(BOOTDIR)/Class.pbc $(BOOTDIR)/mod_kernel.bin
	echo "creating $@"
	$(BINDIR)/store -o $@ -a 512 $(BOOTDIR)/Object.pbc $(BOOTDIR)/Class.pbc $(BOOTDIR)/mod_kernel.bin 

$(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm: $(BOOTDIR)/mod_store.block $(BOOTDIR)/mod_kernel.block $(BOOTDIR)/$(MASCHINE)_startup.block
	echo "MOD_KERNEL_SECTORS  := `wc -c $(BOOTDIR)/mod_kernel.block | awk '{print int(($$1+511)/512);}'`" > $@
	echo "MOD_STORE_SECTORS   := `wc -c $(BOOTDIR)/mod_store.block | awk '{print int(($$1+511)/512);}'`" >> $@
	echo "STARTUP_SECTORS     := `wc -c $(BOOTDIR)/$(MASCHINE)_startup.block | awk '{print int(($$1+511)/512);}'`" >> $@

$(BOOTDIR)/$(MASCHINE)_loader.bin: $(LOADER_PASMS)
	echo "creating $@"
	cat $(LOADER_PASMS) | $(BINDIR)/pasm -bo $@ -

$(BOOTDIR)/mod_kernel.bin: $(MODSIMPLE_PASMS) 
	echo "creating $@"
	cat $(MODSIMPLE_PASMS) > $@
#	cp $(MODDIR)/blinking.pasm $@
#	$(BINDIR)/pasm -eo $@ $(MODDIR)/blinking.pasm
#	cp $(MODDIR)/at_relocateable.pasm $@
#	$(BINDIR)/pasm -eo $@ $(MODDIR)/at_relocateable.pasm

$(BOOTDIR)/$(MASCHINE)_startup.bin: $(BOOTDIR)/$(MASCHINE)_startup_entry.o $(BOOTDIR)/$(MASCHINE)_startup.o $(STARTUP_LIBS:%=$(LIBDIR)/%) 
	echo "creating $@"
	ld -e startup_start -Ttext 0x20000 -s --oformat binary -m elf_i386 -o $@ $< $(BOOTDIR)/$(MASCHINE)_startup.o $(LDHEAD) $(STARTUP_LIBS:%=$(LIBDIR)/%) $(LDTAIL)

$(BOOTDIR)/$(MASCHINE)_startup.o: $(BOOTDIR)/$(MASCHINE)_startup.s
	$(AS) $(ASFLAGS) $< -o $@

$(BOOTDIR)/$(MASCHINE)_startup.s: $(BOOTDIR)/$(MASCHINE)_startup.cpp
	$(CC) $(CFLAGS) -I../include -S $< -o $@

$(BOOTDIR)/$(MASCHINE)_startup_entry.s: $(BOOTDIR)/$(MASCHINE)_startup_entry.S
	$(CC) -E -traditional -S -o $@ $<

%.block: %.bin
	echo "creating $@"
	dd if=$< of=$@ bs=512 conv=sync 2>/dev/null

clean:
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s) $(MODDIR)/simple/*_globals.pasm
