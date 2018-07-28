#ifndef MEMORYALLOCATOR_HPP_LOCK
#define MEMORYALLOCATOR_HPP_LOCK

#include "memory/MemoryTypes.hpp"

class MemoryAllocator {
    public:
    virtual ~MemoryAllocator() {}
    
    // TODO: add alignment
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) = 0;
    virtual void free(void * ptr) = 0;
};

#endif //MEMORYALLOCATOR_HPP_LOCK

