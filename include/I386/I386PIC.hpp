#ifndef I386_I386PIC_HPP_LOCK
#define I386_I386PIC_HPP_LOCK

#include "sys/Object.hpp"
#include "I386/I386IntTypes.hpp"

class I386PIC: virtual public Object {
    private:
    int16_t mask;
    
    public:
    enum { timer = 0, keyboard = 1 };
    
    I386PIC(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~I386PIC();
    
    virtual void activate(int nr);
    virtual void deactivate(int nr);
    virtual void finalize(int nr);
};

#endif //I386_I386PIC_HPP_LOCK

