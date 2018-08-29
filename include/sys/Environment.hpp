#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

class ModuleInfo;
class OStream;
#include "sys/Object.hpp"
#include "memory/MemoryAllocator.hpp"

void* operator new (size_t size, void* location);

class Environment: virtual public Object {
    private:
    MemoryAllocator * ma;
    OStream *_out, *_err;
    ModuleInfo * modules;
    
    public:
    Environment();
    Environment(MemoryAllocator &ma, OStream &out, OStream &err);
    Environment(Environment &env, MemoryInfo &mi, MemoryAllocator &ma, OStream &out, OStream &err);
    virtual ~Environment();
    
    OStream & out();
    OStream & setOut(OStream & newOut);
    OStream & err();
    OStream & setErr(OStream & newErr);
    
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

