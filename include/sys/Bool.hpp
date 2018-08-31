#ifndef BOOL_HPP_LOCK
#define BOOL_HPP_LOCK

#include "sys/Object.hpp"

class Bool: public Object {
    private:
    bool _b;
    
    public:
    Bool(Environment &env, MemoryInfo &mi = *notAnInfo, bool b = false);
    Bool(Environment &env, MemoryInfo &mi, Bool &b);
    virtual ~Bool();
    
    operator bool();
    virtual Bool &operator =(Bool &b);
    virtual Bool &operator =(bool b);
    
    virtual int hash() override;
    virtual bool equals(Object &o) override;
    
    // TODO #6: implement RTTI correctly
    virtual RTTI rtti() override { return boolean; }
};

#endif //BOOL_HPP_LOCK

