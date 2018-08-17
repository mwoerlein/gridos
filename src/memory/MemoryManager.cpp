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
    
    size_t required = len + sizeof(MemoryInfo);
    // find available memory
    MemoryListEntry * from;
    for (from = &available; from->next != &available && from->len < required; from = from->next);

    if (from->len < required) {
        log<<"bad allocate "<<len<<"\n";
        return *((MemoryInfo *) 0x0);
    }
    
    if (from->len < required + 2*sizeof(MemoryInfo)) {
        // use whole entry
        from->buf = memoryEnd(from, sizeof(MemoryInfo));
        from->len -= sizeof(MemoryInfo);
        
        // remove from available
        unlinkEntry(from);
    } else {
        // split entry
        MemoryInfo * n = (MemoryInfo *) memoryEnd(from, required);
        n->buf = (void *) n;
        n->len = from->len - required;
        n->flags.magic = MEMORY_INFO_MAGIC;

        from->buf = memoryEnd(from, sizeof(MemoryInfo));
        from->len = len;

        // replace from by n in available
        n->next = from->next;
        n->prev = from->prev;
        n->next->prev = n->prev->next = n;
    }
    // append to used
    from->flags.used = 1;
    from->owner = owner;
    insertEntryAfter(used.prev, from);
    
    return *from;
}

void MemoryManager::free(void * ptr) {
    MemoryListEntry * entry = (MemoryListEntry*) &info(ptr);
    if (isNotAnInfo(entry) || !entry->flags.used) {
        log<<"bad free "<<ptr<<"\n";
        return;
    }
    
    // remove from used
    entry->flags.used = 0;
    entry->owner = (void *) 0;
    unlinkEntry(entry);

    // create inline entry
    if (hasFollowingBuffer(entry)) {
        entry->buf = entry;
        entry->len += sizeof(MemoryInfo);
    }  else {
        MemoryListEntry * nonEmbeddedEntry = entry;
        entry = (MemoryListEntry *) nonEmbeddedEntry->buf;
        entry->buf = nonEmbeddedEntry->buf;
        entry->len = nonEmbeddedEntry->len;
        entry->flags = nonEmbeddedEntry->flags;
        entry->owner = nonEmbeddedEntry->owner;
        
        // clear non-embedded entry
        initEmptyList(nonEmbeddedEntry);
    }

    // insert into available
    MemoryListEntry * cur;
    for (cur = &available; cur->next != &available && cur->next->buf <= entry->buf; cur = cur->next);
    // insert into available
    insertEntryAfter(cur, entry);
    
    if (entryEnd(entry) == entry->next) {
        // merge right
        entry->next->flags.magic = 0;
        entry->len = memoryDiff(entry->buf, entryEnd(entry->next)); 
        unlinkEntry(entry->next);
    }
    if (entry->prev != &available && entryEnd(entry->prev) == entry) {
        // merge left
        entry->flags.magic = 0;
        entry->prev->len = memoryDiff(entry->prev->buf, entryEnd(entry)); 
        unlinkEntry(entry);
    }
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
    return notAnInfo;
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
