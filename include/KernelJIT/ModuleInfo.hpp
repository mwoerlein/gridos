#ifndef MODULEINFO_HPP_LOCK
#define MODULEINFO_HPP_LOCK

#include "sys/Object.hpp"

class ModuleInfo: virtual public Object {
    public:
    ModuleInfo * next;
    MemoryInfo & memoryInfo;
    // TODO: use String
    char * cmd;
    
    ModuleInfo(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo, char * cmd, ModuleInfo * next = 0):
        Object(env, mi), memoryInfo(memoryInfo), cmd(cmd), next(next) {}
    virtual ~ModuleInfo() {
        env().getAllocator().free(&memoryInfo);
    }
};

#endif //MODULEINFO_HPP_LOCK
