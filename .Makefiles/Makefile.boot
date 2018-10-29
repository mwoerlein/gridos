include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)
KERNELLIBS = test.a $(MASCHINE).a multiboot2.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

$(BOOTDIR)/$(MASCHINE)_loader_config.s $(BOOTDIR)/$(MASCHINE)_Kernel-TEXT.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block: $(BOOTDIR)/Kernel-TEXT.bin $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin
	echo "#define DISK_HEADS       2" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define DISK_TRACKS      80" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define DISK_SECTORS     36" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define JIT_CMD          \"--test = 0 --debug=2\"" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define JIT_BLOCKS       `dd if=$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin of=$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block bs=512 conv=sync 2>&1 | head -n 2 | tail -n 1 | cut -d '+' -f1`" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define JIT_SIZE         (JIT_BLOCKS << 9)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define JIT_LBA          (GRIDOS_LOADER_SECTORS)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define JIT_SEGMENT      0x2000" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define JIT_OFFSET       0x0000" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define BSS_SEGMENT      (JIT_SEGMENT+((JIT_BLOCKS >> 3) << 8) + 0x200)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define BSS_SIZE         (GRIDOS_BOOTSTRAP_STACK_SIZE + 0x100)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_CMD         \"kernel --debug=1\"" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_BLOCKS      `dd if=$(BOOTDIR)/Kernel-TEXT.bin of=$(BOOTDIR)/Kernel-TEXT.block bs=512 conv=sync 2>&1 | head -n 2 | tail -n 1 | cut -d '+' -f1`">> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_SIZE        (TEXT_BLOCKS << 9)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_LBA         (JIT_LBA+JIT_BLOCKS)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_SEGMENT     (BSS_SEGMENT + (BSS_SIZE >> 4))" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_OFFSET      0x0000" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "#define TEXT_ADDR        ((TEXT_SEGMENT << 4) + TEXT_OFFSET)" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s
	echo "" >> $(BOOTDIR)/$(MASCHINE)_loader_config.s

$(BOOTDIR)/$(MASCHINE)_loader.s: $(BOOTDIR)/$(MASCHINE)_loader.S $(BOOTDIR)/$(MASCHINE)_loader_config.s
	$(CC) -E -traditional -S -o $@ $<

$(BOOTDIR)/$(MASCHINE)_bootstrap_entry.s: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.S
	$(CC) -E -traditional -S -o $@ $<

$(BOOTDIR)/$(MASCHINE)_loader.block: $(BOOTDIR)/$(MASCHINE)_loader.o
	echo "creating $@"
	ld -e loader_start -Ttext 0x0 -s --oformat binary -m elf_i386 -o $@ $<

$(BOOTDIR)/$(MASCHINE)_loader.bin: $(BOOTDIR)/$(MASCHINE)_loader.pasm
	echo "creating $@"
	$(BINDIR)/pasm -bo $@ $<

$(BOOTDIR)/Kernel-TEXT.bin: $(BOOTDIR)/Kernel-TEXT
	echo "creating $@"
	cp $< $@

$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.o $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(KERNELLIBS:%=$(LIBDIR)/%) 
	echo "creating $@"
	ld -e bootstrap_start -Ttext 0x20000 -s --oformat binary -m elf_i386 -o $@ $< $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(LDHEAD) $(KERNELLIBS:%=$(LIBDIR)/%) $(LDTAIL)
#	cp $(BOOTDIR)/../multiboot_example/multiboot2.kernel $@
#	bash -c 'for c in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z; do printf "$$c%.0s" {1..512}; done' > $@
#	dd if=/dev/zero bs=512 count=500 >> $@

$(BOOTDIR)/$(MASCHINE)_bootstrap.o: $(BOOTDIR)/$(MASCHINE)_bootstrap.s
	$(AS) $(ASFLAGS) $< -o $@

$(BOOTDIR)/$(MASCHINE)_bootstrap.s: $(BOOTDIR)/$(MASCHINE)_bootstrap.cpp
	$(CC) $(CFLAGS) -I../include -S $< -o $@

clean:
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s *.OStream)
