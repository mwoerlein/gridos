#ifndef I386CGAOSTREAM_HPP_LOCK
#define I386CGAOSTREAM_HPP_LOCK

#include "sys/OStream.hpp"

class I386CgaOStream: public OStream {
    private:
	enum { index_port = 0x3d4, data_port = 0x3d5 , cga_ram = 0xB8000};
	enum { maxx = 80, maxy = 25};
	char* screen;
	int pos,base;
	OStream &printint(int i,int base=10,int count=1);
    public:
	I386CgaOStream(char* scr=(char*)cga_ram, int x=0, int y=0);
	virtual ~I386CgaOStream();
	virtual OStream &operator<<(char c);
	virtual OStream &operator<<(int i);
	virtual OStream &operator<<(void *ptr);
//	virtual OStream &operator<<(String &str);
	virtual void clear();
};

#endif //I386CGAOSTREAM_HPP_LOCK

