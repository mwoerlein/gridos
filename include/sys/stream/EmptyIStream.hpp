#ifndef SYS_STREAM_EMPTYISTREAM_HPP_LOCK
#define SYS_STREAM_EMPTYISTREAM_HPP_LOCK

#include "sys/stream/SeekableIStream.hpp"

class EmptyIStream: public SeekableIStream {
    public:
    EmptyIStream(Environment &env, MemoryInfo &mi = *notAnInfo):Object(env, mi) {}
    virtual ~EmptyIStream() {}
    
    using IStream::operator >>;
    virtual IStream & operator >>(char &c) override { c = 0; return *this; }
    virtual bool isEmpty() override { return true; }
    virtual size_t length() override { return 0; }
    virtual size_t pos() override { return 0; }
    virtual void seek(size_t pos) override {}
};

#endif //SYS_STREAM_EMPTYISTREAM_HPP_LOCK

