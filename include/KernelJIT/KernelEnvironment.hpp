#ifndef KERNELJIT_KERNELENVIRONMENT_HPP_LOCK
#define KERNELJIT_KERNELENVIRONMENT_HPP_LOCK

#include "sys/Environment.hpp"
#include "sys/String.hpp"
#include "sys/collection/HashMap.hpp"
#include "KernelJIT/ModuleInfo.hpp"

class KernelEnvironment: public Environment, private HashMap<String, ModuleInfo> {
    public:
    KernelEnvironment(MemoryAllocator &ma, OStream &out, OStream &err);
    virtual ~KernelEnvironment();
    
    virtual void addModule(const char* commandline, MemoryInfo &moduleInfo);
    virtual bool hasModule(const char* moduleId);
    virtual ModuleInfo &getModule(const char* moduleId);
    virtual void destroyModules();
    
    inline bool hasModule(String & moduleId) {
        return has(moduleId);
    }
    inline ModuleInfo &getModule(String & moduleId) {
        return get(moduleId);
    }
    inline Iterator<ModuleInfo> & modules() {
        return iterator();
    }
};

#endif //KERNELJIT_KERNELENVIRONMENT_HPP_LOCK
