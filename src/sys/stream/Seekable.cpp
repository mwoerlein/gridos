#include "sys/stream/Seekable.hpp"

// public
Seekable::~Seekable() {};

void Seekable::rewind() {
    seek(0);
}
