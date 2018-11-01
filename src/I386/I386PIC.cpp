#include "I386/I386PIC.hpp"

#include "I386/I386IO_Port.hpp"

#define I386PIC_set_mask(mask) {\
    I386IO_Port(0xa1).outb(((mask) >> 8) & 0xff);\
    I386IO_Port(0x21).outb((mask) & 0xff);\
}

//public
I386PIC::I386PIC(Environment &env, MemoryInfo &mi):Object(env, mi), mask(0xfffb) {
    /* initialize PICs */
    I386IO_Port(0x20).outb(0x11);
    I386IO_Port(0xa0).outb(0x11);
    I386IO_Port(0x21).outb(0x20);
    I386IO_Port(0xa1).outb(0x28);
    I386IO_Port(0x21).outb(0x04);
    I386IO_Port(0xa1).outb(0x02);
    I386IO_Port(0x21).outb(0x01);
    I386IO_Port(0xa1).outb(0x01);
    I386PIC_set_mask(mask);
}
I386PIC::~I386PIC() {}

void I386PIC::activate(int nr) {
    mask &= ~(1<<nr);
    I386PIC_set_mask(mask);
}

void I386PIC::deactivate(int nr) {
    mask |= 1<<nr;
    I386PIC_set_mask(mask);
}

void I386PIC::finalize(int nr) {
    if ((nr >= 0) && (nr < 8)) {
        I386IO_Port(0x20).outb(0x60|(nr & 7));
    } else if ((nr >= 8) && (nr < 16)) {
        I386IO_Port(0x20).outb(0x62);
        I386IO_Port(0xa0).outb(0x60|(nr & 7));
    }
}
