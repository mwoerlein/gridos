#ifndef I386PIC_HPP_LOCK
#define I386PIC_HPP_LOCK

#include "I386/I386IO_Port.hpp"

#define set(mask) {\
    I386IO_Port(0xa1).outb(((mask) >> 8) & 0xff);\
    I386IO_Port(0x21).outb((mask) & 0xff);\
}

class I386PIC {
    private:
    int16_t mask;
    
    public:
    enum { timer = 0, keyboard = 1 };
    
    I386PIC():mask(0xfffb) {
        /*PICs-Umprogrammieren*/
        I386IO_Port(0x20).outb(0x11);
        I386IO_Port(0xa0).outb(0x11);
        I386IO_Port(0x21).outb(0x20);
        I386IO_Port(0xa1).outb(0x28);
        I386IO_Port(0x21).outb(0x04);
        I386IO_Port(0xa1).outb(0x02);
        I386IO_Port(0x21).outb(0x01);
        I386IO_Port(0xa1).outb(0x01);
        set(mask);
    }
    virtual ~I386PIC() {}
    
    void activate(int nr) {
        mask &= ~(1<<nr);
        set(mask);
    }
    
    void deactivate(int nr) {
        mask |= 1<<nr;
        set(mask);
    }
    
    void finalize(int nr) {
        if ((nr >= 0) && (nr < 8)) {
            I386IO_Port(0x20).outb(0x60|(nr & 7));
        } else if ((nr >= 8) && (nr < 16)) {
            I386IO_Port(0x20).outb(0x62);
            I386IO_Port(0xa0).outb(0x60|(nr & 7));
        }
    }
};

#endif //I386PIC_HPP_LOCK

