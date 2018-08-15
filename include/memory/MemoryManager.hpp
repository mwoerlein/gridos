#ifndef MEMORYMANAGER_HPP_LOCK
#define MEMORYMANAGER_HPP_LOCK

#include "memory/MemoryAllocator.hpp"
#include "memory/MemoryRegistry.hpp"
#include "sys/OStream.hpp"

class MemoryManager: public MemoryAllocator {
    private:
    OStream &log;
    void *head;
    MemoryListEntry * available;
    MemoryInfoArray * used;
    MemoryInfoArray * reserved;
    friend void MemoryRegistry::transfer(MemoryManager &);
    
    public:
    MemoryManager(OStream &log, void* head):log(log),head(head) {}
    virtual ~MemoryManager() {}
    
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) override;
    virtual void free(void * ptr) override;
    virtual MemoryInfo & info(void * ptr) override;
    
    // debug
    virtual void dump();
};

#endif //MEMORYMANAGER_HPP_LOCK

