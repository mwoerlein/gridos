#include "sys/IStream.hpp"
#include "sys/Char.hpp"

// public

IStream & IStream::operator >>(Char &c) {
    char tmp;
    *this>>tmp;
    c = tmp;
    return *this;
}
