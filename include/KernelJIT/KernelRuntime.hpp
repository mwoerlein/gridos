#ifndef KERNELJIT_KERNELRUNTIME_HPP_LOCK
#define KERNELJIT_KERNELRUNTIME_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/collection/HashMap.hpp"
#include "sys/collection/LinkedList.hpp"
#include "sys/collection/PropertyContainer.hpp"
#include "memory/MemoryIOStream.hpp"
#include "KernelJIT/ClassDescriptor.hpp"
#include "KernelJIT/ModuleHandler.hpp"

class KernelRuntime: public PropertyContainer {
    protected:
    LinkedList<ModuleHandler> &handlers;
    HashMap<String, ClassDescriptor> &classes;
    
    ClassDescriptor * mainThread;
    ClassDescriptor * bsClass;
    MemoryIOStream * entry;
    
    public:
    KernelRuntime(Environment &env, MemoryInfo &mi);
    virtual ~KernelRuntime();
    
    virtual void addHandler(ModuleHandler &handler);
    virtual bool registerModule(Module &module);
    
    virtual bool setEntry(MemoryIOStream & entry);
    virtual ClassDescriptor * registerClass(MemoryIOStream & mem, size_t bootstrapOffset = 0);
    virtual bool hasClass(String &name);
    virtual ClassDescriptor * findClass(String &name);
    virtual bool resolveClasses();
    virtual bool isValid();
};

#endif //KERNELJIT_KERNELRUNTIME_HPP_LOCK
