#include "sys/Object.hpp"

Environment & Object::env() {
    return _environment;
}

int Object::hash() {
    return (int) _memory_info.buf;
}

bool Object::equals(Object &o) {
    return this->_memory_info.buf == o._memory_info.buf;
}
