#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

#include "memory/MemoryAllocator.hpp"
#include "sys/Object.hpp"
#include "sys/OStream.hpp"

void* operator new (size_t size, void* location);

class ModuleInfo;
class Environment: virtual public Object {
    private:
    MemoryAllocator & ma;
    OStream & stdO;
    ModuleInfo * modules;
    
    public:
    Environment(MemoryAllocator &ma, OStream &stdO);
    virtual ~Environment();
    
    OStream &getStdO();
//    InStream &getStdIn();
//    OutStream &getStdOut();
    
    // TODO: access modules/kernel information via ids
    void setModules(ModuleInfo * mods);
    ModuleInfo * getModules();
    
    MemoryAllocator & getAllocator();
    void destroy(Object &obj);
    
    template <class Obj> Obj & create() {
        MemoryInfo &mi = ma.allocate(sizeof(Obj), this);
        return *(new (mi.buf) Obj(*this, mi));
    }
    
    template <class Obj, typename... Args> Obj & create(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(Obj), this);
        return *(new (mi.buf) Obj(*this, mi, args...));
    }
    
    template <class C> C & createNonObject() {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C);
    }
    
    template <class C, typename... Args> C & createNonObject(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(args...));
    }
};

#include "KernelJIT/ModuleInfo.hpp"

#endif //ENVIRONMENT_HPP_LOCK

