include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
#STARTUP_LIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a
STARTUP_LIBS = KernelJIT.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

LOADER_PARTS = dynamic_settings settings stage0 stage1
LOADER_PASMS = $(patsubst %,$(BOOTDIR)/$(MASCHINE)_loader_%.pasm, $(LOADER_PARTS))

MOD_SIMPLE_PASMS = $(shell find $(MODDIR)/sys/ $(MODDIR)/my/ -type f -name '*.pasm')
MOD_SIMPLE_FILES = $(patsubst $(MODDIR)/%.pasm, $(BOOTDIR)/%.pbc, $(MOD_SIMPLE_PASMS))

MOD_KERNEL_PASMS = $(shell find $(MODDIR)/gridos/ -type f -name '*.pasm')
MOD_KERNEL_FILES = $(BOOTDIR)/__startup.bin $(patsubst $(MODDIR)/%.pasm, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_PASMS))
#MOD_KERNEL_FILES = $(BOOTDIR)/blinking.bin $(patsubst $(MODDIR)/%.pasm, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_PASMS))
#MOD_KERNEL_FILES = $(MODDIR)/blinking.pasm $(patsubst $(MODDIR)/%.pasm, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_PASMS))
#MOD_KERNEL_FILES = $(BOOTDIR)/at_relocateable.bin $(patsubst $(MODDIR)/%.pasm, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_PASMS))
#MOD_KERNEL_FILES = $(MODDIR)/at_relocateable.pasm $(patsubst $(MODDIR)/%.pasm, $(BOOTDIR)/%.pbc, $(MOD_KERNEL_PASMS))

$(BOOTDIR)/gridos/Runtime.pbc: $(MODDIR)/gridos/Runtime.pasm $(PASM)
	echo "creating $@ with bootstrap"
	mkdir -p $(dir $@)
	$(PASM) -co $@ $< --bootstrap=_gridos_Runtime_mdo_bootstrap

$(BOOTDIR)/%.pbc: $(MODDIR)/%.pasm $(PASM)
	echo "creating $@"
	mkdir -p $(dir $@)
	$(PASM) -co $@ $<

$(BOOTDIR)/%.bin: $(MODDIR)/%.pasm $(PASM)
	echo "creating $@"
	$(PASM) -eo $@ $<

$(BOOTDIR)/mod_store.block: $(MOD_SIMPLE_FILES) $(STORE)
	echo "creating $@"
	$(STORE) -o $@ -a 512 $(MOD_SIMPLE_FILES) 

$(BOOTDIR)/mod_kernel.block: $(MOD_KERNEL_FILES) $(STORE)
	echo "creating $@"
	$(STORE) -o $@ -a 512 $(MOD_KERNEL_FILES) 

$(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm: $(BOOTDIR)/mod_store.block $(BOOTDIR)/mod_kernel.block $(BOOTDIR)/$(MASCHINE)_startup.block
	echo "MOD_KERNEL_SECTORS  := `wc -c $(BOOTDIR)/mod_kernel.block | awk '{print int(($$1+511)/512);}'`" > $@
	echo "MOD_STORE_SECTORS   := `wc -c $(BOOTDIR)/mod_store.block | awk '{print int(($$1+511)/512);}'`" >> $@
	echo "STARTUP_SECTORS     := `wc -c $(BOOTDIR)/$(MASCHINE)_startup.block | awk '{print int(($$1+511)/512);}'`" >> $@

$(BOOTDIR)/$(MASCHINE)_startup.block: $(BOOTDIR)/$(MASCHINE)_cpp_startup.bin
#$(BOOTDIR)/$(MASCHINE)_startup.block: $(BOOTDIR)/$(MASCHINE)_pool_startup.bin
	echo "creating $@"
	dd if=$< of=$@ bs=512 conv=sync 2>/dev/null
	
$(BOOTDIR)/$(MASCHINE)_loader.bin: $(LOADER_PASMS) $(PASM)
	echo "creating $@"
	cat $(LOADER_PASMS) | $(PASM) -bo $@ -

$(BOOTDIR)/$(MASCHINE)_cpp_startup.bin: $(BOOTDIR)/$(MASCHINE)_startup_entry.o $(BOOTDIR)/$(MASCHINE)_startup.o $(STARTUP_LIBS:%=$(LIBDIR)/%) 
	echo "creating $@"
	ld -e startup_start -Ttext 0x20000 -s --oformat binary -m elf_i386 -o $@ $< $(BOOTDIR)/$(MASCHINE)_startup.o $(LDHEAD) $(STARTUP_LIBS:%=$(LIBDIR)/%) $(LDTAIL)

$(BOOTDIR)/$(MASCHINE)_pool_startup.bin: 
	echo "creating $@"
	@$(POOLSC) $(PC_FLAGS) --output $@ gridos::i386::Startup --binding gridos::i386::mb2 -t 0x20000

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
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s) $(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm  
	@rm -rf $(BOOTDIR)/gridos $(BOOTDIR)/sys $(BOOTDIR)/my
