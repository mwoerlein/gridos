#ifndef I386OSTREAMKERNEL_HPP_LOCK
#define I386OSTREAMKERNEL_HPP_LOCK

#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386IO_Port.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386PIC.hpp"
#include "I386/I386Keyboard.hpp"

class I386OStreamKernel: public OStreamKernel {
    private:
    void delay() {}
    
    public:
    I386OStreamKernel(Environment &env, MemoryInfo &mi, size_t size):OStreamKernel(env, mi, size), Object(env, mi) {}
    
    virtual void * getStart() {
        return mem.buf;
    }
    
    virtual void run() {
        I386InterruptVectorTable vt;
        I386PIC pic;
        I386Keyboard kbd(pic);
        
/* Koprozessoren zurücksetzen */        
        I386IO_Port(0xf0).outb(0);
        delay();
        I386IO_Port(0xf1).outb(0);
        delay();
        
/* Keyboard aktivieren */
        kbd.plugin(vt);
        
        vt.activate();
        __asm__("sti");
        
        __asm__ __volatile__ ("jmp *%0" : : "a"(mem.buf));
    }
};

#endif //I386OSTREAMKERNEL_HPP_LOCK
