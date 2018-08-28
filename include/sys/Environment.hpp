#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

#include "sys/Object.hpp"
#include "memory/MemoryAllocator.hpp"

void* operator new (size_t size, void* location);

class ModuleInfo;
class OStream;

class Environment: virtual public Object {
    private:
    MemoryAllocator * ma;
    OStream * stdO;
    ModuleInfo * modules;
    
    public:
    Environment();
    Environment(MemoryAllocator &ma, OStream &stdO);
    Environment(Environment &env, MemoryInfo &mi, MemoryAllocator &ma, OStream &stdO);
    virtual ~Environment();
    
    OStream & getStdO();
    OStream & setStdO(OStream & out);
    
//    InStream &getStdIn();
//    OutStream &getStdOut();
    
    // TODO: access modules/kernel information via ids
    ModuleInfo & setModules(ModuleInfo & mods);
    ModuleInfo & getModules();
    
    MemoryAllocator & getAllocator();
    MemoryAllocator & setAllocator(MemoryAllocator & allocator);
    
    void destroy(Object &obj);
    
    template <class Obj> Obj & create() {
        MemoryInfo &mi = ma->allocate(sizeof(Obj), this);
        return *(new (mi.buf) Obj(*this, mi));
    }
    
    template <class Obj, typename... Args> Obj & create(Args... args) {
        MemoryInfo &mi = ma->allocate(sizeof(Obj), this);
        return *(new (mi.buf) Obj(*this, mi, args...));
    }
    
    /*
     * evil runtime cast which fails if obj is not primary derived from As!
     * TODO #6: implement RTTI correctly
     */
    template <class As> As * as(Object &obj, RTTI rtti) {
        return (As *) ((obj.rtti() == rtti) ? obj._memory_info->buf : 0);
    }
};

#include "KernelJIT/ModuleInfo.hpp"
#include "sys/OStream.hpp"

#endif //ENVIRONMENT_HPP_LOCK

