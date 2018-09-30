#ifndef I386ASM_PARSEERRORSTREAM_HPP_LOCK
#define I386ASM_PARSEERRORSTREAM_HPP_LOCK

#include "sys/OStream.hpp"

class ParseErrorStream: public OStream {
    private:
    int errors;
    OStream &inner;
    
    public:
    ParseErrorStream(Environment &env, MemoryInfo &mi, OStream &inner):Object(env, mi),inner(inner),errors(0) {}
    virtual ~ParseErrorStream() {}
    
    using OStream::operator <<;
    virtual OStream &operator <<(char c) override {
        if (c == '\n') {
            errors++;
        }
        inner << c;
        return *this;
    }
    operator int() {
        return errors;
    }
};

#endif //I386ASM_PARSEERRORSTREAM_HPP_LOCK
