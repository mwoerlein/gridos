#ifndef KERNELJIT_HPP_LOCK
#define KERNELJIT_HPP_LOCK

#include "KernelJIT/Kernel.hpp"
#include "sys/Environment.hpp"
#include "sys/IStream.hpp"
#include "sys/Object.hpp"

class KernelJIT: public Object{
    private:
    public:
	KernelJIT(Environment &env);
	virtual ~KernelJIT() {}
	virtual Kernel &kernel_compile(IStream &in);
};

#endif //KERNELJIT_HPP_LOCK

