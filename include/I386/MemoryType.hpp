#ifndef MEMORYTYPE_HPP_LOCK
#define MEMORYTYPE_HPP_LOCK

typedef unsigned int size_t;

typedef struct memory {
    char* buf;
    size_t len;
} Memory;

typedef struct {
    size_t len;
    struct memory *mem;
} memlist;

#endif //MEMORYTYPE_HPP_LOCK
