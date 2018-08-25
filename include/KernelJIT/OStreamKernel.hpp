#ifndef OSTREAMKERNEL_HPP_LOCK
#define OSTREAMKERNEL_HPP_LOCK

#include "memory/MemoryOStream.hpp"
#include "KernelJIT/Kernel.hpp"

class OStreamKernel: public Kernel, public MemoryOStream {
    public:
    OStreamKernel(Environment &env, MemoryInfo &mi, size_t size): MemoryOStream(env, mi, env.getAllocator().allocate(size)) {}
    virtual ~OStreamKernel() {
        env().getAllocator().free(&mem);
    }
};

#endif //OSTREAMKERNEL_HPP_LOCK
