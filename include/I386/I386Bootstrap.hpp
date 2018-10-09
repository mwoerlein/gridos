#ifndef I386BOOTSTRAP_HPP_LOCK
#define I386BOOTSTRAP_HPP_LOCK

#include "KernelJIT/KernelEnvironment.hpp"

class I386Bootstrap {
    private:
    void trickCompiler();
    
    public:
    I386Bootstrap() {}
    virtual ~I386Bootstrap() {}
    static KernelEnvironment & buildEnvironment(unsigned long magic, void *mbi, void *mbh);
};

#endif //I386BOOTSTRAP_HPP_LOCK
