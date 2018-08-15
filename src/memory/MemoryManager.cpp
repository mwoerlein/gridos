#include "memory/MemoryManager.hpp"

// public

MemoryInfo & MemoryManager::allocate(size_t len, void * owner) {
    if (len < sizeof(MemoryListEntry) - sizeof(MemoryInfo)) {
        len = sizeof(MemoryListEntry) - sizeof(MemoryInfo);
    }
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
    if (isMemoryInfo(ptr)) {
        return *((MemoryInfo *) ptr);
    }
    void * info = memoryEnd(ptr, -sizeof(MemoryInfo));
    if (isMemoryInfo(info)) {
        return *((MemoryInfo *) info);
    }
    for (int i = 0; i < used->size; i++) {
        MemoryInfo * info = &used->elements[i];
        if (info->buf == ptr) {
            return *info;
        }
    }
    for (int i = 0; i < reserved->size; i++) {
        MemoryInfo * info = &reserved->elements[i];
        if (info->buf == ptr) {
            return *info;
        }
    }
    return *((MemoryInfo *)0);
}

// debug
void MemoryManager::dump() {
    log<<"dump reserved\n";
    for (int i = 0; i < reserved->size; i++) {
        MemoryInfo * info = &reserved->elements[i];
        log<<info<<':'<<info->buf<<' '<<(int)info->flags.used<<(int)info->flags.reserved<<'\n';
    }
    log<<"dump used\n";
    for (int i = 0; i < used->size; i++) {
        MemoryInfo * info = &used->elements[i];
        log<<info<<':'<<info->buf<<' '<<(int)info->flags.used<<(int)info->flags.reserved<<'\n';
    }
    log<<"dump available\n";
    for (MemoryListEntry * cur = available->next; cur != available; cur = cur->next) {
        MemoryInfo * info = (MemoryInfo *) cur;
        log<<info<<':'<<info->buf<<' '<<(int)info->flags.used<<(int)info->flags.reserved<<'\n';
    }
}
