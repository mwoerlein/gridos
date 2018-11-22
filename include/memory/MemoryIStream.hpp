#ifndef MEMORYISTREAM_HPP_LOCK
#define MEMORYISTREAM_HPP_LOCK

#include "sys/stream/SeekableIStream.hpp"

class MemoryIStream: public SeekableIStream {
    private:
    size_t _pos;
    
    protected:
    MemoryInfo &mem;
    
    public:
    MemoryIStream(Environment &env, MemoryInfo &mi, MemoryInfo &mem):Object(env, mi),mem(mem),_pos(0) {}
    virtual ~MemoryIStream() {}
    
    using IStream::operator >>;
    virtual IStream &operator >>(char &c) override {
        c = (_pos < mem.len) ? ((char*)mem.buf)[_pos++] : 0;
    }
    
    virtual bool isEmpty() override {
        return (_pos == mem.len);
    }
    
    virtual size_t length() override {
        return mem.len;
    }
    
    virtual size_t pos() override {
        return _pos;
    }
    
    virtual void seek(size_t p) override {
        if (p <= 0) {
            _pos = 0;
        } else if (p >= mem.len) {
            _pos = mem.len;
        } else {
            _pos = p;
        }
    }
};

#endif //MEMORYISTREAM_HPP_LOCK

