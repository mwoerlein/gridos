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
    
    virtual bool empty() override {
        return (pos == mem.len);
    }
    
//    virtual IStream &operator >>(int &i) = 0;
//    virtual IStream &operator >>(void *ptr) = 0;
};

#endif //MEMORYISTREAM_HPP_LOCK

