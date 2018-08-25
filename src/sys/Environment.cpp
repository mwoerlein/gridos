#include "sys/Environment.hpp"

void* operator new (size_t size, void* location) {
    return location;
}

Environment::Environment(MemoryAllocator &ma, OStream &stdO):Object(*this, ma.memInfo(this)),ma(ma),stdO(stdO) {}
Environment::~Environment() {}

OStream &Environment::getStdO() {
    return stdO;
}

void Environment::setModules(ModuleInfo * mods) {
    modules = mods;
}

ModuleInfo * Environment::getModules() {
    return modules;
}

MemoryAllocator & Environment::getAllocator() {
    return ma;
}

void Environment::destroy(Object &obj) {
    // call destructors
    delete &obj;
    // free memory
    ma.free(&obj._memory_info);
}
