#ifndef HALTKERNEL_HPP_LOCK
#define HALTKERNEL_HPP_LOCK

#include "KernelJIT/Kernel.hpp"

class HaltKernel: public Kernel {
    public:
    HaltKernel(Environment &env, MemoryInfo &mi = *notAnInfo): Object(env, mi) {}
    virtual ~HaltKernel() {}
    
    virtual size_t getStartAddress() override {
        return 0;
    }
    
    virtual void run() {
        while (1) {
            __asm__("hlt");
        }
    }
};

#endif //HALTKERNEL_HPP_LOCK
