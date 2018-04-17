#include "I386/I386CgaOStream.hpp"
#include "I386/I386IO_Port.hpp"

I386CgaOStream::I386CgaOStream(char* scr,int x,int y):screen(scr),base(10){
    I386IO_Port(index_port).outb(14);
    pos=I386IO_Port(data_port).inb()*512;
    I386IO_Port(index_port).outb(15);
    pos+=I386IO_Port(data_port).inb()*2;
};
I386CgaOStream::~I386CgaOStream(){};
OStream &I386CgaOStream::operator<<(char c){
    switch (c) {
	case '\n':
	    pos-=pos%(2*maxx);
	    pos+=2*maxx;
	    break;
	case '\t':
	    while (pos%16) *this<<(' ');
	    return *this;
	case '\0':
	    break;
	default:
	    screen[pos++]=c;
	    screen[pos++]=7;
    }
    if (pos>=2*maxx*maxy){
	char* c1=screen;
	char* c2=screen+2*maxx;
	while(c2<screen+2*maxx*maxy){*c1++=*c2++;}
	while(c1<screen+2*maxx*maxy){*c1++=' ';*c1++=7;}
	pos-=2*maxx;
    };
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(pos/512);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb((pos/2)%256);
    return *this;
};
OStream &I386CgaOStream::printint(int i,int base, int count){
    char c;
    while (count<=i/base) count*=base; 
    while (count>0){
	c=(char) (((int)i/count)%base);
	if (c<10) *this<<(char)('0'+c);
	else *this<<(char)('a'+c-10);
	count/=base;
    }
    return *this;
};
OStream &I386CgaOStream::operator<<(int i){ return printint(i,base,1); }
OStream &I386CgaOStream::operator<<(void *ptr){
    char c; int count;
    *this<<'0'<<'x';
/*    for (count=28;count>=0;count-=4){
	c=(char) (((int32_t)ptr>>count)%16);
	if (c<10) *this<<(char)('0'+c);
	else *this<<(char)('a'+c-10);
    }
    return *this;*/
    return printint((unsigned long)ptr,16,0x10000000);
};
/*
OStream &I386CgaOStream::operator<<(String &str){
    char* ack=(char*) ack;
    while (ack) *this<<*ack++;
    return *this;
};
*/
void I386CgaOStream::clear(){
    char* i=screen;
    while (i<screen+2*maxx*maxy){ *i++=' ';*i++=7; }

    pos=0;
    I386IO_Port(index_port).outb(14);
    I386IO_Port(data_port).outb(0);
    I386IO_Port(index_port).outb(15);
    I386IO_Port(data_port).outb(0);
};

