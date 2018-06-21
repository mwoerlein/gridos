#include "multiboot2/BootInformation.hpp"

BootInformation::BootInformation(void *mbi){
    raw = mbi;
    modulesCount = 0;
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
}
