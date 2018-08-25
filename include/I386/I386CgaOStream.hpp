#ifndef I386CGAOSTREAM_HPP_LOCK
#define I386CGAOSTREAM_HPP_LOCK

#include "sys/OStream.hpp"

class I386CgaOStream: public OStream {
    private:
    enum { index_port = 0x3d4, data_port = 0x3d5, cga_ram = 0xB8000 };
    enum { maxx = 80, maxy = 25 };
    char* screen;
    int pos;
    
    public:
    using OStream::operator<<;
    I386CgaOStream(Environment &env, MemoryInfo &mi, char* scr = (char*) cga_ram);
    virtual ~I386CgaOStream();
    virtual OStream &operator<<(char c) override;
    virtual void clear() override;
};

#endif //I386CGAOSTREAM_HPP_LOCK
