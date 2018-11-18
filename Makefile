include ./.Makefiles/Makefile.inc

BOOTBLOCKS=$(BOOTDIR)/$(MASCHINE)_loader.bin $(BOOTDIR)/mod_kernel.block $(BOOTDIR)/$(MASCHINE)_startup.block $(BOOTDIR)/mod_A.block $(BOOTDIR)/mod_B.block
THIS=$(firstword $(RLIBS))
REST=$(filter-out $(THIS), $(RLIBS))

TESTSUITELIBS = test.a KernelJIT.a $(MASCHINE)ASM.a linux.a memory.a sys.a
PASMLIBS = $(MASCHINE)ASM.a linux.a memory.a sys.a

.PHONY: all clean libs rlibs tests

all: clean $(IMGDIR)/bootdisk.img

tests: clean $(BINDIR)/testsuite
	@$(BINDIR)/testsuite

libs: 
	@$(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(LIBS)" rlibs
rlibs: 
	$(MAKELIB) LIB=$(THIS) $(THIS)
	if [ "$(REST)" != "" ] ; then $(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(REST)" rlibs; fi

$(LIBDIR) $(IMGDIR) $(BINDIR):
	@mkdir -p $@

$(IMGDIR)/bootdisk.img: $(IMGDIR) $(BOOTBLOCKS)
	@echo "creating $@"
	@cat $(BOOTBLOCKS) > $@

$(BOOTDIR)/$(MASCHINE)_%:
	@$(MAKEBOOT) $@

clean:
	@rm -rf $(OBJDIR) $(LIBDIR) test/suite
	@$(MAKEBOOT) $@

$(BINDIR)/testsuite: $(SRCDIR)/commands/testsuite.cpp $(TESTSUITELIBS:%=$(LIBDIR)/%) $(BINDIR)
	@echo "build test suite"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(TESTSUITELIBS:%=$(LIBDIR)/%)

$(BINDIR)/pasm: $(SRCDIR)/commands/pasm.cpp $(PASMLIBS:%=$(LIBDIR)/%) $(BINDIR)
	@echo "build pasm"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(PASMLIBS:%=$(LIBDIR)/%)
