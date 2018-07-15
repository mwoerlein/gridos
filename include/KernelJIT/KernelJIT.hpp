#ifndef KERNELJIT_HPP_LOCK
#define KERNELJIT_HPP_LOCK

#include "KernelJIT/Kernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "KernelJIT/DebugSystem.hpp"
#include "sys/IStream.hpp"

class KernelJIT{
    private:
	IStream &in;
	OStreamKernel &osk;
	DebugSystem &ds;
    public:
	KernelJIT(IStream &in,OStreamKernel &osk,DebugSystem &ds);
	virtual Kernel &kernel_compile();
};

#endif //KERNELJIT_HPP_LOCK

