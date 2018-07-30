#include "I386/I386Bootstrap.hpp"
#include "I386/I386CgaOStream.hpp"
#include "I386/I386InterruptVectorTable.hpp"

#include "KernelJIT/ModuleInfo.hpp"
#include "memory/MemoryManager.hpp"
#include "memory/MemoryRegistry.hpp"
#include "multiboot2/BootInformation.hpp"

void I386Bootstrap::trickCompiler() {
    // force compiler to initiate static parts of I386InterruptVectorTable
    I386InterruptVectorTable vt;
}

Environment & I386Bootstrap::buildEnvironment(unsigned long magic, void *mbi, void *mbh) {
    I386CgaOStream bsOut;
    if (magic != MULTIBOOT2_BOOTLOADER_MAGIC)
    {
        bsOut<<"Invalid magic number: "<<(void *) magic<<'\n';
        return *((Environment *) 0x0);
    }
    if ((unsigned long)mbi & 7)
    {
        bsOut<<"Unaligned mbi: "<<mbi<<'\n';
        return *((Environment *) 0x0);
    }

    BootInformation bootInformation(mbi, mbh);
    bsOut<<"loaded via "<<bootInformation.bootloader->string<<'\n';
    MemoryRegistry memoryRegistry(bsOut);
    bootInformation.registerMemory(memoryRegistry);
    
    // TODO: "malloc" kernel output space later in JIT
    memoryRegistry.registerUsedMemory((void*)0, 0x10000, (void*) this);

    Environment staticEnv(memoryRegistry, bsOut);
    OStream &stdO = staticEnv._create<I386CgaOStream>();
    MemoryManager &mm = staticEnv._create<MemoryManager, OStream&, void *>(stdO, (void*) 0x10200);
    Environment &env = staticEnv._create<Environment, MemoryAllocator&, OStream&>(mm, stdO);
    
    memoryRegistry.dump();

    // keep in sync with bsOut
    ((I386CgaOStream&)stdO).sync();
    
    ModuleInfo * next = (ModuleInfo *) 0;
    for (int i = bootInformation.modulesCount-1; i>=0; i--) {
        next = &env.create<ModuleInfo, MemoryInfo, char *, ModuleInfo *>(
            memoryRegistry.info((void*)bootInformation.modules[i]->mod_start),
            bootInformation.modules[i]->cmdline,
            next
        );
    }
    env.setModules(next);

    return env;
};
