#ifndef I386_I386SYSCALL_LOCK
#define I386_I386SYSCALL_LOCK

#include "KernelJIT/KernelRuntime.hpp"

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

extern "C" {
    typedef int (*syscallEntryFunc)(KernelRuntime *runtime, void * arguments);
    int _syscall_entry(KernelRuntime *runtime, void * arguments);
}

#endif //I386_I386SYSCALL_LOCK
