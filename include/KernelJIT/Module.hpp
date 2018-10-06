#ifndef KERNELJIT_MODULE_HPP_LOCK
#define KERNELJIT_MODULE_HPP_LOCK

#include "sys/collection/PropertyContainer.hpp"

class Module: public PropertyContainer {
    public:
    MemoryInfo & memoryInfo;
    
    Module(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo);
    virtual ~Module();
    
    virtual void parseHeader();
    virtual void parseCommandline(const char* commandline);
    inline String & getId() { return getStringProperty("meta.id"); }
};

#endif //KERNELJIT_MODULE_HPP_LOCK
