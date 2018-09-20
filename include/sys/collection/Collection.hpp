#ifndef COLLECTION_COLLECTION_HPP_LOCK
#define COLLECTION_COLLECTION_HPP_LOCK

#include "sys/collection/Iterable.hpp"

template <class Obj> class Collection: virtual public Iterable<Obj> {
    public:
    virtual void clear() = 0;
    virtual int size() = 0;
    virtual bool isEmpty() { return size() == 0; }
    virtual bool add(Obj & o) = 0;
    virtual bool contains(Obj & o) = 0;
    virtual bool remove(Obj & o) = 0;
};

#endif //COLLECTION_COLLECTION_HPP_LOCK
