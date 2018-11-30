#ifndef KERNELJIT_MODULEHANDLER_X86HANDLER_HPP_LOCK
#define KERNELJIT_MODULEHANDLER_X86HANDLER_HPP_LOCK

#include "KernelJIT/ModuleHandler.hpp"

class X86Handler: public ModuleHandler {
    public:
    X86Handler(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~X86Handler();
    
    virtual bool handles(Module & module) override;
    virtual bool handle(Module & module, KernelRuntime & runtime) override;
};

#endif //KERNELJIT_MODULEHANDLER_X86HANDLER_HPP_LOCK
