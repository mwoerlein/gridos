#ifndef SYS_STREAM_SEEKABLEISTREAM_HPP_LOCK
#define SYS_STREAM_SEEKABLEISTREAM_HPP_LOCK

#include "sys/stream/IStream.hpp"
#include "sys/stream/Seekable.hpp"

class SeekableIStream: public IStream, public Seekable {
    public:
    virtual ~SeekableIStream();
};

#endif //SYS_STREAM_SEEKABLEISTREAM_HPP_LOCK
