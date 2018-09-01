#ifndef OSTREAM_HPP_LOCK
#define OSTREAM_HPP_LOCK

#include "sys/Object.hpp"

class Char;
class Integer;
class String;
class IStream;
class OStream: virtual public Object {
    protected:
    OStream &printint(int d, int base = 10, int pad = 0);
    OStream &printuint(unsigned int d, int base = 10, int pad = 0);
    
    public:
    virtual ~OStream() {}
    
    virtual OStream &operator <<(char c) = 0;
    virtual OStream &operator <<(int i);
    virtual OStream &operator <<(unsigned int i);
    virtual OStream &operator <<(void *ptr);
    virtual OStream &operator <<(char *c);
    virtual OStream &operator <<(const char *c);
    
    virtual OStream &operator <<(Char &c);
    virtual OStream &operator <<(Integer &i);
    virtual OStream &operator <<(String &s);
    virtual OStream &operator <<(IStream &stream);
};

#endif //OSTREAM_HPP_LOCK

