#ifndef MEMORYREGISTRY_HPP_LOCK
#define MEMORYREGISTRY_HPP_LOCK

#include "sys/Object.hpp"
#include "memory/MemoryAllocator.hpp"

class MemoryManager;

class MemoryRegistry: public MemoryAllocator {
    private:
    MemoryInfo infos[100];
    int infosCounter;
    MemoryInfo available, reserved, used;
    
    void removeFromList(MemoryInfo * list, void * mem, size_t len);
    void removeInfo(MemoryInfo * info);
    
    MemoryInfo * newInfo(void * mem, size_t len);
    MemoryInfo * newReservedInfo(void * mem, size_t len);
    MemoryInfo * newUsedInfo(void * mem, size_t len, void * owner);
    
    int countNonEmbeddedInfos(MemoryInfo * list);
    void transferMemoryList(MemoryInfo * srcList, MemoryInfo * destList, MemoryInfoArray * buffer);
    
    public:
    MemoryRegistry(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~MemoryRegistry() {}
    
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) override;
    virtual void free(MemoryInfo & memoryInfo) override;
    virtual size_t getAvailableBytes() override;
    virtual MemoryInfo & memInfo(void * ptr) override;
    
    void registerAvailableMemory(void * mem, size_t len);
    void registerReservedMemory(void * mem, size_t len);
    void registerUsedMemory(void * mem, size_t len, void * owner = 0);
    void transfer(MemoryManager & memoryManager);
    
    // debug
    virtual void dump(OStream &log, bool all = false) override;
};

#endif //MEMORYREGISTRY_HPP_LOCK

