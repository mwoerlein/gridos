#ifndef ISTREAM_HPP_LOCK
#define ISTREAM_HPP_LOCK

#include "sys/Object.hpp"

class IStream: virtual public Object {
    public:
    virtual ~IStream() {}
    virtual IStream &operator>>(char &c) = 0;
    virtual bool empty() = 0;
//    virtual IStream &operator>>(int &i) = 0;
//    virtual IStream &operator>>(void *ptr) = 0;
};

#endif //ISTREAM_HPP_LOCK

