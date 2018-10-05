#ifndef OSTREAMFACTORY_HPP_LOCK
#define OSTREAMFACTORY_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/stream/OStream.hpp"
#include "sys/stream/IgnoreOStream.hpp"

/*
 * Dummy implementation!
 * Will be replaced in linux-based systems (test, (cross-)compiler, ...) with file-based streams
 */
class OStreamFactory: virtual public Object {
    public:
    OStreamFactory(Environment &env, MemoryInfo &mi = *notAnInfo): Object(env, mi) {}
    virtual ~OStreamFactory() {}
    virtual OStream & buildOStream(const char * name) {
        return env().create<IgnoreOStream>();
    }
};

#endif //OSTREAMFACTORY_HPP_LOCK
