#include "memory/MemoryManager.hpp"

#include "memory/MemoryInfoHelper.hpp"

// public
MemoryManager::MemoryManager(Environment &env, MemoryInfo &mi): Object(env, mi) {
    initMemoryInfoList(&available);
    initMemoryInfoList(&reserved);
    initMemoryInfoList(&used);
}

MemoryInfo & MemoryManager::allocate(size_t len, void * owner) {
    size_t required = len + sizeof(MemoryInfo);
    
    if (required < len) { // size_t overflow
        env().err()<<"bad allocate "<<len<<"\n";
        return *notAnInfo;
    }
    
    // find available memory
    MemoryInfo * avail = findInfo(&available, required);
    if (avail->len < required) {
        env().err()<<"bad allocate "<<len<<"\n";
        return *notAnInfo;
    }
    
    if (avail->len < (required + 2*sizeof(MemoryInfo))) {
        // use whole info
        avail->buf = memoryEnd(avail, sizeof(MemoryInfo));
        avail->len -= sizeof(MemoryInfo);
        
        // remove from available
        unlinkMemoryInfo(avail);
    } else {
        // split info
        MemoryInfo * remain = (MemoryInfo *) memoryEnd(avail, required);
        remain->buf = (void *) remain;
        remain->len = avail->len - required;
        remain->flags.magic = MEMORY_INFO_MAGIC;
        remain->flags.used = remain->flags.reserved = 0;

        avail->buf = memoryEnd(avail, sizeof(MemoryInfo));
        avail->len = len;

        // replace avail by remain in available
        replaceMemoryInfo(avail, remain);
    }
    
    // append to used
    avail->flags.used = 1;
    avail->owner = owner;
    //MemoryInfo * prev = findInfo(&used, avail->buf); // for sorted used-list
    MemoryInfo * prev = used.prev;
    appendMemoryInfo(prev, avail);
    
    return *avail;
}

void MemoryManager::free(MemoryInfo & memoryInfo) {
    MemoryInfo * info = &memoryInfo;
    if ((info == notAnInfo) || !info->flags.used) {
        env().err()<<"bad free "<<&memoryInfo<<"\n";
        return;
    }
    
    // remove from used
    info->flags.used = 0;
    info->owner = (void *) 0;
    unlinkMemoryInfo(info);

    if (hasFollowingBuffer(info)) {
        // adjust embedded info
        info->buf = info;
        info->len += sizeof(MemoryInfo);
    } else {
        MemoryInfo * nonEmbeddedInfo = info;
        
        // create embedded info
        info = (MemoryInfo *) nonEmbeddedInfo->buf;
        info->buf = nonEmbeddedInfo->buf;
        info->len = nonEmbeddedInfo->len;
        info->flags = nonEmbeddedInfo->flags;
        info->owner = nonEmbeddedInfo->owner;
        
        // clear non-embedded info
        initMemoryInfoList(nonEmbeddedInfo);
    }

    // insert into available
    MemoryInfo * prev  = findInfo(&available, info->buf);
    appendMemoryInfo(prev, info);
    MemoryInfo * next = info->next;
    
    if ((memoryInfoEnd(info) == next->buf) && (next != &available)) {
        // merge right
        info->len = memoryDiff(info->buf, memoryInfoEnd(next)); 
        unlinkMemoryInfo(next);
        next->flags.magic = 0;
    }
    if ((memoryInfoEnd(prev) == info->buf) && (prev != &available)) {
        // merge left
        prev->len = memoryDiff(prev->buf, memoryInfoEnd(info));
        unlinkMemoryInfo(info);
        info->flags.magic = 0;
        
        if (!isEmbeddedInfo(prev) && canEmbedInfo(prev)) {
            MemoryInfo * nonEmbeddedInfo = prev;
            
            // create embedded info
            prev = (MemoryInfo *) nonEmbeddedInfo->buf;
            prev->buf = nonEmbeddedInfo->buf;
            prev->len = nonEmbeddedInfo->len;
            prev->flags = nonEmbeddedInfo->flags;
            prev->owner = nonEmbeddedInfo->owner;
            
            replaceMemoryInfo(nonEmbeddedInfo, prev);
            // clear non-embedded info
            initMemoryInfoList(nonEmbeddedInfo);
        }
    }
}

size_t MemoryManager::getAvailableBytes() {
    size_t bytes = 0;
    for (MemoryInfo *e = available.next; e != &available; e = e->next) {
        bytes += e->len;
    }
    return bytes;
}

MemoryInfo & MemoryManager::memInfo(void * ptr) {
    if (isMemoryInfo(ptr)) {
        return *((MemoryInfo *) ptr);
    }
    if ((size_t) ptr >= sizeof(MemoryInfo)) {
        void * info = memoryEnd(ptr, -sizeof(MemoryInfo));
        if (isMemoryInfo(info)) {
            return *((MemoryInfo *) info);
        }
    }
    for (int i = 0; i < nonEmbeddedInfos->size; i++) {
        MemoryInfo * info = &nonEmbeddedInfos->elements[i];
        if ((info->buf == ptr) && ((info->flags.used == 1) || (info->flags.reserved == 1))) {
            return *info;
        }
    }
    return *notAnInfo;
}

// debug
void MemoryManager::dump(OStream &log, bool all) {
    for (MemoryInfo * e = available.next; e != &available; e = e->next) {
        log<<"Available "
           <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
           <<" ("<<(void *) e<<")\n";
    }
    if (all) {
        for (MemoryInfo * e = reserved.next; e != &reserved; e = e->next) {
            log<<"Reserved "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" ("<<(void *) e<<")\n";
        }
        for (MemoryInfo * e = used.next; e != &used; e = e->next) {
            log<<"Used "
               <<(void *) e->buf<<':'<<memoryEnd(e->buf, e->len)<<'['<<(void *) e->len<<']'
               <<" ("<<(void *) e<<")\n";
        }
    }
}
