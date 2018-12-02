#include "I386/I386SysCall.hpp"

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
    size_t descAddress;
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
    int _syscall_entry(KernelRuntime *runtime, void * arguments) {
        syscall_args * args = (syscall_args *) arguments; 
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
                cargs->descAddress = 0;
                String &s = env.create<String, const char*>(cargs->classname);
                if (runtime->hasClass(s)) {
                    cargs->descAddress = runtime->findClass(s)->getDescriptorAddress();
                }
                s.destroy();
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
