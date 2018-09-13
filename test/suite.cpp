#include <iostream>
#include <stdlib.h>

#include "sys/Environment.hpp"
#include "sys/Char.hpp"
#include "memory/MemoryInfoHelper.hpp"
#include "test/TestSuite.hpp"

static char normal[] = { 0x1b, '[', '0', ';', '3', '9', 'm', 0 };
static char red[] = { 0x1b, '[', '1', ';', '3', '1', 'm', 0 };

class StdOStream: public OStream {
    private:
    std::ostream &out;
    const char *format;
    
    public:
    using OStream::operator <<;
    StdOStream(Environment &env, MemoryInfo &mi, std::ostream &out, const char *format)
        : Object(env, mi), out(out), format(format) {};
    virtual ~StdOStream() {}
    
    virtual OStream &operator <<(char c) override {
        out<<format<<c<<normal;
        return *this;
    }
};

void operator delete(void * ptr) { /* do not free memory on delete */}

class MallocAllocator: public MemoryAllocator {
    public:
    MallocAllocator(Environment &env, MemoryInfo &mi = *notAnInfo): Object(env, mi) {};
    virtual ~MallocAllocator() {}
    
    virtual MemoryInfo & allocate(size_t len, void * owner = 0) override {
        MemoryInfo *info = (MemoryInfo *) std::malloc(len + sizeof(MemoryInfo));
        info->buf = memoryEnd(info, sizeof(MemoryInfo));
        info->len = len;
        info->flags.magic = MEMORY_INFO_MAGIC;
        info->flags.reserved = 0;
        info->flags.used = 1;
        info->owner = owner;
        return *info;
    }
    
    virtual void free(MemoryInfo & memoryInfo) override {
        MemoryInfo * info = &memoryInfo;
        if (info != notAnInfo) {
            std::free(info);
        }
    }
    
    virtual MemoryInfo & memInfo(void * ptr) override {
        if (isMemoryInfo(ptr)) {
            return *((MemoryInfo *) ptr);
        }
        void * info = memoryEnd(ptr, -sizeof(MemoryInfo));
        if (isMemoryInfo(info)) {
            return *((MemoryInfo *) info);
        }
        return *notAnInfo;
    }
    
    virtual size_t getAvailableBytes() override { return 0; }
    virtual void dump(OStream &log, bool all = false) override {}
};

int main() {
    
    Environment env;
    StdOStream bsOut(env, *notAnInfo, std::cout, normal);
    env.setOut(bsOut);
    StdOStream bsErr(env, *notAnInfo, std::cerr, red);
    env.setErr(bsErr);
    MallocAllocator bsMa(env);
    env.setAllocator(bsMa);
    
    TestSuite &ts = env.create<TestSuite>();
    ts.runAll();
    env.destroy(ts);
}
