#ifndef MEMORYMANAGER_HPP_LOCK
#define MEMORYMANAGER_HPP_LOCK

#include "sys/Object.hpp"
#include "memory/MemoryAllocator.hpp"
#include "memory/MemoryRegistry.hpp"

class MemoryManager: public MemoryAllocator {
    private:
    MemoryInfo available, reserved, used;
    MemoryInfoArray * nonEmbeddedInfos;
    friend void MemoryRegistry::transfer(MemoryManager &);
    
    public:
    MemoryManager(Environment &env, MemoryInfo &mi);
    virtual ~MemoryManager() {}
    
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) override;
    virtual void free(void * ptr) override;
    virtual size_t getAvailableBytes() override;
    virtual MemoryInfo & memInfo(void * ptr) override;
    
    // debug
    virtual void dump(bool all = false) override;
};

#endif //MEMORYMANAGER_HPP_LOCK

