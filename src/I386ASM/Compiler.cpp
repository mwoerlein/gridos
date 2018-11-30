#include "I386ASM/Compiler.hpp"

#include "memory/MemoryIOStream.hpp"
#include "I386ASM/Parser.hpp"
#include "I386ASM/ASMInstructionList.hpp"

// public
Compiler::Compiler(Environment &env, MemoryInfo &mi): Object(env, mi) {
    setLogLevel(1);
}
Compiler::~Compiler() {}

bool Compiler::handles(Module & module) {
    return module.testStringProperty("meta.mimetype", "text/x-pasm");
}

bool Compiler::handle(Module & module, KernelRuntime & runtime) {
    if (!handles(module)) {
        return false;
    }
    Parser &parser = env().create<Parser>();
    IStream &in = module.getContentIStream();
    ASMInstructionList &list = parser.parse(in, env().err());
    in.destroy();
    parser.destroy();

    if (list.hasErrors()) {
        if (logLevel >= 2) { env().err()<<"parsing error\n"; }
        list.destroy();
        return false;
    }
    
    size_t size = list.compile();
    if (list.hasErrors()) {
        if (logLevel >= 2) { env().err()<<"compile error\n"; }
        list.destroy();
        return false;
    }
    
    MemoryIOStream &mem = env().create<MemoryIOStream, size_t>(size);
    list.finalize(mem.getStartAddress());
    if (list.hasErrors()) {
        if (logLevel >= 2) { env().err()<<"finalize error\n"; }
        mem.destroy();
        list.destroy();
        return false;
    }
    
    if (logLevel >= 2) { list.logToStream(env().out(), logLevel >= 3); }
    list.writeToStream(mem);
    if (module.testStringProperty("pool.class", "true")) {
        ClassDescriptor *cd = runtime.registerClass((pool_class_descriptor*) mem.getStartAddress());
        if (cd && module.hasStringProperty("pool.bootstrapOffset") && list.hasDefinition(module.getStringProperty("pool.bootstrapOffset"))) {
            runtime.setBootstrap(*cd, list.getValue(module.getStringProperty("pool.bootstrapOffset")));
        }
    }
    if (module.testStringProperty("pool.entry", "true")) {
        runtime.setEntry(mem);
    }
    list.destroy();
    return true;
}

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
