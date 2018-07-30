#include "sys/OStream.hpp"

// public

OStream & OStream::operator<<(int i) {
    return printint(i);
}

OStream & OStream::operator<<(unsigned int i) {
    return printuint(i);
}

OStream & OStream::operator<<(void * ptr) {
    *this<<'0'<<'x';
    return printuint((unsigned int)ptr, 16, 8);
}

OStream & OStream::operator<<(char * c) {
    while (*c) {
        *this<<*c++;
    }
    return *this;
}

OStream & OStream::operator<<(const char * c) {
    return *this<<(char *) c;
}


// protected

OStream & OStream::printint(int d, int base, int pad) {
    if (d < 0) {
        *this << '-';
        d = -d;
    }
    printuint((unsigned int) d, base, pad);
}

OStream & OStream::printuint(unsigned int d, int base, int pad) {
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
}		
