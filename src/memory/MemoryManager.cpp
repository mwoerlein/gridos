#include "memory/MemoryManager.hpp"

// public
MemoryManager::MemoryManager(OStream &log):log(log) {
    initEmptyList(&available);
    initEmptyList(&reserved);
    initEmptyList(&used);
}

MemoryInfo & MemoryManager::allocate(size_t len, void * owner) {
    if (len < sizeof(MemoryListEntry) - sizeof(MemoryInfo)) {
        len = sizeof(MemoryListEntry) - sizeof(MemoryInfo);
    }
    log<<"allocate "<<len<<' '<<owner<<'\n';
    
    size_t required = len + sizeof(MemoryInfo);
    // find available memory
    MemoryListEntry * from;
    for (from = &available; from->next != &available && from->len < required; from = from->next);

    if (from->len < required) {
        log<<"bad allocate\n";
        return *((MemoryInfo *) 0x0);
    }
    
    if (from->len < required + 2*sizeof(MemoryInfo)) {
        // use whole entry
        from->buf = memoryEnd(from, sizeof(MemoryInfo));
        from->len -= sizeof(MemoryInfo);
        from->flags.used = 1;
        from->owner = owner;
        
        // remove from available
        from->next->prev = from->prev;
        from->prev->next = from->next;
        // append to used
        from->next = &used;
        from->prev = used.prev;
        from->next->prev = from->prev->next = from;
    } else {
        // split entry
        MemoryInfo * n = (MemoryInfo *) memoryEnd(from, required);
        n->buf = (void *) n;
        n->len = from->len - required;
        n->flags.magic = MEMORY_INFO_MAGIC;

        from->buf = memoryEnd(from, sizeof(MemoryInfo));
        from->len = len;
        from->flags.used = 1;
        from->owner = owner;

        // replace from by n available
        n->next = from->next;
        n->prev = from->prev;
        n->next->prev = n->prev->next = n;
        // append to used
        from->next = &used;
        from->prev = used.prev;
        from->next->prev = from->prev->next = from;
    }
    
    return *from;
}

void MemoryManager::free(void * ptr) {
    log<<"free "<<ptr<<'\n';
}

MemoryInfo & MemoryManager::info(void * ptr) {
    if (isMemoryInfo(ptr)) {
        return *((MemoryInfo *) ptr);
    }
    if ((size_t) ptr >= sizeof(MemoryInfo)) {
        void * info = memoryEnd(ptr, -sizeof(MemoryInfo));
        if (isMemoryInfo(info)) {
            return *((MemoryInfo *) info);
        }
    }
    for (int i = 0; i < nonEmbeddedEntries->size; i++) {
        MemoryInfo * info = &nonEmbeddedEntries->elements[i];
        if (info->buf != ptr){
            continue;
        }
        if (info->flags.used == 1 || info->flags.reserved == 1) {
            return *info;
        }
    }
    return *((MemoryInfo *)0);
}

// debug
void MemoryManager::dump(bool all) {
    for (MemoryListEntry * e = available.next; e != &available; e = e->next) {
        log<<"Available "
           <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
           <<" ("<<(void *) e<<")\n";
    }
    if (all) {
        for (MemoryListEntry * e = reserved.next; e != &reserved; e = e->next) {
            log<<"Reserved "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" ("<<(void *) e<<")\n";
        }
        for (MemoryListEntry * e = used.next; e != &used; e = e->next) {
            log<<"Used "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" ("<<(void *) e<<")\n";
        }
    }
}
