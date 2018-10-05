#include "sys/IStream.hpp"

// public
IStream & IStream::operator >>(Char &c) {
    char tmp;
    *this >> tmp;
    c = tmp;
    return *this;
}

OStream & IStream::operator >>(OStream & stream) {
    char tmp;
    while (!isEmpty()) {
        *this >> tmp;
        stream << tmp;
    }
    return stream;
}
