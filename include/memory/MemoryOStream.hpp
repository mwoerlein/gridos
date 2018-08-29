#ifndef MEMORYOSTREAM_HPP_LOCK
#define MEMORYOSTREAM_HPP_LOCK

#include "sys/OStream.hpp"

class MemoryOStream: public OStream {
    private:
    size_t pos;
    
    protected:
    MemoryInfo &mem;
    
    public:
    MemoryOStream(Environment &env, MemoryInfo &mi, MemoryInfo &mem):Object(env, mi),mem(mem),pos(0) {}
    virtual ~MemoryOStream() {}
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override {
        ((char*)mem.buf)[pos++] = c;
        return *this;
    }
    
    virtual void clear() {
        pos = 0;
    }
};

#endif //MEMORYOSTREAM_HPP_LOCK

