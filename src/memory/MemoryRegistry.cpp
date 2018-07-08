#include "memory/MemoryRegistry.hpp"

void MemoryRegistry::registerAvailableMemory(void * mem, size_t len){
    if (len == 0) {
        return;
    }
    if (reserved.next || used.next) {
        log<<'I'<<'g'<<'n'<<'o'<<'r'<<'e'<<' '<<'a'<<'v'<<'a'<<'i'<<'l'<<'a'<<'b'<<'l'<<'e'<<' '<<(void *) mem<<':'<<(void*)len<<'\n';
        return;
    }
    MemoryListEntry *newEntry = &entries[entriesCounter++];
    newEntry->buf = mem;
    newEntry->len = len;
    if (!available.next) {
        available.prev = available.next = newEntry;
        return;
    }
    // TODO: sort/merge available entries
    newEntry->prev = available.prev->next;
    newEntry->next = &available;
    available.prev = available.prev->next = newEntry;
};

void MemoryRegistry::registerReservedMemory(void * mem, size_t len){
    if (len == 0) {
        return;
    }

    MemoryListEntry *newEntry = &entries[entriesCounter++];
    newEntry->buf = mem;
    newEntry->len = len;
    newEntry->flags.reserved = 1;
    if (!reserved.next) {
        reserved.prev = reserved.next = newEntry;
        return;
    }
    // TODO: remove from available entries, sort/merge reserved entries
    newEntry->prev = reserved.prev->next;
    newEntry->next = &reserved;
    reserved.prev = reserved.prev->next = newEntry;
};

void MemoryRegistry::registerUsedMemory(void * mem, size_t len, void * owner){
    if (len == 0) {
        return;
    }

    MemoryListEntry *newEntry = &entries[entriesCounter++];
    newEntry->buf = mem;
    newEntry->len = len;
    newEntry->flags.used = 1;
    newEntry->owner = owner;
    if (!used.next) {
        used.prev = used.next = newEntry;
        return;
    }
    // TODO: remove from available entries, sort used entries
    newEntry->prev = used.prev->next;
    newEntry->next = &used;
    used.prev = used.prev->next = newEntry;
};

bool MemoryRegistry::isAvailable(void * mem, size_t len){
    // TODO: search in available entries
    return false;
};

void MemoryRegistry::dump(){
    log<<'D'<<'u'<<'m'<<'p'<<' '<<'r'<<'e'<<'g'<<'i'<<'s'<<'t'<<'r'<<'y'<<' '<<(void *) this<<' '<<'('<<'n'<<'e'<<'x'<<'t'<<' '<<'#'<<entriesCounter<<')'<<'\n';
    
    MemoryListEntry *e;
    if (available.next) {
        for (e = available.next; e != &available; e = e->next) {
            log<<'A'<<'v'<<'a'<<'i'<<'l'<<'a'<<'b'<<'l'<<'e'<<' '<<(void *) e->buf<<':'<<(void *) e->len<<' '<<'('<<'#'<<(e-entries)<<')'<<'\n';
        }
    }
    if (reserved.next) {
        for (e = reserved.next; e != &reserved; e = e->next) {
            log<<'R'<<'e'<<'s'<<'e'<<'r'<<'v'<<'e'<<'d'<<' '<<(void *) e->buf<<':'<<(void *) e->len<<' '<<'('<<'#'<<(e-entries)<<')'<<'\n';
        }
    }
    if (used.next) {
        for (e = used.next; e != &used; e = e->next) {
            log<<'U'<<'s'<<'e'<<'d'<<' '<<(void *) e->buf<<':'<<(void *) e->len<<' '<<'('<<'#'<<(e-entries)<<')'<<' '<<'b'<<'y'<<' '<< e->owner <<'\n';
        }
    }
}
