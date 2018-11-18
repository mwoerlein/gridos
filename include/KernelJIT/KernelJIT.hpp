#ifndef KERNELJIT_HPP_LOCK
#define KERNELJIT_HPP_LOCK

#include "sys/Object.hpp"
#include "KernelJIT/Kernel.hpp"
#include "KernelJIT/Module.hpp"
#include "KernelJIT/KernelRuntime.hpp"

class KernelJIT: virtual public Object {
    public:
    KernelJIT(Environment &env, MemoryInfo &mi):Object(env, mi) {}
    virtual ~KernelJIT() {}
    virtual Kernel &kernel_compile(Module &module, KernelRuntime &kr);
};

#endif //KERNELJIT_HPP_LOCK
