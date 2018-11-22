#ifndef MEMORYOSTREAM_HPP_LOCK
#define MEMORYOSTREAM_HPP_LOCK

#include "sys/stream/SeekableOStream.hpp"

class MemoryOStream: public SeekableOStream {
    private:
    size_t _pos;
    
    protected:
    MemoryInfo &mem;
    
    public:
    MemoryOStream(Environment &env, MemoryInfo &mi, MemoryInfo &mem):Object(env, mi),mem(mem),_pos(0) {}
    virtual ~MemoryOStream() {}
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override {
        if (_pos < mem.len) {
            ((char*) mem.buf)[_pos++] = c;
        }
        return *this;
    }
    
    virtual void clear() {
        _pos = 0;
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

#endif //MEMORYOSTREAM_HPP_LOCK

