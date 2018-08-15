#include "memory/MemoryRegistry.hpp"

#include "memory/MemoryManager.hpp"

// public
MemoryRegistry::MemoryRegistry(OStream &log):log(log),entriesCounter(0) {
    initEmptyList(&available);
    initEmptyList(&reserved);
    initEmptyList(&used);
}

void MemoryRegistry::registerAvailableMemory(void * mem, size_t len) {
    if (len == 0) {
        return;
    }
    if (!isEmptyList(&reserved) || !isEmptyList(&used)) {
        log<<"Ignore available "<<(void *) mem<<':'<<(void*)len<<'\n';
        return;
    }
    
    // insert/merge into available entries
    if (isEmptyList(&available)) {
        insertAfterEntry(&available, newEntry(mem, len));
    } else {
        void * memEnd = memoryEnd(mem, len);
        MemoryListEntry * entry = findEntry(&available, mem);
        if (entryEnd(entry) >= mem) {
            entry->len = memoryDiff(entry->buf, memEnd);
        } else {
            insertAfterEntry(entry, newEntry(mem, len));
            entry = entry->next;
        }
        while (entry->next != &available && entryEnd(entry) >= entry->next->buf) {
            entry->len = memoryDiff(entry->buf, entryEnd(entry->next));
            removeEntry(entry->next);
        }
    }
}

void MemoryRegistry::registerReservedMemory(void * mem, size_t len) {
    if (len == 0) {
        return;
    }

    // remove from available
    removeFromList(&available, mem, len);
    
    // insert/merge into reserved entries
    if (isEmptyList(&reserved)) {
        insertAfterEntry(&reserved, newReservedEntry(mem, len));
    } else {
        void * memEnd = memoryEnd(mem, len);
        MemoryListEntry * entry = findEntry(&reserved, mem);
        if (entryEnd(entry) >= mem) {
            entry->len = memoryDiff(entry->buf, memEnd);
        } else {
            insertAfterEntry(entry, newReservedEntry(mem, len));
            entry = entry->next;
        }
        while (entry->next != &reserved && entryEnd(entry) >= entry->next->buf) {
            entry->len = memoryDiff(entry->buf, entryEnd(entry->next));
            removeEntry(entry->next);
        }
    }
}

void MemoryRegistry::registerUsedMemory(void * mem, size_t len, void * owner) {
    if (len == 0) {
        return;
    }

    // remove from available
    removeFromList(&available, mem, len);
    
    // insert into used entries
    if (isEmptyList(&used)) {
        insertAfterEntry(&used, newUsedEntry(mem, len, owner));
    } else {
        MemoryListEntry * entry = findEntry(&used, mem);
        insertAfterEntry(entry, newUsedEntry(mem, len, owner));
    }
}

bool MemoryRegistry::isAvailable(void * mem, size_t len) {
    if (isEmptyList(&available)) {
        return false;
    }
    MemoryListEntry * entry = findEntry(&available, mem);
    return (size_t) mem + len <= (size_t) entry->buf + entry->len;
}

MemoryInfo & MemoryRegistry::allocate(size_t len, void * owner) {
    if (len < sizeof(MemoryListEntry) - sizeof(MemoryInfo)) {
        len = sizeof(MemoryListEntry) - sizeof(MemoryInfo);
    }
    
    size_t required = len + sizeof(MemoryInfo);
    MemoryListEntry * from = findEntry(&available, required);
    if (from->len < required) {
        log<<"bad allocate\n";
        return *((MemoryInfo *) 0x0);
    }
    
    MemoryInfo * ret = (MemoryInfo *) from->buf;
    ret->buf = memoryEnd(ret, sizeof(MemoryInfo));
    ret->len = len;
    ret->flags.magic = MEMORY_INFO_MAGIC;
    ret->flags.used = 1;
    ret->owner = owner;
    
    registerUsedMemory(ret, required, owner);
    
    return *ret;
}

void MemoryRegistry::free(void * ptr) {
    // no static free abailable
}

MemoryInfo & MemoryRegistry::info(void * ptr) {
    MemoryListEntry * entry = findEntry(&used, ptr);
    if (entryEnd(entry) <= ptr) {
        return *((MemoryInfo *)0);
    }
    return *((MemoryInfo *)entry);
}

void MemoryRegistry::transfer(MemoryManager & memoryManager) {
    // create buffer for non-embedded entries
    int nonEmbeddedCount = countNonEmbeddedEntries(&reserved) + countNonEmbeddedEntries(&used);
    MemoryInfo & arrayInfo = allocate(sizeof(MemoryInfoArray) + nonEmbeddedCount*sizeof(MemoryInfo), (void*) &memoryManager);
    MemoryInfoArray * buffer = (MemoryInfoArray *) arrayInfo.buf;
    buffer->size = 0;
    
    // transfer registered lists to memory manager
    transferMemoryList(&reserved, &(memoryManager.reserved), buffer);
    transferMemoryList(&used, &(memoryManager.used), buffer);
    transferMemoryList(&available, &(memoryManager.available));
    memoryManager.nonEmbeddedEntries = buffer;
    
    // clear registry    
    initEmptyList(&available);
    initEmptyList(&reserved);
    initEmptyList(&used);
    entriesCounter = 0;
}


// private

MemoryListEntry * MemoryRegistry::findEntry(MemoryListEntry * list, size_t required) {
    MemoryListEntry * cur;
    for (cur = list; cur->next != list && cur->len < required; cur = cur->next);
    return cur;
}

MemoryListEntry * MemoryRegistry::findEntry(MemoryListEntry * list, void * buf) {
    MemoryListEntry * cur;
    for (cur = list; cur->next != list && cur->next->buf <= buf; cur = cur->next);
    return cur;
}

void MemoryRegistry::insertAfterEntry(MemoryListEntry * entry, MemoryListEntry * newEntry) {
    newEntry->prev = entry;
    newEntry->next = entry->next;
    newEntry->prev->next = newEntry->next->prev = newEntry;
}

void MemoryRegistry::removeEntry(MemoryListEntry * entry) {
    entry->prev->next = entry->next;
    entry->next->prev = entry->prev;
    freeEntry(entry);
}

void MemoryRegistry::removeFromList(MemoryListEntry * list, void * mem, size_t len) {
    if (isEmptyList(list)) {
        return;
    }
    void * memEnd = memoryEnd(mem, len);
    MemoryListEntry * firstEntry = findEntry(list, mem);
    MemoryListEntry * lastEntry = findEntry(list, memEnd);
    if (firstEntry == lastEntry) {
        if (firstEntry == list) {
            // area fully before whole list
            return;
        }
        void * firstEntryEnd = entryEnd(firstEntry);
        if (firstEntryEnd < mem) {
            // area fully after firstEntry
            return;
        }
        if (firstEntry->buf == mem && firstEntry->len <= len) {
            // area fully covers firstEntry
            removeEntry(firstEntry);
            return;
        }
        if (firstEntry->buf == mem) {
            // area is begin of firstEntry
            firstEntry->buf = memEnd;
            firstEntry->len = memoryDiff(memEnd, firstEntryEnd);
            return;
        }
        if (firstEntryEnd <= memEnd) {
            // area is end of firstEntry
            firstEntry->len = memoryDiff(firstEntry->buf, mem);
            return;
        }
        // area is inside of firstEntry
        firstEntry->len = memoryDiff(firstEntry->buf, mem);
        insertAfterEntry(firstEntry, newEntry(memEnd, memoryDiff(memEnd, firstEntryEnd)));
    } else {
        // area covers multiple entries

        // remove fully covered entries    
        while(firstEntry->next != lastEntry) {
            removeEntry(firstEntry->next);
        }
        
        if (firstEntry != list) {
            void * firstEntryEnd = entryEnd(firstEntry);
            if (firstEntryEnd < mem) {
                // area fully after firstEntry
            } else if (firstEntry->buf == mem) {
                // area fully covers firstEntry
                removeEntry(firstEntry);
            } else {
                // area is end of first Entry
                firstEntry->len = memoryDiff(firstEntry->buf, mem);
            }
        }
        
        void * lastEntryEnd = entryEnd(lastEntry);
        if (lastEntryEnd == memEnd) {
            // area fully covers lastEntry
            removeEntry(lastEntry);
        } else {
            // area is begin of lastEntry
            lastEntry->buf = memEnd;
            lastEntry->len = memoryDiff(memEnd, lastEntryEnd);
        }
    }
}

MemoryListEntry * MemoryRegistry::newEntry(void * mem, size_t len) {
    MemoryListEntry *entry = &entries[entriesCounter++];
    entry->buf = mem;
    entry->len = len;
    entry->flags.magic = MEMORY_INFO_MAGIC;
    return entry;
}

MemoryListEntry * MemoryRegistry::newReservedEntry(void * mem, size_t len) {
    MemoryListEntry *entry = newEntry(mem, len);
    entry->flags.reserved = 1;
    return entry;
}

MemoryListEntry * MemoryRegistry::newUsedEntry(void * mem, size_t len, void * owner) {
    MemoryListEntry *entry = newEntry(mem, len);
    entry->flags.used = 1;
    entry->owner = owner;
    return entry;
}

void MemoryRegistry::freeEntry(MemoryListEntry * entry) {
    entry->next = entry->prev = (MemoryListEntry *) 0;
    entry->owner = (void *) 0;
    entry->flags.magic = entry->flags.reserved = entry->flags.used = 0;
}

int MemoryRegistry::countNonEmbeddedEntries(MemoryListEntry * list) {
    int count = 0;
    for (MemoryListEntry * cur = list->next; cur != list; cur = cur->next) {
        if (!isMemoryInfo(cur->buf) || !hasFollowingBuffer(cur->buf)) {
            count++;
        }
    }
    return count;
}

void MemoryRegistry::transferMemoryList(MemoryListEntry * srcList, MemoryListEntry * destList, MemoryInfoArray * buffer) {
    for (MemoryListEntry * cur = srcList->next; cur != srcList; cur = cur->next) {
        MemoryListEntry * entry = (MemoryListEntry *) cur->buf;
        if (!buffer || !isMemoryInfo(cur->buf) || !hasFollowingBuffer(cur->buf)) {
            if (buffer) {
                // initialize entry from buffer (reserved, used)
                entry = (MemoryListEntry *) &buffer->elements[buffer->size++];
            } // else initialize entry inline (available)
            entry->buf = cur->buf;
            entry->len = cur->len;
            entry->flags = cur->flags;
            entry->owner = cur->owner;
        } // else use pre-initialized entry as-is (used by allocate)
        insertAfterEntry(destList->prev, entry);
    }
}

// debug
void MemoryRegistry::dump(bool all) {
    log<<"Dump registry "<<(void *) this<<" (next #"<<entriesCounter<<")\n";
    
    MemoryListEntry *e;
    for (e = available.next; e != &available; e = e->next) {
        log<<"Available "
           <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
           <<" (#"<<(e-entries)<<")\n";
    }
    if (all) {
        for (e = reserved.next; e != &reserved; e = e->next) {
            log<<"Reserved "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" (#"<<(e-entries)<<")\n";
        }
        for (e = used.next; e != &used; e = e->next) {
            log<<"Used "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" (#"<<(e-entries)<<") by "<< e->owner <<'\n';
        }
    }
}
