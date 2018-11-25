#include "I386/I386OStreamKernel.hpp"

#include "I386/I386IO_Port.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386PIC.hpp"
#include "I386/I386Keyboard.hpp"

extern "C" {
typedef void (*bootstrapFunc)(void*, void*, KernelRuntime *, int(*)(KernelRuntime *runtime, void*), void*);
int _syscall_entry(KernelRuntime *runtime, void * args);
}

void delay() {}

//public
I386OStreamKernel::I386OStreamKernel(Environment &env, MemoryInfo &mi, size_t size):OStreamKernel(env, mi, size), Object(env, mi) {}
I386OStreamKernel::~I386OStreamKernel() {}

size_t I386OStreamKernel::getStartAddress() {
    return (size_t) mem.buf;
}

void I386OStreamKernel::run(KernelRuntime &kr) {
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
    void *bootstrap;
    String &s = env().create<String>();
    // TODO: #12 read dependencies from meta data 
    ClassDescriptor &cdRuntime = kr.findDescriptor(s="/my/Runtime");
    ClassDescriptor &cdB = kr.findDescriptor(s="/my/B");
    bootstrapFunc bs = (bootstrapFunc)(((size_t)cdRuntime.desc)+0x14d);
    (*bs)(cdRuntime.desc, 0, &kr, _syscall_entry, 0);
    __asm__ __volatile__ ("movl -16(%%esp), %0" : "=r"(bootstrap) : ); // why -16?
    
    __asm__ __volatile__ ("jmp *%0" : : "r"(mem.buf), "a"(bootstrap), "b"(cdB.getCName()));
}
