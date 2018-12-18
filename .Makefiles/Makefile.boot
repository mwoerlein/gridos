include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
#STARTUP_LIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a
STARTUP_LIBS = KernelJIT.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

LOADER_PARTS = dynamic_settings settings stage0 stage1
LOADER_PASMS = $(patsubst %,$(BOOTDIR)/$(MASCHINE)_loader_%.pasm, $(LOADER_PARTS))

MODSIMPLE_STARTUP_PARTS = Object_globals Class_globals Runtime_globals Thread_globals
MODSIMPLE_OBJECT_PARTS = Object
MODSIMPLE_THREAD_PARTS = Thread Object_globals
MODSIMPLE_CLASS_PARTS = Class Object_globals
MODSIMPLE_RUNTIME_PARTS = Runtime Object_globals Class_globals
MODSIMPLE_A_PARTS = A core/Object_globals core/Class_globals core/Runtime_globals
MODSIMPLE_B_PARTS = B core/Object_globals core/Class_globals core/Runtime_globals core/Thread_globals A_globals
MODSIMPLE_STARTUP_PASMS = $(MODDIR)/simple/__startup.pasm $(MODSIMPLE_STARTUP_PARTS:%=$(MODDIR)/my/core/%.pasm) 
MODSIMPLE_OBJECT_PASMS = $(MODSIMPLE_OBJECT_PARTS:%=$(MODDIR)/my/core/%.pasm) 
MODSIMPLE_THREAD_PASMS = $(MODSIMPLE_THREAD_PARTS:%=$(MODDIR)/my/core/%.pasm) 
MODSIMPLE_CLASS_PASMS = $(MODSIMPLE_CLASS_PARTS:%=$(MODDIR)/my/core/%.pasm) 
MODSIMPLE_RUNTIME_PASMS = $(MODSIMPLE_RUNTIME_PARTS:%=$(MODDIR)/my/core/%.pasm) 
MODSIMPLE_A_PASMS = $(MODSIMPLE_A_PARTS:%=$(MODDIR)/my/%.pasm) 
MODSIMPLE_B_PASMS = $(MODSIMPLE_B_PARTS:%=$(MODDIR)/my/%.pasm) 

MOD_SIMPLE_CLASSES = A B
MOD_SIMPLE_FILES = $(patsubst %, $(BOOTDIR)/%.pbc, $(MOD_SIMPLE_CLASSES))

MOD_KERNEL_CLASSES = Object Thread Class Runtime
MOD_KERNEL_FILES = $(BOOTDIR)/__startup.bin $(patsubst %, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(BOOTDIR)/blinking.bin $(patsubst %, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(MODDIR)/blinking.pasm $(patsubst %, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(BOOTDIR)/at_relocateable.bin $(patsubst %, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(MODDIR)/at_relocateable.pasm $(patsubst %, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_CLASSES))


$(BOOTDIR)/__startup.bin: $(MODSIMPLE_STARTUP_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_STARTUP_PASMS) | $(BINDIR)/pasm -eo $(BOOTDIR)/__startup.bin -
#	cat $(MODSIMPLE_STARTUP_PASMS) > $(BOOTDIR)/__startup.bin

$(MODDIR)/my/core/Runtime_globals.pasm $(BOOTDIR)/Runtime.pbc: $(MODSIMPLE_RUNTIME_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_RUNTIME_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/Runtime.pbc --bootstrap=_my_core_Runtime_mdo_bootstrap -
#	cat $(MODSIMPLE_RUNTIME_PASMS) > $(BOOTDIR)/Runtime.pbc

$(MODDIR)/my/core/Object_globals.pasm $(BOOTDIR)/Object.pbc: $(MODSIMPLE_OBJECT_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_OBJECT_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/Object.pbc -
#	cat $(MODSIMPLE_OBJECT_PASMS) > $(BOOTDIR)/Object.pbc

$(MODDIR)/my/core/Thread_globals.pasm $(BOOTDIR)/Thread.pbc: $(MODSIMPLE_THREAD_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_THREAD_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/Thread.pbc -
#	cat $(MODSIMPLE_THREAD_PASMS) > $(BOOTDIR)/Thread.pbc

$(MODDIR)/my/core/Class_globals.pasm $(BOOTDIR)/Class.pbc: $(MODSIMPLE_CLASS_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_CLASS_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/Class.pbc -
#	cat $(MODSIMPLE_CLASS_PASMS) > $(BOOTDIR)/Class.pbc

$(MODDIR)/my/A_globals.pasm $(BOOTDIR)/A.pbc: $(MODSIMPLE_A_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_A_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/A.pbc -
#	cat $(MODSIMPLE_A_PASMS) > $(BOOTDIR)/A.pbc

$(MODDIR)/my/B_globals.pasm $(BOOTDIR)/B.pbc: $(MODSIMPLE_B_PASMS)
	echo "creating $@"
	cat $(MODSIMPLE_B_PASMS) | $(BINDIR)/pasm -g $@ -co $(BOOTDIR)/B.pbc -
#	cat $(MODSIMPLE_B_PASMS) > $(BOOTDIR)/B.pbc

$(BOOTDIR)/%.bin: $(MODDIR)/%.pasm
	echo "creating $@"
	$(BINDIR)/pasm -eo $@ $<

$(BOOTDIR)/mod_store.block: $(MOD_SIMPLE_FILES)
	echo "creating $@"
	$(BINDIR)/store -o $@ -a 512 $(MOD_SIMPLE_FILES) 

$(BOOTDIR)/mod_kernel.block: $(MOD_KERNEL_FILES)
	echo "creating $@"
	$(BINDIR)/store -o $@ -a 512 $(MOD_KERNEL_FILES) 

$(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm: $(BOOTDIR)/mod_store.block $(BOOTDIR)/mod_kernel.block $(BOOTDIR)/$(MASCHINE)_startup.block
	echo "MOD_KERNEL_SECTORS  := `wc -c $(BOOTDIR)/mod_kernel.block | awk '{print int(($$1+511)/512);}'`" > $@
	echo "MOD_STORE_SECTORS   := `wc -c $(BOOTDIR)/mod_store.block | awk '{print int(($$1+511)/512);}'`" >> $@
	echo "STARTUP_SECTORS     := `wc -c $(BOOTDIR)/$(MASCHINE)_startup.block | awk '{print int(($$1+511)/512);}'`" >> $@

$(BOOTDIR)/$(MASCHINE)_loader.bin: $(LOADER_PASMS)
	echo "creating $@"
	cat $(LOADER_PASMS) | $(BINDIR)/pasm -bo $@ -

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
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s) $(MODDIR)/*/*_globals.pasm $(MODDIR)/*/*/*_globals.pasm $(MODDIR)/*/*/*/*_globals.pasm
