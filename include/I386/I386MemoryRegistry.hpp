#ifndef I386MEMORYREGISTRY_HPP_LOCK
#define I386MEMORYREGISTRY_HPP_LOCK

#include "I386/I386DebugSystem.hpp"
#include "KernelJIT/MemoryRegistry.hpp"

typedef struct {
    unsigned long used      : 1;
    unsigned long reserved  : 1;
    unsigned long align     : 30;
} mem_flags;

typedef struct MemoryListEntry {
    void* buf;
    size_t len;
    mem_flags flags;
    void* owner;
    struct MemoryListEntry* prev;
    struct MemoryListEntry* next;
} MemoryListEntry;

class I386MemoryRegistry: public MemoryRegistry {
    private:
	MemoryListEntry entries[100];
	int entriesCounter;
	MemoryListEntry used, available, reserved;
	I386DebugSystem ds;
    public:
	I386MemoryRegistry(I386DebugSystem &ds);
	virtual ~I386MemoryRegistry();
	virtual void registerAvailableMemory(void * mem, size_t len);
	virtual void registerReservedMemory(void * mem, size_t len);
	virtual void registerUsedMemory(void * mem, size_t len, void * owner = 0);
	virtual bool isAvailable(void * mem, size_t len);
//	virtual int availableCount();
//	virtual int reservedCount();
//	virtual int usedCount();
	virtual void dump();
};

#endif //I386MEMORYREGISTRY_HPP_LOCK
