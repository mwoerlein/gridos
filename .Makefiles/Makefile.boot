include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
#STARTUP_LIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a
STARTUP_LIBS = KernelJIT.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

LOADER_PARTS = dynamic_settings settings stage0 stage1
LOADER_PASMS = $(patsubst %,$(BOOTDIR)/$(MASCHINE)_loader_%.pasm, $(LOADER_PARTS))

MOD_SIMPLE_CLASSES = A B
MOD_SIMPLE_FILES = $(patsubst %, $(BOOTDIR)/my/%.pbc, $(MOD_SIMPLE_CLASSES))

MOD_KERNEL_CLASSES = Object Class Thread OStream Runtime RuntimeOStream
MOD_KERNEL_FILES = $(BOOTDIR)/__startup.bin $(patsubst %, $(BOOTDIR)/my/core/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(BOOTDIR)/blinking.bin $(patsubst %, $(BOOTDIR)/my/core/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(MODDIR)/blinking.pasm $(patsubst %, $(BOOTDIR)/my/core/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(BOOTDIR)/at_relocateable.bin $(patsubst %, $(BOOTDIR)/my/core/%.pbc, $(MOD_KERNEL_CLASSES))
#MOD_KERNEL_FILES = $(MODDIR)/at_relocateable.pasm $(patsubst %, $(BOOTDIR)/my/core/%.pbc, $(MOD_KERNEL_CLASSES))

$(BOOTDIR)/my/core/Runtime.pbc: $(MODDIR)/my/core/Runtime.pasm $(BINDIR)/pasm
	echo "creating $@ with bootstrap"
	mkdir -p $(dir $@)
	$(BINDIR)/pasm -co $@ $< --bootstrap=_my_core_Runtime_mdo_bootstrap

$(BOOTDIR)/%.pbc: $(MODDIR)/%.pasm $(BINDIR)/pasm
	echo "creating $@"
	mkdir -p $(dir $@)
	$(BINDIR)/pasm -co $@ $<

$(BOOTDIR)/%.bin: $(MODDIR)/%.pasm $(BINDIR)/pasm
	echo "creating $@"
	$(BINDIR)/pasm -eo $@ $<

$(BOOTDIR)/mod_store.block: $(MOD_SIMPLE_FILES) $(BINDIR)/store
	echo "creating $@"
	$(BINDIR)/store -o $@ -a 512 $(MOD_SIMPLE_FILES) 

$(BOOTDIR)/mod_kernel.block: $(MOD_KERNEL_FILES) $(BINDIR)/store
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
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s) $(BOOTDIR)/my $(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm
