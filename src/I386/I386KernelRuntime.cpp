#include "I386/I386KernelRuntime.hpp"

#include "I386/I386IO_Port.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386PIC.hpp"
#include "I386/I386Keyboard.hpp"
#include "I386/I386SysCall.hpp"

extern "C" {
    typedef void (*bootstrapFunc)(void*, void*, KernelRuntime *, syscallEntryFunc, void*);
}

void delay() {}

//public
I386KernelRuntime::I386KernelRuntime(Environment &env, MemoryInfo &mi):KernelRuntime(env, mi), Object(env, mi) {}
I386KernelRuntime::~I386KernelRuntime() {}

size_t I386KernelRuntime::getStartAddress() {
    return entry ? (size_t) entry->getStartAddress() : -1;
}

void I386KernelRuntime::run() {
    I386InterruptVectorTable &vt = env().create<I386InterruptVectorTable>();
    I386PIC &pic = env().create<I386PIC>();
    I386Keyboard &kbd = env().create<I386Keyboard, I386PIC&>(pic);
    
/* reset coprozessors */        
    I386IO_Port(0xf0).outb(0);
    delay();
    I386IO_Port(0xf1).outb(0);
    delay();
    
/* activate keyboard and interrupts */
    kbd.plugin(vt);
    vt.activate();
    
/* run kernel */
    void *runtime = 0;
    const char *main = 0;
    if (bsClass) {
        bootstrapFunc bs = (bootstrapFunc) bsClass->getBootstrapAddress();
        (*bs)((void*) bsClass->getDescriptorAddress(), 0, this, _syscall_entry, 0);
        __asm__ __volatile__ ("movl -16(%%esp), %0" : "=r"(runtime) : ); // why -16?
    }
    if (mainThread) {
        main = mainThread->getCName();
    }
    
    __asm__ __volatile__ ("jmp *%0" : : "r"(entry->getStartAddress()), "a"(runtime), "b"(main));
}
