POOLBASEDIR=../pool
STORE=$(POOLBASEDIR)/bootstrap-pool/bin/storeb
PASM=$(POOLBASEDIR)/bootstrap-cpp/bin/pbasm
POOLC=$(POOLBASEDIR)/bootstrap-cpp/bin/poolbc
POOLSC=$(POOLBASEDIR)/bootstrap-cpp/bin/poolbsc
PC_FLAGS=--classpath ./src --classpath $(POOLBASEDIR)/src --classpath $(POOLBASEDIR)/bootstrap-pool/src

BLOCKDIR=./block
BOOTLDDIR=./bootloader/i386
BUILDDIR=./build
IMGDIR=./img
PASMDIR=./pasm
SRCDIR=./src


$(IMGDIR) $(BLOCKDIR) $(BUILDDIR) $(PASMDIR):
	@mkdir -p $@

$(BUILDDIR)/%.pbc: $(PASMDIR)/%.pasm $(PASM)
	@mkdir -p $(dir $@)
	@$(PASM) -co $@ $<

