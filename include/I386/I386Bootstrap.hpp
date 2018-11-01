#ifndef I386_I386BOOTSTRAP_HPP_LOCK
#define I386_I386BOOTSTRAP_HPP_LOCK

#include "KernelJIT/KernelEnvironment.hpp"

class I386Bootstrap {
    public:
    static KernelEnvironment & buildEnvironment(unsigned long magic, void *mbi, void *mbh);
};

#endif //I386_I386BOOTSTRAP_HPP_LOCK
