#ifndef MODULEINFO_HPP_LOCK
#define MODULEINFO_HPP_LOCK

#include "memory/MemoryTypes.hpp"
#include "sys/Object.hpp"

class ModuleInfo: public Object {
    public:
    ModuleInfo * next;
    MemoryInfo & memoryInfo;
    // TODO: use String
    char * cmd;
    
    ModuleInfo(Environment & env, MemoryInfo & mi, char * cmd, ModuleInfo * next = 0):
        Object(env), memoryInfo(mi), cmd(cmd), next(next) {}
    virtual ~ModuleInfo() {}
};

#endif //MODULEINFO_HPP_LOCK
