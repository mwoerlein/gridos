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
    Environment(MemoryAllocator &ma, OStream &stdO):Object(*this, ma.memInfo(this)),ma(ma),stdO(stdO) {}
    virtual ~Environment() {}
    /*
    InStream &getStdIn();
    OutStream &getStdOut();
    */
    
    OStream &getStdO() {
        return stdO;
    }
    
    void setModules(ModuleInfo * mods) {
        modules = mods;
    }
    
    ModuleInfo * getModules() {
        return modules;
    }
    
    MemoryAllocator & getAllocator() {
        return ma;
    }

    template <class C> C & create() {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(*this, mi));
    }
    
    template <class C, typename... Args> C & create(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(*this, mi, args...));
    }

    template <class C> C & _create() {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C);
    }
    
    template <class C, typename... Args> C & _create(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(args...));
    }
    
    void destroy(Object &c) {
        delete &c;
        ma.free(&c._memory_info);
    }
};

#include "KernelJIT/ModuleInfo.hpp"

#endif //ENVIRONMENT_HPP_LOCK

