#ifndef KERNEL_HPP_LOCK
#define KERNEL_HPP_LOCK

class Kernel {
    public:
    virtual ~Kernel() {}
    virtual void run() = 0;
};

#endif //KERNEL_HPP_LOCK
