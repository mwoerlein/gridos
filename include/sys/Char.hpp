#ifndef CHAR_HPP_LOCK
#define CHAR_HPP_LOCK

#include "sys/OStream.hpp"
#include "sys/Comparable.hpp"

class Char: public Comparable<Char> {
    protected:
    char _c;
    
    public:
    Char(Environment &env, MemoryInfo &mi = *notAnInfo, char c = '\0'): Object(env, mi), _c(c) {}
    Char(Environment &env, MemoryInfo &mi, Char &c): Object(env, mi), _c((char) c) {}
    virtual ~Char() {};
    
    operator char() { return _c; }
    virtual Char & operator =(char c) { env().getStdO()<<"Cc"; _c = c; return *this; }
    virtual Char & operator =(Char &c) { env().getStdO()<<"CC"; _c = (char) c; return *this; }
    
    virtual int compareTo(Char &c) override {
        return _c - (char) c;
    }
    
    virtual int hash() override {
        return _c;
    }
    
    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() override { return character; }
};

#endif //CHAR_HPP_LOCK

