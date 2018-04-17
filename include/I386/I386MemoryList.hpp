#ifndef I386MEMORYLIST_HPP_LOCK
#define I386MEMORYLIST_HPP_LOCK

#include "KernelJIT/MemoryList.hpp"
#include "I386/MemoryType.hpp"
#include "I386/I386KernelTextIStream.hpp"
#include "I386/I386OStreamKernel.hpp"

class I386MemoryList: public MemoryList {
    private:
	memlist *ml;
//	I386KernelTextIStream kt;
//	I386OStreamKernel osk;
    public:
	I386MemoryList(memlist *ml);
	virtual ~I386MemoryList();
//	virtual IStream &getKernelText();
//	virtual OStreamKernel &getOStreamKernel();
	virtual int getStackSpace();
	virtual int getMemSize();
	virtual void printBuffers(DebugSystem &ds);
};

#endif //I386MEMORYLIST_HPP_LOCK
