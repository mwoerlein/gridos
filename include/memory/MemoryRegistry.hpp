#ifndef MEMORYREGISTRY_HPP_LOCK
#define MEMORYREGISTRY_HPP_LOCK

#include "memory/MemoryAllocator.hpp"
#include "sys/OStream.hpp"

class MemoryManager;

class MemoryRegistry: public MemoryAllocator {
    private:
    MemoryListEntry entries[100];
    int entriesCounter;
    MemoryListEntry available, reserved, used;
    OStream &log;
    
    void removeFromList(MemoryListEntry * list, void * mem, size_t len);
    MemoryListEntry * findEntry(MemoryListEntry * list, void * buf);
    MemoryListEntry * findEntry(MemoryListEntry * list, size_t len);
    void insertAfterEntry(MemoryListEntry * entry, MemoryListEntry * newEntry);
    void removeEntry(MemoryListEntry * entry);
    
    MemoryListEntry * newEntry(void * mem, size_t len);
    MemoryListEntry * newReservedEntry(void * mem, size_t len);
    MemoryListEntry * newUsedEntry(void * mem, size_t len, void * owner);
    void freeEntry(MemoryListEntry * entry);
    
    int countNonEmbeddedEntries(MemoryListEntry * list);
    void transferMemoryList(MemoryListEntry * srcList, MemoryListEntry * destList, MemoryInfoArray * buffer = (MemoryInfoArray *) 0);
    
    public:
    MemoryRegistry(OStream &log);
    virtual ~MemoryRegistry() {}
    
    virtual void registerAvailableMemory(void * mem, size_t len);
    virtual void registerReservedMemory(void * mem, size_t len);
    virtual void registerUsedMemory(void * mem, size_t len, void * owner = 0);
    virtual bool isAvailable(void * mem, size_t len);
    
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) override;
    virtual void free(void * ptr) override;
    virtual MemoryInfo & info(void * ptr) override;
    
    void transfer(MemoryManager & memoryManager);
    
    // debug
    virtual void dump(bool all = false);
};

#endif //MEMORYREGISTRY_HPP_LOCK

