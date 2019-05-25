include ./.Makefiles/Makefile.inc

BOOTBLOCKS=$(BOOTDIR)/$(MASCHINE)_loader.bin $(BOOTDIR)/mod_kernel.block $(BOOTDIR)/$(MASCHINE)_startup.block $(BOOTDIR)/mod_store.block
THIS=$(firstword $(RLIBS))
REST=$(filter-out $(THIS), $(RLIBS))

TESTSUITELIBS = test.a KernelJIT.a $(MASCHINE)ASM.a linux.a memory.a sys.a
PASMLIBS = $(MASCHINE)ASM.a linux.a memory.a sys.a
STORELIBS = linux.a memory.a sys.a

.PHONY: all clean libs rlibs tests poolsrc

all: clean poolsrc $(IMGDIR)/bootdisk.img

tests: clean $(BINDIR)/testsuite
	@$(BINDIR)/testsuite

libs: 
	@$(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(LIBS)" rlibs
rlibs: 
	$(MAKELIB) LIB=$(THIS) $(THIS)
	if [ "$(REST)" != "" ] ; then $(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(REST)" rlibs; fi

poolsrc:
	@$(POOLC) $(PC_FLAGS) --output $(MODDIR) gridos::KernelThread gridos::Runtime -r

$(LIBDIR) $(IMGDIR) $(BINDIR):
	@mkdir -p $@

$(IMGDIR)/bootdisk.img: $(IMGDIR) $(BOOTBLOCKS)
	@echo "creating $@"
	@cat $(BOOTBLOCKS) > $@

$(BOOTDIR)/$(MASCHINE)_%:
	@$(MAKEBOOT) $@

clean:
	@rm -rf $(OBJDIR) $(LIBDIR) $(BINDIR)
	@rm -rf $(MODDIR)/gridos $(MODDIR)/sys $(MODDIR)/my
	@$(MAKEBOOT) $@

$(BINDIR)/testsuite: $(SRCDIR)/commands/testsuite.cpp $(TESTSUITELIBS:%=$(LIBDIR)/%) $(BINDIR)
	@echo "build test suite"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(TESTSUITELIBS:%=$(LIBDIR)/%)

$(BINDIR)/pasm: $(SRCDIR)/commands/pasm.cpp $(PASMLIBS:%=$(LIBDIR)/%) $(BINDIR)
	@echo "build pasm"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(PASMLIBS:%=$(LIBDIR)/%)

$(BINDIR)/store: $(SRCDIR)/commands/store.cpp $(STORELIBS:%=$(LIBDIR)/%) $(BINDIR)
	@echo "build store"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(STORELIBS:%=$(LIBDIR)/%)
