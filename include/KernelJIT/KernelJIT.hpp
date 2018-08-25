#ifndef KERNELJIT_HPP_LOCK
#define KERNELJIT_HPP_LOCK

#include "KernelJIT/Kernel.hpp"
#include "sys/Environment.hpp"
#include "sys/IStream.hpp"
#include "sys/Object.hpp"

class KernelJIT: virtual public Object {
    public:
    KernelJIT(Environment &env, MemoryInfo &mi):Object(env, mi) {}
    virtual ~KernelJIT() {}
    virtual Kernel &kernel_compile(IStream &in);
};

#endif //KERNELJIT_HPP_LOCK
