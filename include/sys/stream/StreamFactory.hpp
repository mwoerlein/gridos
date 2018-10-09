#ifndef SYS_STREAM_STREAMFACTORY_HPP_LOCK
#define SYS_STREAM_STREAMFACTORY_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/String.hpp"
#include "sys/stream/OStream.hpp"
#include "sys/stream/IStream.hpp"
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
    
    virtual OStream & buildOStream(const char * name) { return env().create<IgnoreOStream>(); }
    virtual OStream & buildOStream(String &name) { return env().create<IgnoreOStream>(); }
    virtual IStream & buildIStream(const char * name) { return env().create<EmptyIStream>(); }
    virtual IStream & buildIStream(String &name) { return env().create<EmptyIStream>(); }
};

#endif //SYS_STREAM_STREAMFACTORY_HPP_LOCK
