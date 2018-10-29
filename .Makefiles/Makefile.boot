include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
KERNELLIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

LOADER_PARTS = dynamic_settings settings stage0 stage1
LOADER_PASMS=$(patsubst %,$(BOOTDIR)/$(MASCHINE)_loader_%.pasm, $(LOADER_PARTS))

$(BOOTDIR)/$(MASCHINE)_loader_config.s: $(BOOTDIR)/Kernel-TEXT.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block
	echo "#define DISK_HEADS       2" >> $@
	echo "#define DISK_TRACKS      80" >> $@
	echo "#define DISK_SECTORS     36" >> $@
	echo "" >> $@
	echo "#define JIT_CMD          \"--test = 0 --debug=2\"" >> $@
	echo "#define JIT_BLOCKS       `wc -c $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block | awk '{print int(($$1+511)/512);}'`" >> $@
	echo "#define JIT_SIZE         (JIT_BLOCKS << 9)" >> $@
	echo "#define JIT_LBA          (GRIDOS_LOADER_SECTORS)" >> $@
	echo "#define JIT_SEGMENT      0x2000" >> $@
	echo "#define JIT_OFFSET       0x0000" >> $@
	echo "#define BSS_SEGMENT      (JIT_SEGMENT+((JIT_BLOCKS >> 3) << 8) + 0x200)" >> $@
	echo "#define BSS_SIZE         (GRIDOS_BOOTSTRAP_STACK_SIZE + 0x100)" >> $@
	echo "" >> $@
	echo "#define TEXT_CMD         \"kernel --debug=1\"" >> $@
	echo "#define TEXT_BLOCKS      `wc -c $(BOOTDIR)/Kernel-TEXT.block | awk '{print int(($$1+511)/512);}'`">> $@
	echo "#define TEXT_SIZE        (TEXT_BLOCKS << 9)" >> $@
	echo "#define TEXT_LBA         (JIT_LBA+JIT_BLOCKS)" >> $@
	echo "#define TEXT_SEGMENT     (BSS_SEGMENT + (BSS_SIZE >> 4))" >> $@
	echo "#define TEXT_OFFSET      0x0000" >> $@
	echo "#define TEXT_ADDR        ((TEXT_SEGMENT << 4) + TEXT_OFFSET)" >> $@
	echo "" >> $@

$(BOOTDIR)/$(MASCHINE)_loader.s: $(BOOTDIR)/$(MASCHINE)_loader.S $(BOOTDIR)/$(MASCHINE)_loader_config.s
	$(CC) -E -traditional -S -o $@ $<

$(BOOTDIR)/$(MASCHINE)_bootstrap_entry.s: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.S
	$(CC) -E -traditional -S -o $@ $<

$(BOOTDIR)/$(MASCHINE)_loader.block: $(BOOTDIR)/$(MASCHINE)_loader.o
	echo "creating $@"
	ld -e loader_start -Ttext 0x0 -s --oformat binary -m elf_i386 -o $@ $<

$(BOOTDIR)/$(MASCHINE)_loader_dynamic_settings.pasm: $(BOOTDIR)/Kernel-TEXT.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block
	echo "MOD_TEXT_SECTORS    := `wc -c $(BOOTDIR)/Kernel-TEXT.block | awk '{print int(($$1+511)/512);}'`" > $@
	echo "STARTUP_SECTORS     := `wc -c $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block | awk '{print int(($$1+511)/512);}'`" >> $@

$(BOOTDIR)/$(MASCHINE)_loader.bin: $(LOADER_PASMS)
	echo "creating $@"
	cat $(LOADER_PASMS) > /tmp/loader.pasm
	$(BINDIR)/pasm -bo $@ /tmp/loader.pasm

$(BOOTDIR)/Kernel-TEXT.bin: $(BOOTDIR)/Kernel-TEXT
	echo "creating $@"
	cp $< $@

$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.o $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(KERNELLIBS:%=$(LIBDIR)/%) 
	echo "creating $@"
	ld -e bootstrap_start -Ttext 0x20000 -s --oformat binary -m elf_i386 -o $@ $< $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(LDHEAD) $(KERNELLIBS:%=$(LIBDIR)/%) $(LDTAIL)

$(BOOTDIR)/$(MASCHINE)_bootstrap.o: $(BOOTDIR)/$(MASCHINE)_bootstrap.s
	$(AS) $(ASFLAGS) $< -o $@

$(BOOTDIR)/$(MASCHINE)_bootstrap.s: $(BOOTDIR)/$(MASCHINE)_bootstrap.cpp
	$(CC) $(CFLAGS) -I../include -S $< -o $@

%.block: %.bin
	echo "creating $@"
	dd if=$< of=$@ bs=512 conv=sync 2>/dev/null

clean:
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s *.OStream)
