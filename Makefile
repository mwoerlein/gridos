.PHONY: all clean bootdisk kernelthread

all: clean bootdisk

include ./Makefile.inc

BLOCKS=$(BLOCKDIR)/startup.block $(BLOCKDIR)/store.block
BOOTBLOCKS=$(BLOCKDIR)/i386_loader.block $(BLOCKS)

LOADER_PARTS = dynamic_settings settings stage0 stage1_1_start stage1_2_dap stage1_3_mid stage1_4_mbi stage1_5_end
LOADER_PASMS = $(patsubst %,$(BOOTLDDIR)/%.pasm, $(LOADER_PARTS))

STORE_PASMS = $(shell find $(PASMDIR)/ -type f -name '*.pasm')
STORE_FILES = $(patsubst $(PASMDIR)/%.pasm, $(BUILDDIR)/%.pbc, $(STORE_PASMS))


clean:
	@rm -rf $(BLOCKDIR) $(BUILDDIR) $(PASMDIR) $(BOOTLDDIR)/dynamic_settings.pasm

bootdisk: kernelthread $(IMGDIR)/bootdisk.img

$(IMGDIR)/bootdisk.img: $(IMGDIR) $(BOOTBLOCKS)
	@echo "creating $@"
	@cat $(BOOTBLOCKS) > $@

$(BLOCKDIR)/i386_loader.block: $(BLOCKDIR) $(LOADER_PASMS) $(PASM)
	@echo "creating $@"
	@cat $(LOADER_PASMS) | $(PASM) -bo $@ -

$(BOOTLDDIR)/dynamic_settings.pasm: $(BLOCKS)
	@echo "MOD_KERNEL_SECTORS  := 0" > $@
	@echo "MOD_STORE_SECTORS   := `wc -c $(BLOCKDIR)/store.block | awk '{print int(($$1+511)/512);}'`" >> $@
	@echo "STARTUP_SECTORS     := `wc -c $(BLOCKDIR)/startup.block | awk '{print int(($$1+511)/512);}'`" >> $@

$(BLOCKDIR)/startup.block: $(BLOCKDIR) $(SRCDIR)/gridos/i386/Startup.pool $(POOLSC)
	@echo "creating $@"
	@$(POOLSC) $(PC_FLAGS) --output $@ gridos::i386::Startup --binding gridos::i386::mb2 -t 0x20000

$(BLOCKDIR)/store.block: $(BLOCKDIR) $(STORE_FILES) $(STORE)
	@echo "creating $@"
	@$(STORE) -o $@ -a 512 $(STORE_FILES) 

kernelthread: $(PASMDIR) $(POOLC)
	@$(POOLC) $(PC_FLAGS) --output $(PASMDIR) gridos::KernelThread -r
 
