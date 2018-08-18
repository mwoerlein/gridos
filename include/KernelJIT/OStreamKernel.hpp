#ifndef OSTREAMKERNEL_HPP_LOCK
#define OSTREAMKERNEL_HPP_LOCK

#include "sys/OStream.hpp"
#include "KernelJIT/Kernel.hpp"

class OStreamKernel: public Kernel, public OStream{
    public:
    virtual ~OStreamKernel() {}
};

#endif //OSTREAMKERNEL_HPP_LOCK
