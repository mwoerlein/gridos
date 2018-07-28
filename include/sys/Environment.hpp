#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

#include "memory/MemoryAllocator.hpp"

void* operator new (size_t size, void* location);

class Environment{
    private:
    MemoryAllocator &ma;
    
    public:
	Environment(MemoryAllocator &ma):ma(ma){}
	virtual ~Environment(){}
	
    template <class C> C & create() {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C);
    }
    
    template <class C, typename... Args> C & create(Args... args) {
        MemoryInfo &mi = ma.allocate(sizeof(C), this);
        return *(new (mi.buf) C(args...));
    }
    
    template <class C> void destroy(C &c) {
        ma.free(&c);
    }
};

#endif //ENVIRONMENT_HPP_LOCK

