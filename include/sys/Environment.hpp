#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

#include "memory/MemoryAllocator.hpp"
#include "sys/OStream.hpp"

void* operator new (size_t size, void* location);

class ModuleInfo;
class Environment {
    private:
    MemoryAllocator & ma;
    OStream & stdO;
    ModuleInfo * modules;
    
    public:
    Environment(MemoryAllocator &ma, OStream &stdO):ma(ma),stdO(stdO) {}
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
        return *(new (mi.buf) C(*this));
    }
    
    template <class C, typename... Args> C & create(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(*this, args...));
    }

    template <class C> C & _create() {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C);
    }
    
    template <class C, typename... Args> C & _create(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(args...));
    }
    
    template <class C> void destroy(C &c) {
        delete &c;
        ma.free(&c);
    }
};

#include "KernelJIT/ModuleInfo.hpp"

#endif //ENVIRONMENT_HPP_LOCK

