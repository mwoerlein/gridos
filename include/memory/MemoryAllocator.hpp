#ifndef MEMORYALLOCATOR_HPP_LOCK
#define MEMORYALLOCATOR_HPP_LOCK

#include "sys/Object.hpp"

class MemoryAllocator: virtual public Object {
    protected:
    
    inline MemoryInfo * findInfo(MemoryInfo * list, void * buf) {
        MemoryInfo * cur;
        for (cur = list; cur->next != list && cur->next->buf <= buf; cur = cur->next);
        return cur;
    }
    
    inline MemoryInfo * findInfo(MemoryInfo * list, size_t required) {
        MemoryInfo * cur;
        for (cur = list; cur->next != list && cur->len < required; cur = cur->next);
        return cur;
    }
        
    public:
    virtual ~MemoryAllocator() {}
    
    // TODO: add alignment?
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) = 0;
    virtual void free(void * ptr) = 0;
    virtual MemoryInfo & memInfo(void * ptr) = 0;
};

#endif //MEMORYALLOCATOR_HPP_LOCK

