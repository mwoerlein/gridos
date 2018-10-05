#ifndef KERNELJIT_HPP_LOCK
#define KERNELJIT_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/stream/IStream.hpp"
#include "KernelJIT/Kernel.hpp"

class KernelJIT: virtual public Object {
    public:
    KernelJIT(Environment &env, MemoryInfo &mi):Object(env, mi) {}
    virtual ~KernelJIT() {}
    virtual Kernel &kernel_compile(IStream &in);
};

#endif //KERNELJIT_HPP_LOCK
