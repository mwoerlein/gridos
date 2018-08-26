#include "I386/I386CgaOStream.hpp"
#include "I386/I386IO_Port.hpp"

I386CgaOStream::I386CgaOStream(Environment &env, MemoryInfo &mi, char* scr): Object(env, mi), screen(scr), pos(0) {
    I386IO_Port(index_port).outb(14);
    pos = I386IO_Port(data_port).inb()*512;
    I386IO_Port(index_port).outb(15);
    pos += I386IO_Port(data_port).inb()*2;
}

I386CgaOStream::~I386CgaOStream() {}

OStream &I386CgaOStream::operator <<(char c) {
    switch (c) {
    case '\n':
        pos -= pos%(2*maxx);
        pos += 2*maxx;
        break;
    case '\t':
        do { *this<<(' '); } while (pos%16);
        return *this;
    case '\0':
        break;
    default:
        screen[pos++] = c;
        screen[pos++] = 7;
    }
    if (pos >= 2*maxx*maxy) {
        char* c1 = screen;
        char* c2 = screen + 2*maxx;
        while (c2 < screen + 2*maxx*maxy) {
            *c1++ = *c2++;
        }
        while (c1 < screen + 2*maxx*maxy) {
            *c1++ = ' '; *c1++ = 7;
        }
        pos -= 2*maxx;
    }
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(pos/512);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb((pos/2)%256);
    return *this;
}

void I386CgaOStream::clear() {
    char* i = screen;
    while (i < screen + 2*maxx*maxy) {
        *i++ = ' '; *i++ = 7;
    }

    pos = 0;
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(0);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb(0);
}
