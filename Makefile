.PHONY: all clean bootdisk kernelthread

all: clean bootdisk

include ./Makefile.inc

BLOCKS=$(BLOCKDIR)/startup.block $(BLOCKDIR)/store.block
BOOTBLOCKS=$(BLOCKDIR)/i386_loader.block $(BLOCKS)

LOADER_PARTS = settings stage0 stage1_1_start stage1_2_dap stage1_3_mid stage1_4_mbi stage1_5_end
LOADER_PASMS = $(patsubst %,$(BOOTLDDIR)/%.pasm, $(LOADER_PARTS))

STORE_PASMS = $(shell find $(PASMDIR)/ -type f -name '*.pasm')
STORE_FILES = $(patsubst $(PASMDIR)/%.pasm, $(BUILDDIR)/%.pbc, $(STORE_PASMS))

STARTUP_SEGMENT = 0x3000
MODULES_SEGMENT = 0x1000

clean:
	@rm -rf $(BLOCKDIR) $(BUILDDIR) $(PASMDIR) $(BINDIR) $(BOOTLDDIR)/stage1_2_dap.pasm $(BOOTLDDIR)/stage1_4_mbi.pasm

bootdisk: kernelthread $(IMGDIR)/bootdisk.img

$(IMGDIR)/bootdisk.img: $(IMGDIR) $(BOOTBLOCKS)
	@echo "creating $@"
	@cat $(BOOTBLOCKS) > $@

$(BLOCKDIR)/i386_loader.block: $(BLOCKDIR) $(LOADER_PASMS) $(PASM)
	@echo "creating $@"
	@cat $(LOADER_PASMS) | $(PASM) -bo $@ -

$(BOOTLDDIR)/stage1_2_dap.pasm: $(BLOCKS) $(MODBUILD)
	@$(MODBUILD) -so $@ -l STARTUP -f $(BLOCKDIR)/startup.block -t $(STARTUP_SEGMENT)
	@$(MODBUILD) -o $@ -l STORE -f $(BLOCKDIR)/store.block -a STARTUP -t $(MODULES_SEGMENT)
	
$(BOOTLDDIR)/stage1_4_mbi.pasm: $(BLOCKS) $(MODBUILD)
	@$(MODBUILD) -so $@ -l STARTUP -c "pool --test=0 --debug=2 --mainThread=gridos::KernelThread"
	@$(MODBUILD) -o $@ -l STORE -c "store --debug=1"

$(BLOCKDIR)/startup.block: $(BLOCKDIR) $(SRCDIR)/gridos/i386/Startup.pool $(POOLSC)
	@echo "creating $@"
	@$(POOLSC) $(PC_FLAGS) --output $@ gridos::i386::Startup --binding gridos::i386::mb2 -t $(STARTUP_SEGMENT)0

$(BLOCKDIR)/store.block: $(BLOCKDIR) $(STORE_FILES) $(STORE)
	@echo "creating $@"
	@$(STORE) -o $@ -a 512 $(STORE_FILES) 

kernelthread: $(PASMDIR) $(POOLC)
	@$(POOLC) $(PC_FLAGS) --output $(PASMDIR) gridos::KernelThread -r
 
$(MODBUILD): $(BINDIR) $(BOOTLDDIR)/command/ModuleBuilder.pool
	@echo "creating $@"
	@$(POOLSC) $(PC_FLAGS) -c $(BOOTLDDIR) --output $@ command::ModuleBuilder --binding linux::elf -t 0x10000
	@chmod u+x $@
