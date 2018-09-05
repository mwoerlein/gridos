include ./.Makefiles/Makefile.inc

BOOTBLOCKS=$(BOOTDIR)/$(MASCHINE)_loader.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block $(BOOTDIR)/Kernel-TEXT.block
THIS=$(firstword $(RLIBS))
REST=$(filter-out $(THIS), $(RLIBS))

TESTSUITELIBS = test.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

.PHONY: all clean linux bootdisk libs rlibs disk kernel tests

all: bootdisk
linux: linuxtest
disk: bootdisk
	@dd if=$(IMGDIR)/bootdisk.img of=/dev/floppy/0

bootdisk: $(IMGDIR) $(IMGDIR)/bootdisk.img

tests: clean test/suite
	@test/suite

libs: 
	@$(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(LIBS)" rlibs
rlibs: 
	$(MAKELIB) LIB=$(THIS) $(THIS)
	if [ "$(REST)" != "" ] ; then $(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(REST)" rlibs; fi

$(LIBDIR) $(IMGDIR):
	@mkdir -p $@

$(IMGDIR)/bootdisk.img:$(BOOTBLOCKS)
	@echo "creating $@"
	cat $(BOOTBLOCKS) > $@

$(BOOTDIR)/$(MASCHINE)_%:
	@$(MAKEBOOT) $@

clean:
	@rm -rf $(OBJDIR) $(LIBDIR) ./linuxtest test/suite
	@$(MAKEBOOT) $@
	
$(LIBDIR)/%.a:
	@$(MAKELIB) LIB=$@ $@

linuxtest:./boot/Linux_startup.cpp $(LIBDIR)/KernelJIT.a $(LIBDIR)/Linux.a
	$(CC) -I$(INCDIR) -o $@ $< $(LIBDIR)/KernelJIT.a $(LIBDIR)/Linux.a

$(SRCDIR)/$(MASCHINE)/%.s: $(SRCDIR)/$(MASCHINE)/%.cpp
	$(CC) $(CFLAGS) -S -o $@ $<
$(SRCDIR)/KernelJIT/%.s: $(SRCDIR)/KernelJIT/%.cpp
	$(CC) $(CFLAGS) -S -o $@ $<

kernel: kernel/ObjectKernel.bin kernel/MessageKernel
	@echo "creating Kernel-TEXT"
	@cat kernel/MessageKernel $< > $(BOOTDIR)/Kernel-TEXT
	@rm $< kernel/*.o kernel/*.s

kernel/%.bin: kernel/%.o
	@ld -e run -Ttext 0x94c00 -s --oformat binary -o $@ $<
	
kernel/%.o: kernel/%.s
	@$(AS) $(ASFLAGS) $< -o $@
	
kernel/ObjectKernel.s: kernel/Object_Test.S
	$(CC) -E -S $< -o $@
	
kernel/blinkingKernel.s: kernel/blinkingKernel.c
	@gcc -S $< -o $@

test/suite: test/suite.cpp $(TESTSUITELIBS:%=$(LIBDIR)/%)
	@echo "build test suite"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(TESTSUITELIBS:%=$(LIBDIR)/%)

CompTest: test/CompTest.cpp $(LIBDIR)/Linux.a $(LIBDIR)/sys.a $(LIBDIR)/Pool.a
	$(CC) -DLINUX_ENV -I$(INCDIR) -o $@ $< $(LIBDIR)/Linux.a $(LIBDIR)/Pool.a $(LIBDIR)/sys.a
