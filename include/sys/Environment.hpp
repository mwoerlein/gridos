#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

class ModuleInfo;
class OStream;
class OStreamFactory;
#include "sys/Object.hpp"
#include "memory/MemoryAllocator.hpp"

void* operator new (size_t size, void* location);

class Environment: virtual public Object {
    private:
    MemoryAllocator * ma;
    OStream *_out, *_err;
    ModuleInfo * modules;
    OStreamFactory *_factory;
    
    public:
    Environment();
    Environment(MemoryAllocator &ma, OStream &out, OStream &err);
    Environment(Environment &env, MemoryInfo &mi, MemoryAllocator &ma, OStream &out, OStream &err);
    virtual ~Environment();
    
    OStream & out();
    OStream & setOut(OStream & newOut);
    OStream & err();
    OStream & setErr(OStream & newErr);
    OStreamFactory & oStreamFactory();
    OStreamFactory & setOStreamFactory(OStreamFactory & factory);
    
    // TODO: access modules/kernel information via ids
    ModuleInfo & setModules(ModuleInfo & mods);
    ModuleInfo & getModules();
    
    MemoryAllocator & getAllocator();
    MemoryAllocator & setAllocator(MemoryAllocator & allocator);
    
    using Object::destroy;
    inline void destroy(Object &obj) {
        delete &obj; // call destructors
        ma->free(*(obj._memory_info)); // free memory
    }
    
    template <class Obj, typename... Args> Obj & create(Args... args) {
        MemoryInfo &mi = ma->allocate(sizeof(Obj), this);
        return *(new (mi.buf) Obj(*this, mi, args...));
    }
    
    /*
     * evil runtime cast which fails if obj is not created at heap or primary derived from As!
     * TODO #6: implement RTTI correctly
     */
    template <class As> As * as(Object &obj, RTTI rtti) {
        if (&obj && (obj._memory_info != notAnInfo) && (obj.rtti() == rtti)) {
            return (As *) obj._memory_info->buf;
        }
        return 0;
    }
};

#include "KernelJIT/ModuleInfo.hpp"
#include "sys/stream/OStream.hpp"

#endif //ENVIRONMENT_HPP_LOCK

