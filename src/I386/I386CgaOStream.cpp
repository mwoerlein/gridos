#include "I386/I386CgaOStream.hpp"
#include "I386/I386IO_Port.hpp"

class I386CgaOStream::FormattedOStream: public OStream {
    private:
    char format;
    I386CgaOStream &cga;
    
    public:
    using OStream::operator <<;
    FormattedOStream(Environment &env, MemoryInfo &mi, I386CgaOStream &cga, char format);
    virtual ~FormattedOStream();
    
    virtual OStream &operator <<(char c) override;
};

I386CgaOStream::I386CgaOStream(Environment &env, MemoryInfo &mi, char* scr): Object(env, mi), screen(scr), pos(0) {
    I386IO_Port(index_port).outb(14);
    pos = I386IO_Port(data_port).inb()*512;
    I386IO_Port(index_port).outb(15);
    pos += I386IO_Port(data_port).inb()*2;
}

I386CgaOStream::~I386CgaOStream() {}

OStream &I386CgaOStream::operator <<(char c) {
    return printChar(c);
}

OStream &I386CgaOStream::printChar(char c, char format) {
    switch (c) {
    case '\n':
        while (pos%(2*maxx)) { *this<<(' '); }
        break;
    case '\t':
        do { *this<<(' '); } while (pos%16);
        return *this;
    case '\0':
        break;
    default:
        screen[pos++] = c;
        screen[pos++] = format;
    }
    if (pos >= 2*maxx*maxy) {
        char* c1 = screen;
        char* c2 = screen + 2*maxx;
        while (c2 < screen + 2*maxx*maxy) {
            *c1++ = *c2++;
        }
        while (c1 < screen + 2*maxx*maxy) {
            *c1++ = ' '; *c1++ = format;
        }
        pos -= 2*maxx;
    }
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(pos/512);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb((pos/2)%256);
    return *this;
}

void I386CgaOStream::clear(char format) {
    char* i = screen;
    while (i < screen + 2*maxx*maxy) {
        *i++ = ' '; *i++ = format;
    }

    pos = 0;
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(0);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb(0);
}

OStream &I386CgaOStream::getFormattedOStream(char format) {
    return env().create<FormattedOStream, I386CgaOStream&, char>(*this, format);
}

I386CgaOStream::FormattedOStream::FormattedOStream(Environment &env, MemoryInfo &mi, I386CgaOStream &cga, char format)
    : Object(env, mi), cga(cga), format(format) {}
I386CgaOStream::FormattedOStream::~FormattedOStream() {}

OStream &I386CgaOStream::FormattedOStream::operator <<(char c) {
    cga.printChar(c, format);
    return *this;
}
