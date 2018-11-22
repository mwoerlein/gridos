#ifndef SYS_STREAM_IGNOREOSTREAM_HPP_LOCK
#define SYS_STREAM_IGNOREOSTREAM_HPP_LOCK

#include "sys/stream/SeekableOStream.hpp"

class IgnoreOStream: public SeekableOStream {
    public:
    IgnoreOStream(Environment &env, MemoryInfo &mi = *notAnInfo):Object(env, mi) {}
    virtual ~IgnoreOStream() {}
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override { return *this; }
    virtual size_t length() override { return 0; }
    virtual size_t pos() override { return 0; }
    virtual void seek(size_t pos) override {}
};

#endif //SYS_STREAM_IGNOREOSTREAM_HPP_LOCK
