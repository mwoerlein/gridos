#include "multiboot2/BootInformation.hpp"

#include "KernelJIT/ModuleInfo.hpp"
#include "sys/String.hpp"

BootInformation::BootInformation(void *mbi, void *mbh):mbi(mbi),mbh(mbh),modulesCount(0) {
    struct multiboot_tag *tag;
    for (
        tag = (struct multiboot_tag *) ((unsigned long)mbi + 8);
        tag->type != MULTIBOOT_TAG_TYPE_END;
        tag = (struct multiboot_tag *) ((multiboot_uint8_t *) tag + ((tag->size + 7) & ~7))
    ) {
        switch (tag->type)
        {
            case MULTIBOOT_TAG_TYPE_CMDLINE:
                commandline = (struct multiboot_tag_string *)tag;
                break;
            case MULTIBOOT_TAG_TYPE_BOOT_LOADER_NAME:
                bootloader = (struct multiboot_tag_string *)tag;
                break;
            case MULTIBOOT_TAG_TYPE_MODULE:
                modules[modulesCount++] = (struct multiboot_tag_module *)tag;
                break;
            case MULTIBOOT_TAG_TYPE_BASIC_MEMINFO:
                meminfo = (struct multiboot_tag_basic_meminfo *)tag;
                break;
            case MULTIBOOT_TAG_TYPE_MMAP:
                mmap = (struct multiboot_tag_mmap *)tag;
                break;
        }
    }
    
    struct multiboot_header_tag *htag;
    for (
        htag = (struct multiboot_header_tag *) ((unsigned long)mbh + 16);
        htag->type != MULTIBOOT_HEADER_TAG_END;
        htag = (struct multiboot_header_tag *) ((multiboot_uint8_t *) htag + ((htag->size + 7) & ~7))
    ) {
        switch (htag->type)
        {
            case MULTIBOOT_HEADER_TAG_ADDRESS:
                address = (struct multiboot_header_tag_address *)htag;
                break;
        }
    }    
}

void BootInformation::registerMemory(MemoryRegistry &reg) {
    multiboot_memory_map_t *entry;
    unsigned int entry_size = mmap->entry_size;
    unsigned int buf;
    size_t len;
    /* register available memory first */
    for (
        entry = mmap->entries;
        (multiboot_uint8_t *) entry < (multiboot_uint8_t *) mmap + mmap->size;
        entry = (multiboot_memory_map_t *) ((unsigned int)entry + entry_size)
    ) {
        if (entry->addr >> 32) {
            // ignore memory > 4GB, 64 bit not yet available
            continue;
        }
        if (entry->type == MULTIBOOT_MEMORY_AVAILABLE) {
            buf = (unsigned int) entry->addr & 0xffffffff;
            len = ((buf + entry->len) >> 32) ? (0xffffffff - buf) : (entry->len & 0xffffffff);
            reg.registerAvailableMemory((void *) buf, (size_t) len);
        }
    }
    /* register reserved memory */
    for (
        entry = mmap->entries;
        (multiboot_uint8_t *) entry < (multiboot_uint8_t *) mmap + mmap->size;
        entry = (multiboot_memory_map_t *) ((unsigned int)entry + entry_size)
    ) {
        if (entry->addr >> 32) {
            // ignore memory > 4GB, 64 bit not yet available
            continue;
        }
        if (entry->type != MULTIBOOT_MEMORY_AVAILABLE) {
            buf = (unsigned int) entry->addr & 0xffffffff;
            len = ((buf + entry->len) >> 32) ? (0xffffffff - buf) : (entry->len & 0xffffffff);
            reg.registerReservedMemory((void *) buf, (size_t) len);
        }
    }
    /* register kernel */
    reg.registerUsedMemory((void *)address->load_addr, (size_t) (address->bss_end_addr - address->load_addr), this);
    /* register modules */
    for (int i = 0; i < modulesCount; i++) {
        reg.registerUsedMemory((void *)modules[i]->mod_start, (size_t) (modules[i]->mod_end - modules[i]->mod_start), this);
    }
    /* register mbi */
    reg.registerUsedMemory(mbi, (size_t) (*(unsigned int *) mbi), this);
}

void BootInformation::registerModules(Environment &env) {
    MemoryAllocator &ma = env.getAllocator();
    ModuleInfo * next = (ModuleInfo *) 0;
    
    ModuleInfo * kernel = &env.create<ModuleInfo, MemoryInfo &, String &, ModuleInfo *>(
        ma.memInfo((void *)address->load_addr),
        env.create<String, char*>(commandline->string),
        next
    );
    next = kernel;
    
    for (int i = modulesCount-1; i >= 0; i--) {
        next = &env.create<ModuleInfo, MemoryInfo &, String &, ModuleInfo *>(
            ma.memInfo((void*)modules[i]->mod_start),
            env.create<String, char*>(modules[i]->cmdline),
            next
        );
    }
    env.setModules(*next);
}
