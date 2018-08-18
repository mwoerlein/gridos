#ifndef MEMORYISTREAM_HPP_LOCK
#define MEMORYISTREAM_HPP_LOCK

#include "memory/MemoryTypes.hpp"
#include "sys/IStream.hpp"

class MemoryIStream: public IStream, public Object {
    private:
    MemoryInfo &mem;
    size_t pos;
    public:
    MemoryIStream(Environment &env, MemoryInfo &m):Object(env),mem(m),pos(0) {}
    virtual ~MemoryIStream() {}
    
    virtual IStream &operator>>(char &c) {
        c = ((char*)mem.buf)[pos++];
    }
    
    virtual bool empty() {
        return (pos == mem.len);
    }
    
//    virtual IStream &operator>>(int &i) = 0;
//    virtual IStream &operator>>(void *ptr) = 0;
};

#endif //MEMORYISTREAM_HPP_LOCK

