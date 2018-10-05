#ifndef STRING_HPP_LOCK
#define STRING_HPP_LOCK

#include "sys/Comparable.hpp"
#include "sys/Char.hpp"
#include "sys/IStream.hpp"
#include "sys/OStream.hpp"

class String: public OStream, public ComparableC<char *>, public ComparableC<const char *>, public Comparable<String> {
    protected:
    class _Element;
    class _IStream;
    
    _Element *first;
    _Element *last;
    int _length;
    int _hash;
    
    virtual void clear();
    
    public:
    String(Environment &env, MemoryInfo &mi = *notAnInfo);
    String(Environment &env, MemoryInfo &mi, char *cstring);
    String(Environment &env, MemoryInfo &mi, const char *cstring);
    String(Environment &env, MemoryInfo &mi, char *start, char* end);
    String(Environment &env, MemoryInfo &mi, String &s);
    virtual ~String();
    
    virtual int length();
    
    useComparableCOperators(char*);
    useComparableCOperators(const char*);
    useComparableOperators(String);
        
    virtual int compareTo(char *cstring) override;
    virtual int compareTo(const char *cstring) override;
    virtual int compareTo(String &s) override;
    virtual OStream & operator >>(OStream & stream) override;
    virtual int hash() override;
    
    virtual IStream &toIStream();
    
    virtual String &operator =(char *cstring);
    virtual String &operator =(const char *cstring);
    virtual String &operator =(String &s);
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override;
    
    inline String &operator +=(char c) { *this << c; return *this; }
    inline String &operator +=(Char &c) { *this << c; return *this; }
    inline String &operator +=(char *cstring) { *this << cstring; return *this; }
    inline String &operator +=(const char *cstring) { *this << cstring; return *this; }
    inline String &operator +=(String &s) { *this << s; return *this; }

    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() override { return string; }
};

#endif //STRING_HPP_LOCK

