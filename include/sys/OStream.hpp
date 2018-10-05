#ifndef OSTREAM_HPP_LOCK
#define OSTREAM_HPP_LOCK

#include "sys/Object.hpp"

class Char;
class Integer;
class String;
class OStream: virtual public Object {
    public:
    virtual ~OStream() {}
    
    virtual OStream &operator <<(char c) = 0;
    virtual OStream &operator <<(int i);
    virtual OStream &operator <<(unsigned int i);
    virtual OStream &operator <<(void *ptr);
    virtual OStream &operator <<(char *c);
    virtual OStream &operator <<(const char *c);
    
    // resolve ambiguity between primitive and Object& casts 
    virtual OStream &operator <<(Char &c);
    virtual OStream &operator <<(Integer &i);
    virtual OStream &operator <<(String &s);
    
    OStream &printint(int d, int base = 10, int pad = 0);
    OStream &printuint(unsigned int d, int base = 10, int pad = 0);
    OStream &printhex(int d, int pad = 0);
    OStream &printuhex(unsigned int d, int pad = 0);
};

#endif //OSTREAM_HPP_LOCK

