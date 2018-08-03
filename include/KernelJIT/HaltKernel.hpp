#ifndef HALTKERNEL_HPP_LOCK
#define HALTKERNEL_HPP_LOCK

#include "KernelJIT/Kernel.hpp"
#if (CXX_VERSION2_95_4)
#define HaltInit() __asm__("movl $65535, %eax");\
    __asm__("pushl %eax");\
    __asm__("movl $1, %eax");\
    __asm__("pushl %eax");\
    __asm__("call _Z41__static_initialization_and_destruction_0");
#endif

#if (CXX_VERSION3_3_4)
#define HaltInit() __asm__("movl $65535, %eax");\
    __asm__("pushl %eax");\
    __asm__("movl $1, %eax");\
    __asm__("pushl %eax");\
    __asm__("call _Z41__static_initialization_and_destruction_0ii");
#endif


class HaltKernel: public Kernel {
    public:
    virtual void run() {
        while (1) {
            __asm__("hlt");
        }
    }
};

#endif //HALTKERNEL_HPP_LOCK
