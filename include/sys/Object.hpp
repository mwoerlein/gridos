#ifndef OBJECT_HPP_LOCK
#define OBJECT_HPP_LOCK

#include "memory/MemoryTypes.hpp"
class Environment;
class OStream;

// TODO #6: implement RTTI correctly
enum RTTI { object, boolean, character, integer, string, asm_operand };

class Object {
    private:
    Environment &_environment;
    
    protected:
    MemoryInfo *_memory_info;
    friend class Environment;
    
    public:
    Object(Environment &env, MemoryInfo &mi):_environment(env),_memory_info(&mi) {}
    virtual ~Object() {}
    virtual void destroy();
    
    Environment &env();
    virtual int hash();
    virtual bool equals(Object &o);
    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() { return object; };
    virtual OStream & operator >>(OStream & stream);
};

#include "sys/Environment.hpp"
#include "sys/OStream.hpp"

#endif //OBJECT_HPP_LOCK

