include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
#STARTUP_LIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a
STARTUP_LIBS = KernelJIT.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

LOADER_PARTS = dynamic_settings settings stage0 stage1
LOADER_PASMS=$(patsubst %,$(BOOTDIR)/$(MASCHINE)_loader_%.pasm, $(LOADER_PARTS))

$(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm: $(BOOTDIR)/mod_kernel.block $(BOOTDIR)/$(MASCHINE)_startup.block
	echo "MOD_KERNEL_SECTORS  := `wc -c $(BOOTDIR)/mod_kernel.block | awk '{print int(($$1+511)/512);}'`" > $@
	echo "STARTUP_SECTORS     := `wc -c $(BOOTDIR)/$(MASCHINE)_startup.block | awk '{print int(($$1+511)/512);}'`" >> $@

$(BOOTDIR)/$(MASCHINE)_loader.bin: $(LOADER_PASMS)
	echo "creating $@"
	cat $(LOADER_PASMS) | $(BINDIR)/pasm -bo $@ -

$(BOOTDIR)/mod_kernel.bin: 
	echo "creating $@"
	cp $(MODDIR)/simple_class.pasm $@
#	cp $(MODDIR)/blinking.pasm $@
#	$(BINDIR)/pasm -o $@ $(MODDIR)/blinking.pasm
#	cp $(MODDIR)/at_relocateable.pasm $@
#	$(BINDIR)/pasm -o $@ $(MODDIR)/at_relocateable.pasm

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
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s)
