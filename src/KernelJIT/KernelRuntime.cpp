#include "KernelJIT/KernelRuntime.hpp"

#include "I386ASM/Operand/Number.hpp"

// TODO: #12 separate class registry and runtime/syscall
enum SysCall {
    allocate = 1,
    free = 2,
    find_class = 3,
    print = 4,
};
enum SysPrintKind {
    spk_char = 0,
    spk_int = 1,
    spk_hex = 2,
    spk_string = 3,
};
enum SysPrintStream {
    out = 0,
    err = 1,
};

typedef struct {
    SysCall call;
} syscall_args;

typedef struct {
    SysCall call;
    size_t size;
    MemoryInfo *info;
} syscall_args_allocator;

typedef struct {
    SysCall call;
    const char * classname;
    pool_class_descriptor * desc;
} syscall_args_find_class;

typedef struct {
    SysCall call;
    SysPrintStream stream;
    SysPrintKind kind;
    union {
        int i;
        char * str;
    } arg;
} syscall_args_print;

extern "C" {
    int _syscall_entry(KernelRuntime *runtime, syscall_args * args) {
        Environment &env = runtime->env();
        MemoryAllocator &ma = env.getAllocator(); 
        switch (args->call) {
            case allocate: {
                syscall_args_allocator * cargs = (syscall_args_allocator*) args;
                cargs->info = &ma.allocate(cargs->size);
                return 0;
            }
            case free: {
                ma.free(*((syscall_args_allocator*) args)->info);
                return 0;
            }
            case find_class: {
                syscall_args_find_class * cargs = (syscall_args_find_class*) args;
                cargs->desc = runtime->findClass(cargs->classname);
                return 0;
            }
            case print: {
                syscall_args_print * cargs = (syscall_args_print*) args;
                OStream &stream = (cargs->stream == out) ? env.out() : env.err(); 
                switch (cargs->kind) {
                    case spk_char:
                        stream << (char) cargs->arg.i;
                        return 0;
                    case spk_int:
                        stream << cargs->arg.i;
                        return 0;
                    case spk_hex:
                        stream.printhex(cargs->arg.i);
                        return 0;
                    case spk_string:
                        stream << cargs->arg.str;
                        return 0;
                }
                env.err() << "invalid print kind " << cargs->kind << '\n';
                return -1;
            }
        }
        env.err() << "invalid syscall " << args->call << '\n';
        return -1;
    }
}

bool KernelRuntime::registerClass(pool_class_descriptor *desc) {
    if (desc->magic != 0x15AC1A55) {
        env().err() << "try to register invalid class at " << desc << '\n';
        return false;
    }
    
    ClassDescriptor &cd = env().create<ClassDescriptor, pool_class_descriptor*>(desc);
    if (has(cd.name)) {
        env().err() << "class " << cd.name << " already registered\n";
        return false;
    }
    set(cd.name, cd);
    return true;
}

bool KernelRuntime::resolveClasses() {
    Iterator<ClassDescriptor> &cds = values();
    while (cds.hasNext()) {
        pool_class_descriptor *desc = cds.next().desc;
        // resolve vtabs
        for (int i = 0; desc->vtabs[i].classname_offset; i++) {
            const char * name = (const char *) ((size_t) desc + desc->vtabs[i].classname_offset);
            desc->vtabs[i].class_desc = findClass(name);
            if (!desc->vtabs[i].class_desc) {
                env().err() << "unknown class " << name << "\n";
                return false;
            }
        }
    }
    cds.destroy();
    return true;
}

ClassDescriptor &KernelRuntime::findDescriptor(String &name) {
    return get(name);
}

pool_class_descriptor * KernelRuntime::findClass(const char *name) {
    String &s = env().create<String, const char*>(name);
    pool_class_descriptor * ret = has(s) ? get(s).desc : 0;
    s.destroy();
    return ret;
}
