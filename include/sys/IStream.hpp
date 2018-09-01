#ifndef ISTREAM_HPP_LOCK
#define ISTREAM_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/Char.hpp"

class IStream: virtual public Object {
    public:
    virtual ~IStream() {}
    
    virtual bool isEmpty() = 0;
    
    virtual IStream &operator >>(char &c) = 0;
    virtual IStream &operator >>(Char &c);
};

#endif //ISTREAM_HPP_LOCK

