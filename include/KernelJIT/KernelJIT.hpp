#ifndef KERNELJIT_HPP_LOCK
#define KERNELJIT_HPP_LOCK

#include "KernelJIT/Kernel.hpp"
#include "KernelJIT/MemoryList.hpp"
#include "KernelJIT/DebugSystem.hpp"

class KernelJIT{
    private:
	MemoryList &ml;
	DebugSystem &ds;
    public:
	KernelJIT(MemoryList &ml,DebugSystem &ds);
	virtual Kernel &kernel_compile();
};

#endif //KERNELJIT_HPP_LOCK

