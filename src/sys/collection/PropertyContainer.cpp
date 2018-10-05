#include "sys/collection/PropertyContainer.hpp"

#include "sys/collection/LinkedList.hpp"

// public
PropertyContainer::PropertyContainer(Environment &env, MemoryInfo &mi):
        HashMap(env,mi), Object(env, mi), ownStrings(env.create<LinkedList<String>>()) {
}

PropertyContainer::~PropertyContainer() {
    Iterator<String> &ownIt = ownStrings.iterator();
    while (ownIt.hasNext()) {
        ownIt.next().destroy();
    }
    ownIt.destroy();
    ownStrings.destroy();
}

String & PropertyContainer::createOwnString(const char* name) {
    String &own = env().create<String, const char*>(name);
    ownStrings.add(own); 
    return own;
}

bool PropertyContainer::hasProperty(const char* name) {
    String &tmp = env().create<String, const char*>(name); 
    bool ret = hasProperty(tmp);
    tmp.destroy();
    return ret;
}
    
Object & PropertyContainer::getProperty(const char* name) {
    String &tmp = env().create<String, const char*>(name); 
    Object &ret = getProperty(tmp);
    tmp.destroy();
    return ret;
}
    
bool PropertyContainer::hasStringProperty(const char* name) {
    String &tmp = env().create<String, const char*>(name); 
    bool ret = hasStringProperty(tmp);
    tmp.destroy();
    return ret;
}
    
String & PropertyContainer::getStringProperty(const char* name)  {
    String &tmp = env().create<String, const char*>(name); 
    String &ret = getStringProperty(tmp);
    tmp.destroy();
    return ret;
}
