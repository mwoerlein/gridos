#ifndef KERNELJIT_CLASSDESCRIPTOR_HPP_LOCK
#define KERNELJIT_CLASSDESCRIPTOR_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/String.hpp"
#include "memory/MemoryIOStream.hpp"

class KernelRuntime;
class ClassDescriptor: virtual public Object {
    protected:
    MemoryIOStream &mem;
    String &name;
    size_t bootstrapOffset;
    
    public:
    ClassDescriptor(Environment &env, MemoryInfo &mi, MemoryIOStream &mem, size_t bootstrapOffset = 0);
    virtual ~ClassDescriptor();
    
    virtual bool isValid();
    virtual String & getName();
    virtual const char * getCName();
    virtual bool hasBootstrap();
    virtual size_t getBootstrapAddress();
    virtual size_t getDescriptorAddress();
    virtual bool resolve(KernelRuntime &runtime);
};
#include "KernelJIT/KernelRuntime.hpp"

#endif //KERNELJIT_CLASSDESCRIPTOR_HPP_LOCK
