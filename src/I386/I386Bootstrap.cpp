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

KernelEnvironment & I386Bootstrap::buildEnvironment(unsigned long magic, void *mbi, void *mbh) {
    Environment bsEnv;
    I386CgaOStream bsOut(bsEnv);
    bsEnv.setOut(bsOut);
    bsEnv.setErr(bsOut);
    if (magic != MULTIBOOT2_BOOTLOADER_MAGIC) {
        bsOut<<"Invalid magic number: "<<(void *) magic<<'\n';
        return *((KernelEnvironment *) 0);
    }
    if ((unsigned long)mbi & 7) {
        bsOut<<"Unaligned mbi: "<<mbi<<'\n';
        return *((KernelEnvironment *) 0);
    }

    BootInformation bootInformation(mbi, mbh);
    bsOut<<"loaded via "<<bootInformation.bootloader->string<<'\n';
    
    // collect memory information on stack
    MemoryRegistry memoryRegistry(bsEnv);
    bootInformation.registerMemory(memoryRegistry);
    
    // create "heap"-based environment and memory management
    MemoryInfo &envInfo = memoryRegistry.allocate(sizeof(KernelEnvironment), this);
    KernelEnvironment &env = *(new (envInfo.buf) KernelEnvironment(memoryRegistry, bsOut, bsOut));
    
    MemoryManager &mm = env.create<MemoryManager>();
    memoryRegistry.transfer(mm);
    env.setAllocator(mm);

    // create "heap"-based stdOut
    I386CgaOStream &cga = env.create<I386CgaOStream>(); 
    env.setOut(cga);
    env.setErr(cga.getFormattedOStream(12));
    
    bootInformation.registerModules(env);
    
    mm.free(mm.memInfo(mbi));

    return env;
}
