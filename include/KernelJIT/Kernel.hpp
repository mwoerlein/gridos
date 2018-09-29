#ifndef KERNEL_HPP_LOCK
#define KERNEL_HPP_LOCK

#include "sys/Object.hpp"

class Kernel: virtual public Object {
    public:
    virtual ~Kernel() {}
    virtual void * getStart() = 0;
    virtual void run() = 0;
};

#endif //KERNEL_HPP_LOCK
