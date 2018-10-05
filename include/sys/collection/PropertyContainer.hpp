#ifndef SYS_COLLECTION_PROPERTYCONTAINER_HPP_LOCK
#define SYS_COLLECTION_PROPERTYCONTAINER_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/String.hpp"
#include "sys/collection/HashMap.hpp"
#include "sys/collection/MutableCollection.hpp"

class PropertyContainer: protected HashMap<String, Object>, virtual public Object {
    protected:
    MutableCollection<String> &ownStrings;
    String & createOwnString(const char* s);
    
    public:
    PropertyContainer(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~PropertyContainer();
    
    // Object accessors
    virtual bool hasProperty(const char* name);
    inline bool hasProperty(String & name) {
        return has(name);
    }
    virtual Object & getProperty(const char* name);
    inline Object & getProperty(String & name) {
        return get(name);
    }
    inline Object & setProperty(const char* name, Object & o) {
        return set(createOwnString(name), o);
    }
    inline Object & setProperty(String & name, Object & o) {
        return set(name, o);
    }
    
    // String accessors
    virtual bool hasStringProperty(const char* name);
    virtual String & getStringProperty(const char* name); 
    
    inline bool hasStringProperty(String & name) {
        return env().as<String>(get(name), string);
    }
    inline String & getStringProperty(String & name) {
        return *env().as<String>(get(name), string);
    }
    inline Object & setStringProperty(const char* name, const char* value) {
        return set(createOwnString(name), createOwnString(value));
    }
    inline Object & setStringProperty(const char* name, String & value){
        return set(createOwnString(name), value);
    }
    inline Object & setStringProperty(String & name, const char* value){
        return set(name, createOwnString(value));
    }
    inline Object & setStringProperty(String & name, String & value){
        return set(name, value);
    }
    
    // TODO: add Integer/Bool/... property accessors and conversions
};

#endif //SYS_COLLECTION_PROPERTYCONTAINER_HPP_LOCK
