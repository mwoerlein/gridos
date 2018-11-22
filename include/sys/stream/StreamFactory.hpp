#ifndef SYS_STREAM_STREAMFACTORY_HPP_LOCK
#define SYS_STREAM_STREAMFACTORY_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/String.hpp"
#include "sys/stream/SeekableOStream.hpp"
#include "sys/stream/SeekableIStream.hpp"
#include "sys/stream/IgnoreOStream.hpp"
#include "sys/stream/EmptyIStream.hpp"

/*
 * Dummy implementation!
 * Will be replaced in linux-based systems (test, (cross-)compiler, ...) with file-based streams
 */
class StreamFactory: virtual public Object {
    public:
    StreamFactory(Environment &env, MemoryInfo &mi = *notAnInfo): Object(env, mi) {}
    virtual ~StreamFactory() {}
    
    virtual SeekableOStream & buildOStream(const char * name) { return env().create<IgnoreOStream>(); }
    virtual SeekableOStream & buildOStream(String &name) { return env().create<IgnoreOStream>(); }
    virtual IStream & buildStdIStream() { return env().create<EmptyIStream>(); }
    virtual SeekableIStream & buildIStream(const char * name) { return env().create<EmptyIStream>(); }
    virtual SeekableIStream & buildIStream(String &name) { return env().create<EmptyIStream>(); }
};

#endif //SYS_STREAM_STREAMFACTORY_HPP_LOCK
