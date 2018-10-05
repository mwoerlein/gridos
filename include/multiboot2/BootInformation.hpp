#ifndef BOOTINFORMATION_HPP_LOCK
#define BOOTINFORMATION_HPP_LOCK

#include "multiboot2/multiboot2.h"
#include "memory/MemoryRegistry.hpp"
#include "KernelJIT/KernelEnvironment.hpp"

class BootInformation{
    public:
    void *mbi, *mbh;
    
    struct multiboot_header_tag_address *address;
    
    struct multiboot_tag_string *commandline;
    struct multiboot_tag_string *bootloader;
    struct multiboot_tag_basic_meminfo *meminfo;
    struct multiboot_tag_mmap *mmap;
    int modulesCount;
    struct multiboot_tag_module *modules[10];
    
    BootInformation(void *mbi, void *mbh);
    virtual ~BootInformation() {}
    virtual void registerMemory(MemoryRegistry &reg);
    virtual void registerModules(KernelEnvironment &env);
};

#endif //BOOTINFORMATION_HPP_LOCK

