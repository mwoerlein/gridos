#ifndef CHAR_HPP_LOCK
#define CHAR_HPP_LOCK

#include "sys/OStream.hpp"
#include "sys/Comparable.hpp"

class Char: public Comparable<Char> {
    protected:
    char _c;
    
    public:
    Char(Environment &env, MemoryInfo &mi = *notAnInfo, char c = '\0');
    Char(Environment &env, MemoryInfo &mi, Char &c);
    virtual ~Char();
    
    operator char();
    virtual Char & operator =(char c);
    virtual Char & operator =(Char &c);
    
    virtual int compareTo(Char &c) override;
    virtual int hash() override;
    
    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() override { return character; }
};

#endif //CHAR_HPP_LOCK

