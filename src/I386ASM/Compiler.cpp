#include "I386ASM/Compiler.hpp"

#include "memory/MemoryIOStream.hpp"
#include "I386ASM/Parser.hpp"
#include "I386ASM/ASMInstructionList.hpp"

// public
Compiler::Compiler(Environment &env, MemoryInfo &mi, int logLevel): Object(env, mi), logLevel(logLevel) {}
Compiler::~Compiler() {}

//bool Compiler::compile(IStream &input, OStream &out, size_t startAddress = 0);
MemoryInfo * Compiler::compileRaw(IStream &input, size_t startAddress) {
    Parser &parser = env().create<Parser>();
    ASMInstructionList &list = parser.parse(input, env().err(), 1, 1, true); // silent
    parser.destroy();
    
    if (list.hasErrors()) {
        if (logLevel >= 1) { env().err()<<"parsing error\n"; }
        list.destroy();
        return notAnInfo;
    }
    
    size_t size = list.compile();
    if (list.hasErrors()) {
        if (logLevel >= 1) { env().err()<<"compile error\n"; }
        list.destroy();
        return notAnInfo;
    }
    
    MemoryInfo *memInfo = &env().getAllocator().allocate(size);
    
    list.finalize(startAddress == -1 ? (size_t) memInfo->buf : startAddress);
    if (list.hasErrors()) {
        if (logLevel >= 1) { env().err()<<"finalize error\n"; }
        env().getAllocator().free(*memInfo);
        list.destroy();
        return notAnInfo;
    }
    
    if (logLevel >= 2) { list.logToStream(env().out(), logLevel >= 3); }
    
    MemoryIOStream &mem = env().create<MemoryIOStream, MemoryInfo&>(*memInfo);
    list.writeToStream(mem);
    mem.destroy();
    list.destroy();
    
    return memInfo;
}
