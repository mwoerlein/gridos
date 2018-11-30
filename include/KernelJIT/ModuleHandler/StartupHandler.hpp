#ifndef KERNELJIT_MODULEHANDLER_STARTUPHANDLER_HPP_LOCK
#define KERNELJIT_MODULEHANDLER_STARTUPHANDLER_HPP_LOCK

#include "KernelJIT/ModuleHandler.hpp"

class StartupHandler: public ModuleHandler {
    public:
    StartupHandler(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~StartupHandler();
    
    virtual bool handles(Module & module) override;
    virtual bool handle(Module & module, KernelRuntime & runtime) override;
};

#endif //KERNELJIT_MODULEHANDLER_STARTUPHANDLER_HPP_LOCK
