#ifndef SYS_STREAM_SEEKABLEOSTREAM_HPP_LOCK
#define SYS_STREAM_SEEKABLEOSTREAM_HPP_LOCK

#include "sys/stream/OStream.hpp"
#include "sys/stream/Seekable.hpp"

class SeekableOStream: public OStream, public Seekable {
    public:
    virtual ~SeekableOStream();
};

#endif //SYS_STREAM_SEEKABLEOSTREAM_HPP_LOCK
