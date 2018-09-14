#include "sys/Environment.hpp"

#include "sys/OStreamFactory.hpp"

void* operator new (size_t size, void* location) {
    return location;
}

Environment::Environment():Object(*this, *notAnInfo),ma(0),_out(0),_err(0),_factory(0) {}
Environment::Environment(MemoryAllocator &ma, OStream &out, OStream &err)
    :Object(*this, ma.memInfo(this)),ma(&ma),_out(&out),_err(&err),_factory(0) {}
Environment::Environment(Environment &env, MemoryInfo &mi, MemoryAllocator &ma, OStream &out, OStream &err)
    :Object(env, mi),ma(&ma),_out(&out),_err(&err),_factory(0) {}
Environment::~Environment() {}

OStream & Environment::out() {
    return *_out;
}

OStream & Environment::setOut(OStream & out) {
    OStream *old = _out;
    _out = &out;
    return *old;
}

OStream & Environment::err() {
    return *_err;
}

OStream & Environment::setErr(OStream & err) {
    OStream *old = _err;
    _err = &err;
    return *old;
}

OStreamFactory & Environment::oStreamFactory() {
    if (!_factory) {
        *_err<<"accessing dummy OStreamFactory!\n";
        _factory = &create<OStreamFactory>();
    }
    return *_factory;
}

OStreamFactory & Environment::setOStreamFactory(OStreamFactory & factory) {
    OStreamFactory *old = _factory;
    _factory = &factory;
    return *old;
}

ModuleInfo & Environment::getModules() {
    return *modules;
}

ModuleInfo & Environment::setModules(ModuleInfo & mods) {
    ModuleInfo *old = modules;
    modules = &mods;
    return *old;
}

MemoryAllocator & Environment::getAllocator() {
    return *ma;
}

MemoryAllocator & Environment::setAllocator(MemoryAllocator & allocator) {
    MemoryAllocator *old = ma;
    ma = &allocator;
    // refresh _memory_info from new allocator
    this->_memory_info = &ma->memInfo(this);
    return *old;
}
