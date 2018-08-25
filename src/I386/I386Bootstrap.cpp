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
    Environment bsEnv;
    I386CgaOStream bsOut(bsEnv, *notAnInfo);
    bsEnv.setStdO(bsOut);
    if (magic != MULTIBOOT2_BOOTLOADER_MAGIC) {
        bsOut<<"Invalid magic number: "<<(void *) magic<<'\n';
        return *((Environment *) 0x0);
    }
    if ((unsigned long)mbi & 7) {
        bsOut<<"Unaligned mbi: "<<mbi<<'\n';
        return *((Environment *) 0x0);
    }

    BootInformation bootInformation(mbi, mbh);
    bsOut<<"loaded via "<<bootInformation.bootloader->string<<'\n';
    
    // collect memory information on stack
    MemoryRegistry memoryRegistry(bsEnv, *notAnInfo);
    bootInformation.registerMemory(memoryRegistry);
    
    // create "heap"-based environment and memory management
    MemoryInfo &envInfo = memoryRegistry.allocate(sizeof(Environment), this);
    Environment &env = *(new (envInfo.buf) Environment(memoryRegistry, bsOut));
    
    MemoryManager &mm = env.create<MemoryManager>();
    memoryRegistry.transfer(mm);
    env.setAllocator(mm);

    // create "heap"-based stdOut
    OStream &stdO = env.create<I386CgaOStream>(); 
    env.setStdO(stdO);
    
    bootInformation.registerModules(env);
    
    // TODO: free mbi after all required information is transfered to heap
    //mm.free(mbi);

    return env;
}
