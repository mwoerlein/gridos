#ifndef INTEGER_HPP_LOCK
#define INTEGER_HPP_LOCK

#include "sys/Comparable.hpp"

class Integer: public Comparable<Integer> {
    private:
    int _i;
    
    public:
    Integer(Environment &env, MemoryInfo &mi = *notAnInfo, int i = 0): Object(env, mi), _i(i) {}
    Integer(Environment &env, MemoryInfo &mi, Integer &i): Object(env, mi), _i((int) i) {}
    virtual ~Integer() {}
    
    operator int() { return _i; }
    virtual Integer & operator =(int i) { _i = i; }
    virtual Integer & operator =(Integer &i) { _i = (int) i; }

    virtual Integer & operator ++() { ++_i; }
    virtual Integer & operator --() { --_i; }
    
    virtual Integer & operator +=(int i) { _i += i; return *this; }
    virtual Integer & operator -=(int i) { _i -= i; return *this; }
    virtual Integer & operator *=(int i) { _i *= i; return *this; }
    virtual Integer & operator /=(int i) { _i /= i; return *this; }
    virtual Integer & operator %=(int i) { _i %= i; return *this; }
    
    virtual Integer & operator +=(Integer &i) { _i += (int) i; return *this; }
    virtual Integer & operator -=(Integer &i) { _i -= (int) i; return *this; }
    virtual Integer & operator *=(Integer &i) { _i *= (int) i; return *this; }
    virtual Integer & operator /=(Integer &i) { _i /= (int) i; return *this; }
    virtual Integer & operator %=(Integer &i) { _i %= (int) i; return *this; }
    
    virtual int compareTo(Integer &i) override {
        return _i - (int) i;
    }
        
    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() override { return integer; }
};

#endif //INTEGER_HPP_LOCK

