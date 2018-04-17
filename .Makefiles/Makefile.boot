include ./.Makefiles/Makefile.inc

LDHEAD =# $(shell g++ --print-file-name=crti.o && g++ --print-file-name=crtbegin.o)
LDTAIL =# $(shell g++ --print-file-name=crtend.o && g++ --print-file-name=crtn.o)

$(BOOTDIR)/$(MASCHINE)_bootsect_config.s $(BOOTDIR)/$(MASCHINE)_Kernel-TEXT.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block: $(BOOTDIR)/Kernel-TEXT.bin $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin
	echo "#define BOOTDEVICE       0" > $@ #FD0 =0 FD1=1 ... HD0=128 HD1=129 ...
	echo "#define DISK_HEADS       2" >> $@
	echo "#define DISK_TRACKS      80" >> $@
	echo "#define DISK_SECTORS     36" >> $@
	echo "#define STACK_SIZE       0x3000" >> $@
	echo "" >> $@
	echo "#define LOADMESSAGE      \"Loading \"" >> $@
	echo "" >> $@
	echo "#define JIT_BLOCKS       `dd if=$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin of=$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block bs=512 conv=sync 2>&1 | head -n 2 | tail -n 1 | cut -d '+' -f1`" >> $@
	echo "#define JIT_SIZE         (512*JIT_BLOCKS)" >> $@
	echo "#define JIT_HEAD         0" >> $@
	echo "#define JIT_TRACK        0" >> $@
	echo "#define JIT_SECTOR       2" >> $@
	echo "#define JIT_SEGMENT      0x7020" >> $@
	echo "#define JIT_OFFSET       0x0000" >> $@
	echo "" >> $@
	echo "#define TEXT_BLOCKS      `dd if=$(BOOTDIR)/Kernel-TEXT.bin of=$(BOOTDIR)/Kernel-TEXT.block bs=512 conv=sync 2>&1 | head -n 2 | tail -n 1 | cut -d '+' -f1`">> $@
	echo "#define TEXT_SIZE        (512*TEXT_BLOCKS)" >> $@
	echo "#define TEXT_HEAD        (((JIT_SECTOR+JIT_BLOCKS-1)/DISK_SECTORS)%DISK_HEADS)" >> $@
	echo "#define TEXT_TRACK       ((((JIT_SECTOR+JIT_BLOCKS-1)/DISK_SECTORS)/DISK_HEADS)%DISK_TRACKS)" >> $@
	echo "#define TEXT_SECTOR      ((JIT_SECTOR+JIT_BLOCKS-1)%DISK_SECTORS)+1" >> $@
	echo "#define TEXT_SEGMENT     0x1000" >> $@
	echo "#define TEXT_OFFSET      0" >> $@
	echo "" >> $@

$(BOOTDIR)/$(MASCHINE)_bootsect.s: $(BOOTDIR)/$(MASCHINE)_bootsect.S $(BOOTDIR)/$(MASCHINE)_bootsect_config.s
	$(CC) -E -traditional -S -o $@ $<

$(BOOTDIR)/$(MASCHINE)_bootstrap_entry.s: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.S
	$(CC) -E -traditional -S -o $@ $<

$(BOOTDIR)/$(MASCHINE)_bootsect.block: $(BOOTDIR)/$(MASCHINE)_bootsect.o
	echo "creating $@"
	ld -e boot_start -Ttext 0x0 -s --oformat binary -m elf_i386 -o $@ $<

$(BOOTDIR)/Kernel-TEXT.bin: $(BOOTDIR)/Kernel-TEXT
	echo "creating $@"
	cp $< $@

$(BOOTDIR)/$(MASCHINE)_Kernel-JIT.bin: $(BOOTDIR)/$(MASCHINE)_bootstrap_entry.o $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(LIBDIR)/KernelJIT.a $(LIBDIR)/$(MASCHINE).a
	echo "creating $@"
	ld -e _bootstrap -Ttext 0x70200 -s --oformat binary -m elf_i386 -o $@ $< $(BOOTDIR)/$(MASCHINE)_bootstrap.o $(LDHEAD) $(LIBDIR)/$(MASCHINE).a $(LIBDIR)/KernelJIT.a $(LDTAIL)
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
