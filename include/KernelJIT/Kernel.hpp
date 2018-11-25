#ifndef KERNEL_HPP_LOCK
#define KERNEL_HPP_LOCK

#include "sys/Object.hpp"
#include "KernelJIT/KernelRuntime.hpp"

class Kernel: virtual public Object {
    public:
    virtual ~Kernel() {}
    virtual size_t getStartAddress() = 0;
    virtual void run(KernelRuntime &kr) = 0;
};

#endif //KERNEL_HPP_LOCK
