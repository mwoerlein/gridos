#ifndef MEMORYTYPES_HPP_LOCK
#define MEMORYTYPES_HPP_LOCK

#define MEMORY_INFO_MAGIC 0xE3E0

#define memoryEnd(buf, len) ((void *) ((size_t) (buf) + (len)))
#define memoryDiff(mem1, mem2) ((size_t) (mem2) - (size_t) (mem1))
#define entryEnd(entry) ((void *) ((size_t) (entry)->buf + (entry)->len))

typedef unsigned int size_t;

typedef struct {
    unsigned long used      : 1;
    unsigned long reserved  : 1;
    unsigned long align     : 14;
    unsigned long magic     : 16;
} MemoryFlags;

typedef struct {
    void* buf;
    size_t len;
    MemoryFlags flags;
    void* owner;
} MemoryInfo;

typedef struct MemoryListEntry {
    void* buf;
    size_t len;
    MemoryFlags flags;
    void* owner;
    struct MemoryListEntry* prev;
    struct MemoryListEntry* next;
} MemoryListEntry;

#endif //MEMORYTYPES_HPP_LOCK
