#include "memory/MemoryRegistry.hpp"

#include "memory/MemoryInfoHelper.hpp"
#include "memory/MemoryManager.hpp"

// public
MemoryRegistry::MemoryRegistry(Environment &env, MemoryInfo &mi):Object(env, mi),infosCounter(0) {
    initMemoryInfoList(&available);
    initMemoryInfoList(&reserved);
    initMemoryInfoList(&used);
}

void MemoryRegistry::registerAvailableMemory(void * mem, size_t len) {
    if (len == 0) {
        return;
    }
    if (!isEmptyMemoryInfoList(&reserved) || !isEmptyMemoryInfoList(&used)) {
        env().out()<<"Ignore available "<<(void *) mem<<':'<<(void*)len<<'\n';
        return;
    }
    
    // insert/merge into available infos
    if (isEmptyMemoryInfoList(&available)) {
        MemoryInfo * n = newInfo(mem, len);
        appendMemoryInfo(&available, n);
    } else {
        void * memEnd = memoryEnd(mem, len);
        MemoryInfo * info = findInfo(&available, mem);
        if (memoryInfoEnd(info) >= mem) {
            info->len = memoryDiff(info->buf, memEnd);
        } else {
            MemoryInfo * n = newInfo(mem, len);
            appendMemoryInfo(info, n);
            info = info->next;
        }
        while (info->next != &available && memoryInfoEnd(info) >= info->next->buf) {
            info->len = memoryDiff(info->buf, memoryInfoEnd(info->next));
            removeInfo(info->next);
        }
    }
}

void MemoryRegistry::registerReservedMemory(void * mem, size_t len) {
    if (len == 0) {
        return;
    }

    // remove from available
    removeFromList(&available, mem, len);
    
    // insert/merge into reserved infos
    if (isEmptyMemoryInfoList(&reserved)) {
        MemoryInfo * n = newReservedInfo(mem, len);
        appendMemoryInfo(&reserved, n);
    } else {
        void * memEnd = memoryEnd(mem, len);
        MemoryInfo * info = findInfo(&reserved, mem);
        if (memoryInfoEnd(info) >= mem) {
            info->len = memoryDiff(info->buf, memEnd);
        } else {
            MemoryInfo * n = newReservedInfo(mem, len);
            appendMemoryInfo(info, n);
            info = info->next;
        }
        while (info->next != &reserved && memoryInfoEnd(info) >= info->next->buf) {
            info->len = memoryDiff(info->buf, memoryInfoEnd(info->next));
            removeInfo(info->next);
        }
    }
}

void MemoryRegistry::registerUsedMemory(void * mem, size_t len, void * owner) {
    if (len == 0) {
        return;
    }

    // remove from available
    removeFromList(&available, mem, len);
    
    // insert into used infos
    MemoryInfo * n = newUsedInfo(mem, len, owner);
    if (isEmptyMemoryInfoList(&used)) {
        appendMemoryInfo(&used, n);
    } else {
        MemoryInfo * info = findInfo(&used, mem);
        appendMemoryInfo(info, n);
    }
}

MemoryInfo & MemoryRegistry::allocate(size_t len, void * owner) {
    size_t required = len + sizeof(MemoryInfo);
    
    // find available memory
    MemoryInfo * avail = findInfo(&available, required);
    if (avail->len < required) {
        env().err()<<"bad static allocate\n";
        return *notAnInfo;
    }
    
    // create inline info
    MemoryInfo * ret = (MemoryInfo *) avail->buf;
    ret->buf = memoryEnd(ret, sizeof(MemoryInfo));
    ret->len = len;
    ret->flags.magic = MEMORY_INFO_MAGIC;
    ret->flags.used = 1;
    ret->owner = owner;
    
    // mark as used
    registerUsedMemory(ret, required, owner);
    
    return *ret;
}

void MemoryRegistry::free(void * ptr) {
    // no static free available
    env().err()<<"bad static free\n";
}

size_t MemoryRegistry::getAvailableBytes() {
    size_t bytes = 0;
    for (MemoryInfo *e = available.next; e != &available; e = e->next) {
        bytes += e->len;
    }
    return bytes;
}

MemoryInfo & MemoryRegistry::memInfo(void * ptr) {
    MemoryInfo * info = findInfo(&used, ptr);
    if (!info || memoryInfoEnd(info) <= ptr) {
        return *notAnInfo;
    }
    return *info;
}

void MemoryRegistry::transfer(MemoryManager & memoryManager) {
    MemoryInfoArray * buffer = (MemoryInfoArray*)-1;
    
    // create buffer for non-embedded infos
    int nonEmbeddedCount = countNonEmbeddedInfos(&reserved) + countNonEmbeddedInfos(&used);
    if (nonEmbeddedCount) {
        MemoryInfo & arrayInfo = allocate(sizeof(MemoryInfoArray) + nonEmbeddedCount*sizeof(MemoryInfo), (void*) &memoryManager);
        buffer = (MemoryInfoArray *) arrayInfo.buf;
        buffer->size = 0;
    }
    
    // transfer registered lists to memory manager
    transferMemoryList(&reserved, &(memoryManager.reserved), buffer);
    transferMemoryList(&used, &(memoryManager.used), buffer);
    transferMemoryList(&available, &(memoryManager.available));
    memoryManager.nonEmbeddedInfos = buffer;
    
    // clear registry    
    initMemoryInfoList(&available);
    initMemoryInfoList(&reserved);
    initMemoryInfoList(&used);
    infosCounter = 0;
}


// private

void MemoryRegistry::removeInfo(MemoryInfo * info) {
    unlinkMemoryInfo(info);
    info->next = info->prev = info;
    info->owner = (void *) 0;
    info->flags.magic = info->flags.reserved = info->flags.used = 0;
}

void MemoryRegistry::removeFromList(MemoryInfo * list, void * mem, size_t len) {
    if (isEmptyMemoryInfoList(list)) {
        return;
    }
    void * memEnd = memoryEnd(mem, len);
    MemoryInfo * firstInfo = findInfo(list, mem);
    MemoryInfo * lastInfo = findInfo(list, memEnd);
    if (firstInfo == lastInfo) {
        if (firstInfo == list) {
            // area fully before whole list
            return;
        }
        void * firstInfoEnd = memoryInfoEnd(firstInfo);
        if (firstInfoEnd < mem) {
            // area fully after firstInfo
            return;
        }
        if (firstInfo->buf == mem && firstInfo->len <= len) {
            // area fully covers firstInfo
            removeInfo(firstInfo);
            return;
        }
        if (firstInfo->buf == mem) {
            // area is begin of firstInfo
            firstInfo->buf = memEnd;
            firstInfo->len = memoryDiff(memEnd, firstInfoEnd);
            return;
        }
        if (firstInfoEnd <= memEnd) {
            // area is end of firstInfo
            firstInfo->len = memoryDiff(firstInfo->buf, mem);
            return;
        }
        // area is inside of firstInfo
        firstInfo->len = memoryDiff(firstInfo->buf, mem);
        MemoryInfo * n = newInfo(memEnd, memoryDiff(memEnd, firstInfoEnd));
        appendMemoryInfo(firstInfo, n);
    } else {
        // area covers multiple infos

        // remove fully covered infos    
        while(firstInfo->next != lastInfo) {
            removeInfo(firstInfo->next);
        }
        
        if (firstInfo != list) {
            void * firstInfoEnd = memoryInfoEnd(firstInfo);
            if (firstInfoEnd < mem) {
                // area fully after firstInfo
            } else if (firstInfo->buf == mem) {
                // area fully covers firstInfo
                removeInfo(firstInfo);
            } else {
                // area is end of first Info
                firstInfo->len = memoryDiff(firstInfo->buf, mem);
            }
        }
        
        void * lastInfoEnd = memoryInfoEnd(lastInfo);
        if (lastInfoEnd == memEnd) {
            // area fully covers lastInfo
            removeInfo(lastInfo);
        } else {
            // area is begin of lastInfo
            lastInfo->buf = memEnd;
            lastInfo->len = memoryDiff(memEnd, lastInfoEnd);
        }
    }
}

MemoryInfo * MemoryRegistry::newInfo(void * mem, size_t len) {
    MemoryInfo *info = &infos[infosCounter++];
    info->buf = mem;
    info->len = len;
    info->flags.magic = MEMORY_INFO_MAGIC;
    return info;
}

MemoryInfo * MemoryRegistry::newReservedInfo(void * mem, size_t len) {
    MemoryInfo *info = newInfo(mem, len);
    info->flags.reserved = 1;
    return info;
}

MemoryInfo * MemoryRegistry::newUsedInfo(void * mem, size_t len, void * owner) {
    MemoryInfo *info = newInfo(mem, len);
    info->flags.used = 1;
    info->owner = owner;
    return info;
}

int MemoryRegistry::countNonEmbeddedInfos(MemoryInfo * list) {
    int count = 0;
    for (MemoryInfo * cur = list->next; cur != list; cur = cur->next) {
        if (!isMemoryInfo(cur->buf) || !hasFollowingBuffer(cur->buf)) {
            count++;
        }
    }
    return count;
}

void MemoryRegistry::transferMemoryList(MemoryInfo * srcList, MemoryInfo * destList, MemoryInfoArray * buffer) {
    for (MemoryInfo * cur = srcList->next; cur != srcList; cur = cur->next) {
        MemoryInfo * info = (MemoryInfo *) cur->buf;
        if (!buffer || !isMemoryInfo(cur->buf) || !hasFollowingBuffer(cur->buf)) {
            if (buffer) {
                // initialize info from buffer (reserved, used)
                info = (MemoryInfo *) &buffer->elements[buffer->size++];
            } // else initialize info inline (available)
            info->buf = cur->buf;
            info->len = cur->len;
            info->flags = cur->flags;
            info->owner = cur->owner;
        } // else use pre-initialized info as-is (used by allocate)
        appendMemoryInfo(destList->prev, info);
    }
}

// debug
void MemoryRegistry::dump(OStream &log, bool all) {
    log<<"Dump registry "<<(void *) this<<" (next #"<<infosCounter<<")\n";
    
    MemoryInfo *e;
    for (e = available.next; e != &available; e = e->next) {
        log<<"Available "
           <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
           <<" (#"<<(e-infos)<<")\n";
    }
    if (all) {
        for (e = reserved.next; e != &reserved; e = e->next) {
            log<<"Reserved "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" (#"<<(e-infos)<<")\n";
        }
        for (e = used.next; e != &used; e = e->next) {
            log<<"Used "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" (#"<<(e-infos)<<") by "<< e->owner <<'\n';
        }
    }
}
