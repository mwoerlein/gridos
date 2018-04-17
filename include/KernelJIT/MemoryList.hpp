#ifndef MEMORYLIST_HPP_LOCK
#define MEMORYLIST_HPP_LOCK

#include "sys/IStream.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "KernelJIT/DebugSystem.hpp"

class MemoryList{
    public:
	virtual ~MemoryList(){};
    virtual IStream &getKernelText()=0;
    virtual OStreamKernel &getOStreamKernel()=0;
	virtual int getStackSpace()=0;
	virtual int getMemSize()=0;
	virtual void printBuffers(DebugSystem &ds)=0;
};

#endif //MEMORYLIST_HPP_LOCK

