#ifndef MEMORYISTREAM_HPP_LOCK
#define MEMORYISTREAM_HPP_LOCK

#include "sys/stream/IStream.hpp"

class MemoryIStream: public IStream {
    private:
    size_t pos;
    
    protected:
    MemoryInfo &mem;
    
    public:
    MemoryIStream(Environment &env, MemoryInfo &mi, MemoryInfo &mem):Object(env, mi),mem(mem),pos(0) {}
    virtual ~MemoryIStream() {}
    
    using IStream::operator >>;
    virtual IStream &operator >>(char &c) override {
        c = (pos < mem.len) ? ((char*)mem.buf)[pos++] : 0;
    }
    
    virtual bool isEmpty() override {
        return (pos == mem.len);
    }
    
    virtual void seek(size_t p) {
        if (p <= 0) {
            pos = 0;
        } else if (p >= mem.len) {
            pos = mem.len;
        } else {
            pos = p;
        }
    }
};

#endif //MEMORYISTREAM_HPP_LOCK

