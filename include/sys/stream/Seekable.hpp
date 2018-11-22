#ifndef SYS_STREAM_SEEKABLE_HPP_LOCK
#define SYS_STREAM_SEEKABLE_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/stream/IStream.hpp"

class Seekable: virtual public Object {
    public:
    virtual ~Seekable();
    
    virtual size_t length() = 0;
    virtual size_t pos() = 0;
    virtual void seek(size_t pos) = 0;
    
    virtual void rewind();
};

#endif //SYS_STREAM_SEEKABLE_HPP_LOCK
