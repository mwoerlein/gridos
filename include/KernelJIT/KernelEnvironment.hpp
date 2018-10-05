#ifndef KERNELJIT_KERNELENVIRONMENT_HPP_LOCK
#define KERNELJIT_KERNELENVIRONMENT_HPP_LOCK

#include "sys/Environment.hpp"
#include "sys/String.hpp"
#include "sys/collection/MutableMap.hpp"
#include "KernelJIT/ModuleInfo.hpp"

class KernelEnvironment: public Environment {
    private:
    MutableMap<String, ModuleInfo> *_modules;
    
    public:
    KernelEnvironment(MemoryAllocator &ma, OStream &out, OStream &err);
    virtual ~KernelEnvironment();
    
    virtual void addModule(const char* commandline, MemoryInfo &moduleInfo);
    virtual bool hasModule(const char* moduleId);
    virtual ModuleInfo &getModule(const char* moduleId);
    virtual void destroyModules();
    
    inline bool hasModule(String & moduleId) {
        return _modules->has(moduleId);
    }
    inline ModuleInfo &getModule(String & moduleId) {
        return _modules->get(moduleId);
    }
    inline Iterator<ModuleInfo> & modules() {
        return _modules->iterator();
    }
};

#endif //KERNELJIT_KERNELENVIRONMENT_HPP_LOCK
