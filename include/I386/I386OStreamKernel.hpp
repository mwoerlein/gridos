#ifndef I386OSTREAMKERNEL_HPP_LOCK
#define I386OSTREAMKERNEL_HPP_LOCK

#include "I386/I386IO_Port.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386PIC.hpp"
#include "I386/I386Keyboard.hpp"
#include "memory/MemoryTypes.hpp"
#include "KernelJIT/OStreamKernel.hpp"

class I386OStreamKernel: public OStreamKernel, public Object {
    private:
    MemoryInfo &mem;
    size_t pos;
    
    void delay() {}
    inline void empty_8042() { 
        while (I386IO_Port(0x64).inb()&3) {
            delay();
            I386IO_Port(0x60).inb(); 
        }
    }
    
    public:
    using OStream::operator<<;
    I386OStreamKernel(Environment &env, size_t size):Object(env),mem(env.getAllocator().allocate(size)),pos(0) {}
    virtual ~I386OStreamKernel() {
        env().destroy(mem);
    }
    
    virtual OStream &operator<<(char c) {
        ((char*)mem.buf)[pos++] = c;
        return *this;
    }
    
    virtual void clear() {
        pos = 0;
    }
    
    virtual void run() {
        I386InterruptVectorTable vt;
        I386PIC pic;
        I386Keyboard kbd(pic);
        
/* Koprozessoren zurücksetzten */        
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
