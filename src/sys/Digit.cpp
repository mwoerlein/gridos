#include "sys/Digit.hpp"

// public
Digit::Digit(Environment &env, MemoryInfo &mi, int d): Char(env, mi, itod(d)), Object(env, mi) {}
Digit::Digit(Environment &env, MemoryInfo &mi, Integer &d): Char(env, mi, itod((int) d)), Object(env, mi) {}
Digit::~Digit() {}

Digit::operator int() {
    return ctoi(_c);
}

Digit & Digit::operator =(char c) {
    Char::_c = ctod(c);
    return *this;
}

Digit & Digit::operator =(Char &c) {
    Char::_c = ctod((char) c);
    return *this;
}

Digit & Digit::operator =(int d) {
    Char::_c = itod(d);
    return *this;
}

Digit & Digit::operator =(Integer &d) {
    Char::_c = itod((int) d);
    return *this;
}
