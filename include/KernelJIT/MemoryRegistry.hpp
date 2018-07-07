#ifndef MEMORYREGISTRY_HPP_LOCK
#define MEMORYREGISTRY_HPP_LOCK

typedef unsigned int size_t;

class MemoryRegistry {
    public:
	virtual ~MemoryRegistry(){};
	virtual void registerAvailableMemory(void * mem, size_t len)=0;
	virtual void registerReservedMemory(void * mem, size_t len)=0;
	virtual void registerUsedMemory(void * mem, size_t len, void * owner = 0)=0;
	virtual bool isAvailable(void * mem, size_t len)=0;
};

#endif //MEMORYREGISTRY_HPP_LOCK

