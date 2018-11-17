#ifndef KERNELJIT_KERNELRUNTIME_HPP_LOCK
#define KERNELJIT_KERNELRUNTIME_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/collection/HashMap.hpp"
#include "KernelJIT/ClassDescriptor.hpp"
#include "I386ASM/ASMInstructionList.hpp"

class KernelRuntime: protected HashMap<String, ClassDescriptor>, virtual public Object {
    public:
    KernelRuntime(Environment &env, MemoryInfo &mi):HashMap(env, mi), Object(env, mi) {}
    virtual ~KernelRuntime() {}
    virtual bool registerClass(pool_class_descriptor *desc);
    virtual pool_class_descriptor * findClass(const char *name);
    virtual void injectDefinitions(ASMInstructionList &list);
};

#endif //KERNELJIT_KERNELRUNTIME_HPP_LOCK
