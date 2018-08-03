#ifndef I386KEYBOARD_HPP_LOCK
#define I386KEYBOARD_HPP_LOCK

#include "I386/I386PIC.hpp"
#include "sys/InterruptHandler.hpp"

class I386Keyboard: public InterruptHandler {
    private:
    I386PIC &pic;
    int pos;
    
    inline void empty_8042() {
        while (I386IO_Port(0x64).inb()&3) {
            I386IO_Port(0x60).inb();
        }
    }
    
    public:
    inline I386Keyboard(I386PIC &pic):pic(pic),pos(0) {
        /*Tastaturpuffer leeren*/
        empty_8042();
        I386IO_Port(0x64).outb(0xd1);
        empty_8042();
        I386IO_Port(0x60).outb(0xdf);
        empty_8042();
    }
    
    inline void plugin(InterruptVectorTable &ivt) {
        ivt.insert(I386InterruptVectorTable::keyboard,*this);
        pic.activate(I386PIC::keyboard);
    }
    
    inline void call(int nr) {
        char* s = &((char*) 0xb8000)[pos];
        pic.finalize(I386PIC::keyboard);
        *s++ = 'r'; *s++ = 7;
        *s++ = 'e'; *s++ = 7;
        *s++ = 'b'; *s++ = 7;
        *s++ = 'o'; *s++ = 7;
        *s++ = 'o'; *s++ = 7;
        *s++ = 't'; *s++ = 7;
        *s++ = 'i'; *s++ = 7;
        *s++ = 'n'; *s++ = 7;
        *s++ = 'g'; *s++ = 7;
        for (; (int32_t)s-0xb8000<160; ) {
            *s++ = ' '; *s++ = 7;
        }
        for (int w = 0x9ffffff; w; w--);
        reboot();
    }

    inline void reboot() {
        int status;
        // 0x1234: Warm boot without memory check, 0x0: Cold boot with memory check
        *(unsigned short*) 0x472 = 0x1234; 

        while((status = I386IO_Port(0x64).inb()) & 0x02);
        I386IO_Port(0x64).outb(0xfe);
    }
};

#endif //I386KEYBOARD_HPP_LOCK
