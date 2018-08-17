#ifndef MEMORYTYPES_HPP_LOCK
#define MEMORYTYPES_HPP_LOCK

#define MEMORY_INFO_MAGIC 0xE3E0

#define memoryEnd(buf, len) ((void *) ((size_t) (buf) + (len)))
#define memoryDiff(mem1, mem2) ((size_t) (mem2) - (size_t) (mem1))
#define entryEnd(entry) ((void *) ((size_t) (entry)->buf + (entry)->len))
#define isMemoryInfo(ptr) (((MemoryInfo *) ptr)->flags.magic == MEMORY_INFO_MAGIC)
#define hasFollowingBuffer(ptr) (((MemoryInfo *) ptr)->buf == memoryEnd(ptr, sizeof(MemoryInfo)))

#define notAnInfo (*((MemoryInfo *)-1))
#define isNotAnInfo(ptr) ((void *) (ptr) == (void *) -1)
#define isEmptyList(list) ((list)->next == (list))

#define initEmptyList(list) {\
    MemoryListEntry * l = (list);\
    l->next = l->prev = l;\
    l->buf = (void *) 0;\
    l->len = 0;\
    l->owner = l;\
    l->flags.reserved = 0;\
    l->flags.used = 0;\
    l->flags.magic = MEMORY_INFO_MAGIC;\
}
    
#define unlinkEntry(entry) {\
    MemoryListEntry * e = (entry);\
    e->next->prev = e->prev;\
    e->prev->next = e->next;\
}

#define insertEntryAfter(entry, newEntry) {\
    MemoryListEntry * e1 = (entry);\
    MemoryListEntry * e2 = (newEntry);\
    e2->prev = e1;\
    e2->next = e1->next;\
    e2->prev->next = e2->next->prev = e2;\
}

typedef unsigned int size_t;

typedef struct {
    unsigned long used      : 1;
    unsigned long reserved  : 1;
    unsigned long align     : 14;
    unsigned long magic     : 16;
} MemoryFlags;

/*
typedef struct {
    void* buf;
    size_t len;
    MemoryFlags flags;
    void* owner;
} MemoryInfo;
*/

typedef struct MemoryListEntry {
    void* buf;
    size_t len;
    MemoryFlags flags;
    void* owner;
    struct MemoryListEntry* prev;
    struct MemoryListEntry* next;
} MemoryListEntry;

typedef MemoryListEntry MemoryInfo;

typedef struct MemoryInfoArray {
    int size;
    MemoryInfo elements[0];
} MemoryInfoArray;
#endif //MEMORYTYPES_HPP_LOCK
