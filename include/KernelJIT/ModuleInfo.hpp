#ifndef MODULEINFO_HPP_LOCK
#define MODULEINFO_HPP_LOCK

#include "sys/Object.hpp"
class String;

class ModuleInfo: virtual public Object {
    public:
    ModuleInfo * next;
    MemoryInfo & memoryInfo;
    String & cmd;
    
    ModuleInfo(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo, String & cmd, ModuleInfo * next = 0);
    virtual ~ModuleInfo();
};

#endif //MODULEINFO_HPP_LOCK
