#ifndef KERNELJIT_CLASSDESCRIPTOR_HPP_LOCK
#define KERNELJIT_CLASSDESCRIPTOR_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/String.hpp"

typedef struct {
    struct pool_class_descriptor * class_desc;
    size_t classname_offset;
    size_t vtab_offset;
    size_t handle_offset;
} pool_vtabs_entry;

typedef struct pool_class_descriptor {
    void * class_instance;
    size_t classname_offset;
    size_t inst_tpl_size;
    size_t inst_tpl_offset;
    size_t obj_handle_offset;
    size_t class_handle_offset;
    size_t magic;
    pool_vtabs_entry vtabs[];
} pool_class_descriptor;

// TODO: #12 Improve memory handling (avoid lost memoryinfos/MemoryOStreams/Modules/..., free descriptor memory on destruction, ...)
class ClassDescriptor: virtual public Object {
    public:
    pool_class_descriptor *desc;
    String &name;
    
    ClassDescriptor(Environment &env, MemoryInfo &mi, pool_class_descriptor *desc)
            :Object(env, mi), desc(desc), name(env.create<String, const char *>(getCName())) {}
    virtual ~ClassDescriptor() {
        name.destroy();
    }
    const char * getCName() {
        return (char *) ((size_t) desc + desc->classname_offset);
    }
};

#endif //KERNELJIT_CLASSDESCRIPTOR_HPP_LOCK
