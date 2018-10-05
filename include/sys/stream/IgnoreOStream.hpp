#ifndef SYS_IGNOREOSTREAM_HPP_LOCK
#define SYS_IGNOREOSTREAM_HPP_LOCK

#include "sys/stream/OStream.hpp"

class IgnoreOStream: public OStream {
    public:
    IgnoreOStream(Environment &env, MemoryInfo &mi = *notAnInfo):Object(env, mi) {}
    virtual ~IgnoreOStream() {}
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override {
        return *this;
    }
};

#endif //SYS_IGNOREOSTREAM_HPP_LOCK
