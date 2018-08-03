#ifndef I386IO_PORT_HPP_LOCK
#define I386IO_PORT_HPP_LOCK

class I386IO_Port{
    private:
    const int port;
    
    public:
    inline I386IO_Port(const int port):port(port) {}
    
    inline void outb(int val) const {
        __asm__ __volatile__("outb    %b0, %w1" : : "a"(val), "d"(port));
    }
    
    inline int inb() const { 
        int val;
        __asm__ __volatile__("inb    %w1, %b0" : "=a"(val) : "d"(port));
        return val&0xff;
    }
};

#endif //I386IO_PORT_HPP_LOCK
