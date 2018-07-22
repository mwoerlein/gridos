#include "I386/I386Bootstrap.hpp"

I386Bootstrap::I386Bootstrap(unsigned long magic, void *mbi, void *mbh):valid(true), ds(),bootInformation(mbi, mbh),memoryRegistry(ds.getOStream())
{
    OStream &out = ds.getOStream();
    
    if (magic != MULTIBOOT2_BOOTLOADER_MAGIC)
    {
        out<<'I'<<'n'<<'v'<<'a'<<'l'<<'i'<<'d'<<' '<<'m'<<'a'<<'g'<<'i'<<'c'<<' '<<'n'<<'u'<<'m'<<'b'<<'e'<<'r'<<':'<<' '<<(void *) magic<<'\n';
        valid = false;
        return;
    }
    if ((unsigned long)mbi & 7)
    {
        out<<'U'<<'n'<<'a'<<'l'<<'i'<<'g'<<'n'<<'e'<<'d'<<' '<<'m'<<'b'<<'i'<<':'<<' '<<mbi<<'\n';
        valid = false;
        return;
    }
};

I386Bootstrap::~I386Bootstrap(){
    // free BootInformation and further memory
};

bool I386Bootstrap::isValid(){
    return valid;
};

DebugSystem &I386Bootstrap::getDebugSystem(){
    return ds;
};

MemoryInfo &I386Bootstrap::getKernelTextInfo(){
    // TODO: get information from memory manager
    return memoryRegistry.info((void*)bootInformation.modules[0]->mod_start);
};

MemoryInfo &I386Bootstrap::getKernelOutInfo(){
    // TODO: "malloc" kernel output space later in JIT
    return memoryRegistry.info((void*)0);
};

Environment *I386Bootstrap::buildEnvironment(){
    bootInformation.initialize();
    
    // TODO: create and fill registry on stack 
    bootInformation.registerMemory(memoryRegistry);
    
    // TODO: "malloc" kernel output space later in JIT
    memoryRegistry.registerUsedMemory((void*)0, 0x10000, (void*) this);
    memoryRegistry.dump();
    
    // TODO: register and create memory manager on heap
    // TODO: create and initialize environment on heap    
    return (Environment *) 0;
};
