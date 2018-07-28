#include "sys/Environment.hpp"

void* operator new (size_t size, void* location) {
    return location;
}
