#ifndef MEMORYMANAGER_HPP_LOCK
#define MEMORYMANAGER_HPP_LOCK

#include "memory/MemoryAllocator.hpp"
#include "memory/MemoryRegistry.hpp"
#include "sys/OStream.hpp"

class MemoryManager: public MemoryAllocator {
    private:
    OStream &log;
    MemoryListEntry available, reserved, used;
    MemoryInfoArray * nonEmbeddedEntries;
    friend void MemoryRegistry::transfer(MemoryManager &);
    
    public:
    MemoryManager(OStream &log);
    virtual ~MemoryManager() {}
    
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) override;
    virtual void free(void * ptr) override;
    virtual MemoryInfo & info(void * ptr) override;
    
    // debug
    virtual void dump(bool all = false);
};

#endif //MEMORYMANAGER_HPP_LOCK

