#ifndef I386CGAOSTREAM_HPP_LOCK
#define I386CGAOSTREAM_HPP_LOCK

#include "sys/stream/OStream.hpp"

class I386CgaOStream: public OStream {
    private:
    class FormattedOStream: public OStream {
        private:
        char format;
        I386CgaOStream &cga;
        
        public:
        using OStream::operator <<;
        FormattedOStream(Environment &env, MemoryInfo &mi, I386CgaOStream &cga, char format);
        virtual ~FormattedOStream();
        
        virtual OStream &operator <<(char c) override;
    };
    enum { index_port = 0x3d4, data_port = 0x3d5, cga_ram = 0xB8000 };
    enum { maxx = 80, maxy = 25 };
    char* screen;
    int pos;
    
    public:
    using OStream::operator <<;
    I386CgaOStream(Environment &env, MemoryInfo &mi = *notAnInfo, char* scr = (char*) cga_ram);
    virtual ~I386CgaOStream();
    
    virtual void clear(char format = 7);
    virtual OStream &getFormattedOStream(char format = 7);
    virtual OStream &printChar(char c, char format = 7);
    
    virtual OStream &operator <<(char c) override;
};

#endif //I386CGAOSTREAM_HPP_LOCK
