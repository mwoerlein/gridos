#ifndef I386ASM_COMPILER_HPP_LOCK
#define I386ASM_COMPILER_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/stream/IStream.hpp"

class Compiler: virtual public Object {
    protected:
    int logLevel;
    
    public:
    Compiler(Environment &env, MemoryInfo &mi, int logLevel = 1);
    virtual ~Compiler();
    
    virtual MemoryInfo * compileRaw(IStream &input, size_t startAddress = -1);
};

#endif //I386ASM_COMPILER_HPP_LOCK
