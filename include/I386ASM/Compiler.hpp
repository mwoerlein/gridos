#ifndef I386ASM_COMPILER_HPP_LOCK
#define I386ASM_COMPILER_HPP_LOCK

#include "KernelJIT/ModuleHandler.hpp"
#include "sys/stream/IStream.hpp"

class Compiler: public ModuleHandler {
    public:
    Compiler(Environment &env, MemoryInfo &mi);
    virtual ~Compiler();
    
    virtual bool handles(Module & module) override;
    virtual bool handle(Module & module, KernelRuntime & runtime) override;
    virtual MemoryInfo * compileRaw(IStream &input, size_t startAddress = -1);
};

#endif //I386ASM_COMPILER_HPP_LOCK
