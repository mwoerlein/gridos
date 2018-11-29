#ifndef MEMORY_MEMORYIOSTREAM_HPP_LOCK
#define MEMORY_MEMORYIOSTREAM_HPP_LOCK

#include "sys/stream/SeekableIOStream.hpp"

class MemoryIOStream: public SeekableIOStream {
    private:
    size_t _pos;
    
    protected:
    MemoryInfo &mem;
    
    public:
    MemoryIOStream(Environment &env, MemoryInfo &mi, MemoryInfo &mem):Object(env, mi),mem(mem),_pos(0) {}
    virtual ~MemoryIOStream() {}
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override {
        if (_pos < mem.len) {
            ((char*) mem.buf)[_pos++] = c;
        }
        return *this;
    }
    
    using IStream::operator >>;
    virtual IStream &operator >>(char &c) override {
        c = (_pos < mem.len) ? ((char*)mem.buf)[_pos++] : 0;
        return *this;
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

#endif //MEMORY_MEMORYIOSTREAM_HPP_LOCK

