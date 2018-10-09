#ifndef SYS_STREAM_EMPTYISTREAM_HPP_LOCK
#define SYS_STREAM_EMPTYISTREAM_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/Char.hpp"
#include "sys/stream/OStream.hpp"

class EmptyIStream: public IStream {
    public:
    EmptyIStream(Environment &env, MemoryInfo &mi = *notAnInfo):Object(env, mi) {}
    virtual ~EmptyIStream() {}
    
    using IStream::operator >>;
    virtual IStream & operator >>(char &c) { c = 0; return *this; }
    virtual bool isEmpty() { return true; }
};

#endif //SYS_STREAM_EMPTYISTREAM_HPP_LOCK

