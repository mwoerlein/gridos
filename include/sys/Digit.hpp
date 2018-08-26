#ifndef DIGIT_HPP_LOCK
#define DIGIT_HPP_LOCK

#include "sys/Char.hpp"
#include "sys/Integer.hpp"

class Digit: public Char {
    private:
    
    inline char itod(int d) {
        return (d < 0 || d > 36) ? '?' : ((d < 10) ? ('0' + d) : ('a' - 10 + d));
    }
    inline char ctod(char c) {
        if ('0' <= c && c <= '9') { return c; }
        if ('a' <= c && c <= 'z') { return c; } 
        if ('A' <= c && c <= 'Z') { return c - 'A' + 'a'; } 
        return '?';
    }
    inline int ctoi(char c) {
        if ('0' <= c && c <= '9') { return c - '0'; }
        if ('a' <= c && c <= 'z') { return c - 'a' + 10; } 
        if ('A' <= c && c <= 'Z') { return c - 'A' + 10; } 
        return -1;
    }
    
    public:
    Digit(Environment &env, MemoryInfo &mi = *notAnInfo, int d = 0): Char(env, mi, itod(d)), Object(env, mi) {}
    Digit(Environment &env, MemoryInfo &mi, Integer &d): Char(env, mi, itod((int) d)), Object(env, mi) {}
    
    operator int() { return ctoi(_c); }
    virtual Digit & operator =(char c) override { Char::_c = ctod(c); return *this; }
    virtual Digit & operator =(Char &c) override { Char::_c = ctod((char) c); return *this; }
    virtual Digit & operator =(int d) { Char::_c = itod(d); return *this; }
    virtual Digit & operator =(Integer &d) { Char::_c = itod((int) d); return *this; }
};

#endif //DIGIT_HPP_LOCK

