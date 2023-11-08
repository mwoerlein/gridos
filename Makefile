.PHONY: all clean bootdisk kernelthread

all: clean bootdisk

include ./Makefile.inc

BLOCKS=$(BLOCKDIR)/startup.block $(BLOCKDIR)/gidt.block $(BLOCKDIR)/store.block $(BLOCKDIR)/sampletask.block
BOOTBLOCKS=$(BLOCKDIR)/i386_loader.block $(BLOCKS)

LOADER_PARTS = settings stage0 stage1_1_start stage1_2_dap stage1_3_mid stage1_4_mbi stage1_5_end
LOADER_PASMS = $(patsubst %,$(BOOTLDDIR)/%.pasm, $(LOADER_PARTS))

STORE_PASMS = $(shell find $(PASMDIR)/ -type f -name '*.pasm')
STORE_FILES = $(patsubst $(PASMDIR)/%.pasm, $(BUILDDIR)/%.p86, $(STORE_PASMS))

I386_SYS_SRCS =$(shell find $(SRCDIR)/gridos/i386/sys -type f -name '*.pool')
USER_RT_CLASSES = $(patsubst $(SRCDIR)/gridos/i386/sys/%.pool, gridos::i386::sys::%, $(I386_SYS_SRCS)) sys::memory::PagedMemoryManager sys::runtime::DynamicClassStorage sys::store::Store

STARTUP_SEGMENT = 0x5000
MODULES_SEGMENT = 0x1000
GIDT_PAGE = 0xFFBFD

clean:
	@rm -rf $(BLOCKDIR) $(BUILDDIR) $(PASMDIR) $(BINDIR) $(BOOTLDDIR)/stage1_2_dap.pasm $(BOOTLDDIR)/stage1_4_mbi.pasm

bootdisk: sampletask $(IMGDIR)/bootdisk.img

$(IMGDIR)/bootdisk.img: $(IMGDIR) $(BOOTBLOCKS)
	@echo "creating $@"
	@cat $(BOOTBLOCKS) > $@

$(BLOCKDIR)/i386_loader.block: $(BLOCKDIR) $(LOADER_PASMS) $(PASM)
	@echo "creating $@"
	@cat $(LOADER_PASMS) | $(PASM) -bo $@ -

$(BOOTLDDIR)/stage1_2_dap.pasm: $(BLOCKS) $(MODBUILD)
	@$(MODBUILD) -so $@ -l STARTUP -f $(BLOCKDIR)/startup.block -t $(STARTUP_SEGMENT)
	@$(MODBUILD) -o $@ -l GIDT -f $(BLOCKDIR)/gidt.block -a STARTUP -t $(MODULES_SEGMENT)
	@$(MODBUILD) -o $@ -l STORE -f $(BLOCKDIR)/store.block -a GIDT
	@$(MODBUILD) -o $@ -l SAMPLETASK -f $(BLOCKDIR)/sampletask.block -a STORE
	
$(BOOTLDDIR)/stage1_4_mbi.pasm: $(BLOCKS) $(MODBUILD)
	@$(MODBUILD) -so $@ -l STARTUP -c "startup --test=0 --debug=2 --runTask=gridos::SampleTask --runModule=sampletask"
	@$(MODBUILD) -o $@ -l GIDT -c "gidt --target=$(GIDT_PAGE)000"
	@$(MODBUILD) -o $@ -l STORE -c "store --debug=1"
	@$(MODBUILD) -o $@ -l SAMPLETASK -c "sampletask --runTask=gridos::SampleTask"

$(BLOCKDIR)/startup.block: $(BLOCKDIR) $(SRCDIR)/gridos/i386/Startup.pool $(POOLSC)
	@echo "creating $@"
	@$(POOLSC) $(PC_FLAGS) --output $@ gridos::i386::Startup --binding gridos::i386::mb2 -t $(STARTUP_SEGMENT)0

$(BLOCKDIR)/gidt.block: $(BLOCKDIR) $(SRCDIR)/gridos/i386/gidt.pasm $(PASM)
	@echo "creating $@"
	@$(PASM) -bo $@ $(SRCDIR)/gridos/i386/gidt.pasm -t $(GIDT_PAGE)000

$(BLOCKDIR)/store.block: $(BLOCKDIR) $(STORE_FILES) $(STORE)
	@echo "creating $@"
	@$(STORE) -io $@ -a 512 $(STORE_FILES) 

$(BLOCKDIR)/sampletask.block: $(SRCDIR)/gridos/SampleTask.pool $(POOLC)
	@echo "creating $@"
	@rm -rf $(TMPDIR)
	@mkdir -p $(TMPDIR)
	@$(POOLC) $(PC_FLAGS) --output $(TMPDIR) gridos::SampleTask $(USER_RT_CLASSES) -Br
	@$(STORE) -io $@ -a 512 `find $(TMPDIR)/ -type f -name '*.p86'`
	@rm -rf $(TMPDIR)
 
sampletask: $(PASMDIR) $(POOLC)
	@$(POOLC) $(PC_FLAGS) --output $(PASMDIR) gridos::SampleTask -r
 
$(MODBUILD): $(BINDIR) $(BOOTLDDIR)/command/ModuleBuilder.pool
	@echo "creating $@"
	@$(POOLSC) $(PC_FLAGS) -c $(BOOTLDDIR) --output $@ command::ModuleBuilder --binding linux::elf -t 0x10000
	@chmod u+x $@
