#include "I386/I386Keyboard.hpp"

#include "I386/I386IO_Port.hpp"
#include "I386/I386InterruptVectorTable.hpp"

#define empty_8042() { while (I386IO_Port(0x64).inb() & 3) { I386IO_Port(0x60).inb(); }}

//public
I386Keyboard::I386Keyboard(Environment &env, MemoryInfo &mi, I386PIC &pic):Object(env,mi), pic(pic) {
    /* empty keyboard buffer */
    empty_8042();
    I386IO_Port(0x64).outb(0xd1);
    empty_8042();
    I386IO_Port(0x60).outb(0xdf);
    empty_8042();
}
I386Keyboard::~I386Keyboard() {}

void I386Keyboard::plugin(InterruptVectorTable &ivt) {
    ivt.insert(I386InterruptVectorTable::keyboard, *this);
    pic.activate(I386PIC::keyboard);
}

void I386Keyboard::reboot() {
    int status;
    // 0x1234: Warm boot without memory check, 0x0: Cold boot with memory check
    *(unsigned short*) 0x472 = 0x1234; 

    while((status = I386IO_Port(0x64).inb()) & 0x02);
    I386IO_Port(0x64).outb(0xfe);
}

void I386Keyboard::call(int nr) {
    unsigned char code = I386IO_Port(0x60).inb();
    pic.finalize(I386PIC::keyboard);
    if (code == 0x81) { // ESC release
        Object::env().out() << "rebooting\n";
        for (int w = 0x9ffffff; w; w--);
        reboot();
    }
    (Object::env().out() << "code ").printhex(code) << '\n';
}
