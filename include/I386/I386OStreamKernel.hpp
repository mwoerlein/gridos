#ifndef I386_I386OSTREAMKERNEL_HPP_LOCK
#define I386_I386OSTREAMKERNEL_HPP_LOCK

#include "KernelJIT/OStreamKernel.hpp"

class I386OStreamKernel: public OStreamKernel {
    public:
    I386OStreamKernel(Environment &env, MemoryInfo &mi, size_t size);
    virtual ~I386OStreamKernel();
    
    virtual size_t getStartAddress() override;
    virtual void run(KernelRuntime &kr) override;
};

#endif //I386_I386OSTREAMKERNEL_HPP_LOCK
