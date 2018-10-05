#ifndef ISTREAM_HPP_LOCK
#define ISTREAM_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/Char.hpp"
#include "sys/stream/OStream.hpp"

class IStream: virtual public Object {
    public:
    virtual ~IStream() {}
    
    virtual bool isEmpty() = 0;
    
    virtual IStream & operator >>(char &c) = 0;
    virtual IStream & operator >>(Char &c);
    virtual OStream & operator >>(OStream & stream) override;
};

#endif //ISTREAM_HPP_LOCK

