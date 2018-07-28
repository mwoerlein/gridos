include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)

$(BOOTDIR)/$(MASCHINE)_loader_config.s $(BOOTDIR)/$(MASCHINE)_Kernel-TEXT.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block: $(BOOTDIR)/Kernel-TEXT.bin $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin
	echo "#define BOOTDEVICE       0" > $@ #FD0 =0 FD1=1 ... HD0=128 HD1=129 ...
	echo "#define DISK_HEADS       2" >> $@
	echo "#define DISK_TRACKS      80" >> $@
	echo "#define DISK_SECTORS     36" >> $@
	echo "#define STACK_SIZE       0x3000" >> $@
	echo "#define GRIDOS_BOOTSTRAP_STACK_SIZE 0x4000" >> $@
	echo "" >> $@
	echo "#define LOADMESSAGE      \"Loading \"" >> $@
	echo "" >> $@
	echo "#define JIT_BLOCKS       `dd if=$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin of=$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block bs=512 conv=sync 2>&1 | head -n 2 | tail -n 1 | cut -d '+' -f1`" >> $@
	echo "#define JIT_SIZE         (JIT_BLOCKS << 9)" >> $@
	echo "#define JIT_HEAD         0" >> $@
	echo "#define JIT_TRACK        0" >> $@
	echo "#define JIT_SECTOR       (GRIDOS_LOADER_SECTORS + 1)" >> $@
	echo "#define JIT_SEGMENT      0x6000" >> $@
	echo "#define JIT_OFFSET       0x0000" >> $@
	echo "#define BSS_SEGMENT      (JIT_SEGMENT+((JIT_BLOCKS >> 3) << 8) + 0x200)" >> $@
	echo "#define BSS_SIZE         (GRIDOS_BOOTSTRAP_STACK_SIZE + 0x100)" >> $@
	echo "" >> $@
	echo "#define TEXT_BLOCKS      `dd if=$(BOOTDIR)/Kernel-TEXT.bin of=$(BOOTDIR)/Kernel-TEXT.block bs=512 conv=sync 2>&1 | head -n 2 | tail -n 1 | cut -d '+' -f1`">> $@
	echo "#define TEXT_SIZE        (TEXT_BLOCKS << 9)" >> $@
	echo "#define TEXT_HEAD        (((JIT_SECTOR+JIT_BLOCKS-1)/DISK_SECTORS)%DISK_HEADS)" >> $@
	echo "#define TEXT_TRACK       ((((JIT_SECTOR+JIT_BLOCKS-1)/DISK_SECTORS)/DISK_HEADS)%DISK_TRACKS)" >> $@
	echo "#define TEXT_SECTOR      ((JIT_SECTOR+JIT_BLOCKS-1)%DISK_SECTORS)+1" >> $@
	echo "#define TEXT_SEGMENT     (BSS_SEGMENT + (BSS_SIZE >> 4))" >> $@
#	echo "#define TEXT_SEGMENT     0x7000" >> $@
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

$(BOOTDIR)/Kernel-TEXT.bin: $(BOOTDIR)/Kernel-TEXT
	echo "creating $@"
	cp $< $@

$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.o $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(LIBDIR)/KernelJIT.a $(LIBDIR)/$(MASCHINE).a $(LIBDIR)/memory.a $(LIBDIR)/sys.a $(LIBDIR)/multiboot2.a 
	echo "creating $@"
	ld -e bootstrap_start -Ttext 0x60000 -s --oformat binary -m elf_i386 -o $@ $< $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(LDHEAD) $(LIBDIR)/$(MASCHINE).a $(LIBDIR)/KernelJIT.a $(LIBDIR)/memory.a $(LIBDIR)/sys.a $(LIBDIR)/multiboot2.a $(LDTAIL)
#	cp $(BOOTDIR)/../multiboot_example/multiboot2.kernel $@
#	bash -c 'for c in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z; do printf "$$c%.0s" {1..512}; done' > $@
#	dd if=/dev/zero bs=512 count=500 >> $@

$(BOOTDIR)/$(MASCHINE)_bootstrap.o: $(BOOTDIR)/$(MASCHINE)_bootstrap.s
	$(AS) $(ASFLAGS) $< -o $@

$(BOOTDIR)/$(MASCHINE)_bootstrap.s: $(BOOTDIR)/$(MASCHINE)_bootstrap.cpp
	$(CC) $(CFLAGS) -I../include -S $< -o $@

$(LIBDIR)/%.a:
	$(MAKELIB) LIB=$@ $@

clean:
	@rm -rf $(addprefix $(BOOTDIR)/, *.bin *.block *.o *.s *.OStream)
