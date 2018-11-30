#ifndef KERNELJIT_MODULEHANDLER_HPP_LOCK
#define KERNELJIT_MODULEHANDLER_HPP_LOCK

#include "sys/Object.hpp"
#include "KernelJIT/Module.hpp"

class KernelRuntime;
class ModuleHandler: virtual public Object {
    protected:
    int logLevel = 0;
    
    public:
    virtual ~ModuleHandler() {}
    virtual ModuleHandler & setLogLevel(int level) {
        logLevel = level;
        return *this;
    } 
    
    virtual bool handles(Module & module) = 0;
    virtual bool handle(Module & module, KernelRuntime & runtime) = 0;
};

#include "KernelJIT/KernelRuntime.hpp"
#endif //KERNELJIT_MODULEHANDLER_HPP_LOCK
