#ifndef KERNELJIT_KERNELRUNTIME_HPP_LOCK
#define KERNELJIT_KERNELRUNTIME_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/collection/HashMap.hpp"
#include "KernelJIT/ClassDescriptor.hpp"
#include "I386ASM/ASMInstructionList.hpp"

class KernelRuntime: protected HashMap<String, ClassDescriptor>, virtual public Object {
    private:
    ClassDescriptor * mainThread;
    ClassDescriptor * bsClass;
    size_t bsOffset;
    
    public:
    KernelRuntime(Environment &env, MemoryInfo &mi):HashMap(env, mi), Object(env, mi), mainThread(0), bsClass(0), bsOffset(0) {}
    virtual ~KernelRuntime() {}
    virtual ClassDescriptor * registerClass(pool_class_descriptor *desc);
    virtual ClassDescriptor & findDescriptor(String &name);
    virtual pool_class_descriptor * findClass(const char *name);
    virtual bool resolveClasses();
    virtual bool setBootstrap(ClassDescriptor & desc, size_t offset);
    virtual bool setMainThread(ClassDescriptor & desc);
    virtual void run(void* entry);
};

#endif //KERNELJIT_KERNELRUNTIME_HPP_LOCK
