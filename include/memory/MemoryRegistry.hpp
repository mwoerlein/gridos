#ifndef MEMORYREGISTRY_HPP_LOCK
#define MEMORYREGISTRY_HPP_LOCK

#include "memory/MemoryTypes.hpp"
#include "sys/OStream.hpp"

class MemoryRegistry {
    private:
	MemoryListEntry entries[100];
	int entriesCounter;
	MemoryListEntry used, available, reserved;
	OStream &log;
    public:
	MemoryRegistry(OStream &log):log(log),entriesCounter(0){};
	virtual ~MemoryRegistry(){};
	virtual void registerAvailableMemory(void * mem, size_t len);
	virtual void registerReservedMemory(void * mem, size_t len);
	virtual void registerUsedMemory(void * mem, size_t len, void * owner = 0);
	virtual bool isAvailable(void * mem, size_t len);
//	virtual int availableCount();
//	virtual int reservedCount();
//	virtual int usedCount();
	virtual void dump();
};

#endif //MEMORYREGISTRY_HPP_LOCK

