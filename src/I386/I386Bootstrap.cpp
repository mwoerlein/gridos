#include "I386/I386Bootstrap.hpp"
#include "I386/I386CgaOStream.hpp"
#include "I386/I386InterruptVectorTable.hpp"

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
    
    // collect memory information on stack
    MemoryRegistry memoryRegistry(bsOut);
    bootInformation.registerMemory(memoryRegistry);
    
    Environment staticEnv(memoryRegistry, bsOut);
    
    // create "heap"-based environment and memory management
    OStream &stdO = staticEnv.createNonObject<I386CgaOStream>();
    MemoryManager &mm = staticEnv.createNonObject<MemoryManager, OStream&>(stdO);
    Environment &env = staticEnv.createNonObject<Environment, MemoryAllocator&, OStream&>(mm, stdO);
    
    memoryRegistry.transfer(mm);

    // keep stdO in sync with bsOut
    ((I386CgaOStream&)stdO).sync();
    
    bootInformation.registerModules(env);
    
    // TODO: free mbi after all required information is transfered to heap
    //mm.free(mbi);

    return env;
}
