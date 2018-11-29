#ifndef OSTREAMKERNEL_HPP_LOCK
#define OSTREAMKERNEL_HPP_LOCK

#include "memory/MemoryIOStream.hpp"
#include "KernelJIT/Kernel.hpp"

class OStreamKernel: public Kernel, public MemoryIOStream {
    public:
    OStreamKernel(Environment &env, MemoryInfo &mi, size_t size): MemoryIOStream(env, mi, env.getAllocator().allocate(size)) {}
    virtual ~OStreamKernel() {
        if (&mem != notAnInfo) {
            env().getAllocator().free(mem);
        }
    }
};

#endif //OSTREAMKERNEL_HPP_LOCK
