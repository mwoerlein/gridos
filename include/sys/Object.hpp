#ifndef OBJECT_HPP_LOCK
#define OBJECT_HPP_LOCK

#include "memory/MemoryTypes.hpp"
class Environment;

class Object {
    private:
    Environment &_environment;
    MemoryInfo &_memory_info;
    friend class Environment;
    
    public:
    Object(Environment &env, MemoryInfo &mi):_environment(env),_memory_info(mi) {}
    virtual ~Object() {}
    
    Environment &env();
    virtual int hash();
    virtual bool equals(Object &o);
};
#include "sys/Environment.hpp"

#endif //OBJECT_HPP_LOCK

