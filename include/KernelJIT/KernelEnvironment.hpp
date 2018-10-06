#ifndef KERNELJIT_KERNELENVIRONMENT_HPP_LOCK
#define KERNELJIT_KERNELENVIRONMENT_HPP_LOCK

#include "sys/Environment.hpp"
#include "sys/String.hpp"
#include "sys/collection/HashMap.hpp"
#include "KernelJIT/Module.hpp"

class KernelEnvironment: public Environment, private HashMap<String, Module> {
    public:
    KernelEnvironment(MemoryAllocator &ma, OStream &out, OStream &err);
    virtual ~KernelEnvironment();
    
    virtual void addModule(const char* commandline, MemoryInfo &moduleMemoryInfo, const char* id = 0);
    virtual bool hasModule(const char* moduleId);
    virtual Module &getModule(const char* moduleId);
    virtual void destroyModules();
    
    inline bool hasModule(String & moduleId) {
        return has(moduleId);
    }
    inline Module &getModule(String & moduleId) {
        return get(moduleId);
    }
    inline Iterator<Module> & modules() {
        return iterator();
    }
    
    inline bool testSetting(const char * moduleId, const char * property, const char * value) {
        return hasModule(moduleId) && getModule(moduleId).testStringProperty(property, value);
    }
};

#endif //KERNELJIT_KERNELENVIRONMENT_HPP_LOCK
