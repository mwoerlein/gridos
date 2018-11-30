#ifndef KERNELJIT_MODULEHANDLER_STOREHANDLER_HPP_LOCK
#define KERNELJIT_MODULEHANDLER_STOREHANDLER_HPP_LOCK

#include "KernelJIT/ModuleHandler.hpp"

class StoreHandler: public ModuleHandler {
    public:
    StoreHandler(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~StoreHandler();
    
    virtual bool handles(Module & module) override;
    virtual bool handle(Module & module, KernelRuntime & runtime) override;
};

#endif //KERNELJIT_MODULEHANDLER_STOREHANDLER_HPP_LOCK
