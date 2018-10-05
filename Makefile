include ./.Makefiles/Makefile.inc

BOOTBLOCKS=$(BOOTDIR)/$(MASCHINE)_loader.block $(BOOTDIR)/$(MASCHINE)_Kernel-JIT.block $(BOOTDIR)/Kernel-TEXT.block
THIS=$(firstword $(RLIBS))
REST=$(filter-out $(THIS), $(RLIBS))

TESTSUITELIBS = test.a KernelJIT.a $(MASCHINE)ASM.a memory.a sys.a

.PHONY: all clean libs rlibs tests

all: clean $(IMGDIR)/bootdisk.img

tests: clean test/suite
	@test/suite

libs: 
	@$(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(LIBS)" rlibs
rlibs: 
	$(MAKELIB) LIB=$(THIS) $(THIS)
	if [ "$(REST)" != "" ] ; then $(MAKE) $(MAKEOP) MASCHINE=$(MASCHINE) RLIBS="$(REST)" rlibs; fi

$(LIBDIR) $(IMGDIR):
	@mkdir -p $@

$(IMGDIR)/bootdisk.img: $(IMGDIR) $(BOOTBLOCKS)
	@echo "creating $@"
	@cat $(BOOTBLOCKS) > $@

$(BOOTDIR)/$(MASCHINE)_%:
	@$(MAKEBOOT) $@

clean:
	@rm -rf $(OBJDIR) $(LIBDIR) test/suite
	@$(MAKEBOOT) $@

test/suite: test/suite.cpp $(TESTSUITELIBS:%=$(LIBDIR)/%)
	@echo "build test suite"
	@$(CC) $(CFLAGS) -I$(INCDIR) -o $@ $< $(TESTSUITELIBS:%=$(LIBDIR)/%)
