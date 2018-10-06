#ifndef KERNELJIT_MODULE_HPP_LOCK
#define KERNELJIT_MODULE_HPP_LOCK

#include "sys/collection/PropertyContainer.hpp"

#define PROPERTYPREFIX_DEFAULT "meta."
#define PROPERTYNAME_MODULE_ID "meta.id"

class Module: public PropertyContainer {
    public:
    MemoryInfo & memoryInfo;
    
    Module(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo);
    virtual ~Module();
    
    virtual bool parseHeader();
    virtual bool parseCommandline(const char* commandline);
    
    inline bool hasId() { return hasStringProperty(PROPERTYNAME_MODULE_ID); }
    inline String & getId() { return getStringProperty(PROPERTYNAME_MODULE_ID); }
    inline Object & setId(String & id) { return setStringProperty(PROPERTYNAME_MODULE_ID, id); }
};

#endif //KERNELJIT_MODULE_HPP_LOCK
