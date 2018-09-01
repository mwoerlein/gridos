#ifndef MEMORYISTREAM_HPP_LOCK
#define MEMORYISTREAM_HPP_LOCK

#include "sys/IStream.hpp"

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
        c = ((char*)mem.buf)[pos++];
    }
    
    virtual bool isEmpty() override {
        return (pos == mem.len);
    }
};

#endif //MEMORYISTREAM_HPP_LOCK

