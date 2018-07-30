#include "memory/MemoryManager.hpp"

// public

MemoryInfo & MemoryManager::allocate(size_t len, void * owner) {
    log<<"allocate "<<len<<' '<<owner<<'\n';
    
    MemoryInfo * ret = (MemoryInfo *) head;
    ret->buf = memoryEnd(ret, sizeof(MemoryInfo));
    ret->len = len;
    ret->flags.magic = MEMORY_INFO_MAGIC;
    ret->flags.used = 1;
    ret->owner = owner;
    head = entryEnd(ret);
    
    return *ret;
}

void MemoryManager::free(void * ptr) {
    log<<"free "<<ptr<<'\n';
}

MemoryInfo & MemoryManager::info(void * ptr) {
    log<<"info "<<ptr<<'\n';
    return *((MemoryInfo *)0);
}
