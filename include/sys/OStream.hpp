#ifndef OSTREAM_HPP_LOCK
#define OSTREAM_HPP_LOCK

//#include "sys/String.hpp"

class OStream {
    public:
	virtual ~OStream(){};
	virtual OStream &operator<<(char c)=0;
    virtual OStream &operator<<(int i){ return printint(i); }
    virtual OStream &operator<<(unsigned int i){ return printuint(i); }
	virtual OStream &operator<<(void *ptr){
        *this<<'0'<<'x';
        return printuint((unsigned int)ptr, 16, 8);
    };
//	virtual OStream &operator<<(String &s)=0;
	virtual	void clear()=0;
	protected:
	OStream &printint(int d, int base=10, int pad=0){
        if (d < 0) {
            *this << '-';
            d = -d;
        }
	    printuint((unsigned int) d, base, pad);
	}
	OStream &printuint(unsigned int d, int base=10, int pad=0){
        char buf[20];
        char *p = buf;
        unsigned long ud = d;
    
        /*  If D is minus, put `-' in the head. */
        if (d < 0) {
            *this << '-';
            ud = -d;
        }
    
        /*  Divide UD by BASE until UD == 0. */
        do {
            int remainder = ud % base;
            *p++ = (remainder < 10) ? remainder + '0' : remainder + 'a' - 10;
        } while (ud /= base);
        while (buf+pad > p) {
            *p++ = '0';
        }
        
        /* print reverse buffer */
        while (p > buf) {
            *this << *(--p);
        }
    
        return *this;
    };		
};

#endif //OSTREAM_HPP_LOCK

