#ifndef I386_I386KEYBOARD_HPP_LOCK
#define I386_I386KEYBOARD_HPP_LOCK

#include "sys/InterruptHandler.hpp"
#include "sys/InterruptVectorTable.hpp"
#include "I386/I386PIC.hpp"

class I386Keyboard: public InterruptHandler {
    private:
    I386PIC &pic;
    
    public:
    I386Keyboard(Environment &env, MemoryInfo &mi, I386PIC &pic);
    virtual ~I386Keyboard();
    
    virtual void plugin(InterruptVectorTable &ivt);
    virtual void reboot();
    
    virtual void call(int nr) override;
};

#endif //I386_I386KEYBOARD_HPP_LOCK
