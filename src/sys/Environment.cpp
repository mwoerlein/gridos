#include "sys/Environment.hpp"

void* operator new (size_t size, void* location) {
    return location;
}

Environment::Environment():Object(*this, *notAnInfo),ma(0),stdO(0) {}
Environment::Environment(MemoryAllocator &ma, OStream &stdO):Object(*this, ma.memInfo(this)),ma(&ma),stdO(&stdO) {}
Environment::~Environment() {}

OStream & Environment::getStdO() {
    return *stdO;
}
OStream & Environment::setStdO(OStream & out) {
    OStream *old = stdO;
    stdO = &out;
    return *old;
};

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
};

void Environment::destroy(Object &obj) {
    // call destructors
    delete &obj;
    // free memory
    ma->free(obj._memory_info);
}
