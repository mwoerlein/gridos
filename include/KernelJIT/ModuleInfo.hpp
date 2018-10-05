#ifndef KERNELJIT_MODULEINFO_HPP_LOCK
#define KERNELJIT_MODULEINFO_HPP_LOCK

#include "sys/collection/PropertyContainer.hpp"

class ModuleInfo: public PropertyContainer {
    public:
    MemoryInfo & memoryInfo;
    
    ModuleInfo(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo);
    virtual ~ModuleInfo();
};

#endif //KERNELJIT_MODULEINFO_HPP_LOCK
