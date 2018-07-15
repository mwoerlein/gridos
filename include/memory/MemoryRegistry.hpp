#ifndef MEMORYREGISTRY_HPP_LOCK
#define MEMORYREGISTRY_HPP_LOCK

#include "memory/MemoryTypes.hpp"
#include "sys/OStream.hpp"

#define isEmptyList(list) ((list)->next == (list))

class MemoryRegistry {
    private:
	MemoryListEntry entries[100];
	int entriesCounter;
	MemoryListEntry available, reserved, used;
	OStream &log;
	
    void removeFromList(MemoryListEntry * list, void * mem, size_t len);
    MemoryListEntry * findEntry(MemoryListEntry * list, void * buf);
    void insertAfterEntry(MemoryListEntry * entry, MemoryListEntry * newEntry);
    void removeEntry(MemoryListEntry * entry);
    
    MemoryListEntry * newEntry(void * mem, size_t len);
    MemoryListEntry * newReservedEntry(void * mem, size_t len);
    MemoryListEntry * newUsedEntry(void * mem, size_t len, void * owner);
    void freeEntry(MemoryListEntry * entry);
    
    public:
	MemoryRegistry(OStream &log):log(log),entriesCounter(0){
	    available.next = available.prev = &available;
	    reserved.next = reserved.prev = &reserved;
	    used.next = used.prev = &used;
	};
	virtual ~MemoryRegistry(){};
	virtual void registerAvailableMemory(void * mem, size_t len);
	virtual void registerReservedMemory(void * mem, size_t len);
	virtual void registerUsedMemory(void * mem, size_t len, void * owner = 0);
	virtual bool isAvailable(void * mem, size_t len);
//	virtual int availableCount();
//	virtual int reservedCount();
//	virtual int usedCount();
	virtual MemoryInfo &info(void * mem);
	virtual void dump();
};

#endif //MEMORYREGISTRY_HPP_LOCK

