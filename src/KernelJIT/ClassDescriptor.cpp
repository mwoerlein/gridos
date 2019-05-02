#include "KernelJIT/ClassDescriptor.hpp"

typedef struct {
    struct pool_class_descriptor * class_desc;
    size_t classname_offset;
    size_t vtab_offset;
    size_t handle_offset;
} pool_vtabs_entry;

typedef struct pool_class_descriptor {
    size_t magic;
    void * class_instance;
    size_t classname_offset;
    size_t class_tabs_offset;
    size_t method_tabs_offset;
    size_t methods_tab_offset;
    size_t inst_tpl_offset;
    size_t inst_tpl_size;
    size_t obj_handle_offset;
    size_t class_handle_offset;
    size_t class_size;
    pool_vtabs_entry vtabs[];
} pool_class_descriptor;


// public
ClassDescriptor::ClassDescriptor(Environment &env, MemoryInfo &mi, MemoryIOStream &mem, size_t bootstrapOffset)
            :Object(env, mi), mem(mem), name(env.create<String, const char *>(getCName())), bootstrapOffset(bootstrapOffset) {}
ClassDescriptor::~ClassDescriptor() {
    name.destroy();
    mem.destroy();
}

bool ClassDescriptor::isValid() {
    pool_class_descriptor *desc = (pool_class_descriptor*) mem.getStartAddress();
    if (desc->magic != 0x15AC1A55) {
        return false;
    }
    if (desc->class_size != mem.length()) {
        return false;
    }
    if (bootstrapOffset != 0) {
        return bootstrapOffset > 0 && bootstrapOffset < mem.length();
    }
    return true;
}

String & ClassDescriptor::getName() {
    return name;
}

const char * ClassDescriptor::getCName() {
    pool_class_descriptor *desc = (pool_class_descriptor*) mem.getStartAddress();
    return (const char *) ((size_t) desc + desc->classname_offset);
}

bool ClassDescriptor::hasBootstrap() {
    return bootstrapOffset != 0;
}

size_t ClassDescriptor::getBootstrapAddress() {
    if (bootstrapOffset == 0) {
        return 0;
    }
    return mem.getStartAddress() + bootstrapOffset;
}

size_t ClassDescriptor::getDescriptorAddress() {
    return mem.getStartAddress();
}

bool ClassDescriptor::resolve(KernelRuntime &runtime) {
    pool_class_descriptor *desc = (pool_class_descriptor*) mem.getStartAddress();
    // resolve vtabs
    for (int i = 0; desc->vtabs[i].classname_offset; i++) {
        String &s = env().create<String, const char*>((const char*) ((size_t) desc + desc->vtabs[i].classname_offset));
        if (!runtime.hasClass(s)) {
            env().err() << "unknown class " << s << "\n";
            s.destroy();
            return false;
        }
        desc->vtabs[i].class_desc = (pool_class_descriptor*) runtime.findClass(s)->getDescriptorAddress();
        s.destroy();
    }
    return true;
}
