#include "linux/LinuxBootstrap.hpp"

#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#include "sys/Environment.hpp"
#include "sys/Char.hpp"
#include "sys/stream/StreamFactory.hpp"
#include "memory/MemoryInfoHelper.hpp"

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

class StdIStream: public IStream {
    private:
    std::istream &in;
    
    public:
    using IStream::operator >>;
    StdIStream(Environment &env, MemoryInfo &mi)
        : Object(env, mi), in(std::cin) {};
    virtual ~StdIStream() {}
    
    virtual IStream &operator >>(char &c) override {
        in.get(c);
        return *this;
    }
    virtual bool isEmpty() { return in.eof(); }
};

class StdFileOStream: public OStream {
    private:
    std::FILE *file;
    
    public:
    StdFileOStream(Environment &env, MemoryInfo &mi, const char *name)
        : Object(env, mi), file(std::fopen(name, "w")) {}
    virtual ~StdFileOStream() { std::fclose(file); }
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override {
        std::fputc(c, file);
        return *this;
    }
};

class StdFileIStream: public IStream {
    private:
    std::FILE *file;
    
    public:
    StdFileIStream(Environment &env, MemoryInfo &mi, const char *name)
        : Object(env, mi), file(std::fopen(name, "r")) {}
    virtual ~StdFileIStream() { std::fclose(file); }
    
    using IStream::operator >>;
    virtual IStream & operator >>(char &c) {
        c = std::fgetc(file);
        return *this;
    }
    virtual bool isEmpty() {
        int last = std::fgetc(file);
        bool ret = last == EOF;
        std::ungetc(last, file);
        return ret;
    }
};

class StdFileStreamFactory: public StreamFactory {
    public:
    StdFileStreamFactory(Environment &env, MemoryInfo &mi = *notAnInfo): StreamFactory(env, mi), Object(env, mi) {}
    virtual ~StdFileStreamFactory() {}
    
    virtual OStream & buildOStream(const char * name) override {
        return env().create<StdFileOStream, const char *>(name);
    }
    virtual OStream & buildOStream(String & name) override {
        char buffer[FILENAME_MAX];
        name >> buffer;
        return env().create<StdFileOStream, const char *>(buffer);
    }
    virtual IStream & buildIStream(const char * name) override {
        return env().create<StdFileIStream, const char *>(name);
    }
    virtual IStream & buildIStream(String & name) override {
        if (name == "-") {
            return env().create<StdIStream>();
        }
        char buffer[FILENAME_MAX];
        name >> buffer;
        return env().create<StdFileIStream, const char *>(buffer);
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

Environment & LinuxBootstrap::buildEnvironment() {
    MallocAllocator bsMa(*(Environment*)0);
    
    MemoryInfo &envInfo = bsMa.allocate(sizeof(Environment), 0);
    Environment &env = *(new (envInfo.buf) Environment());
    env.setAllocator(bsMa);
    
    env.setAllocator(env.create<MallocAllocator>());
    env.setOut(env.create<StdOStream, std::ostream &, const char *>(std::cout, normal));
    env.setErr(env.create<StdOStream, std::ostream &, const char *>(std::cerr, red));
    env.setStreamFactory(env.create<StdFileStreamFactory>());
    return env;
}
