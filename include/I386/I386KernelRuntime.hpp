#ifndef I386_I386KERNELRUNTIME_HPP_LOCK
#define I386_I386KERNELRUNTIME_HPP_LOCK

#include "KernelJIT/Kernel.hpp"
#include "KernelJIT/KernelRuntime.hpp"

class I386KernelRuntime: public Kernel, public KernelRuntime {
    public:
    I386KernelRuntime(Environment &env, MemoryInfo &mi);
    virtual ~I386KernelRuntime();
    
    virtual size_t getStartAddress() override;
    virtual void run() override;
};

#endif //I386_I386KERNELRUNTIME_HPP_LOCK
