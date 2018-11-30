#include "KernelJIT/ModuleHandler/X86Handler.hpp"

// public
X86Handler::X86Handler(Environment &env, MemoryInfo &mi):Object(env, mi) {}
X86Handler::~X86Handler() {}

bool X86Handler::handles(Module & module) {
    return module.testStringProperty("meta.mimetype", "application/x-bin-x86");
}

bool X86Handler::handle(Module & module, KernelRuntime & runtime) {
    if (!handles(module)) {
        return false;
    }
    
    size_t size = module.getContentSize();
    MemoryIOStream &mem = env().create<MemoryIOStream, size_t>(size);
    IStream &in = module.getContentIStream();
    if (logLevel >= 2) { env().out()<<"copying "<<size<< " bytes ..."; }
    mem<<in;
    if (logLevel >= 2) { env().out()<<" done\n"; }
    in.destroy();
    
    if (module.testStringProperty("pool.class", "true")) {
        ClassDescriptor *cd = runtime.registerClass((pool_class_descriptor*) mem.getStartAddress());
        if (cd && module.hasStringProperty("pool.bootstrapOffset")) {
            int bs = 0;
            module.getStringProperty("pool.bootstrapOffset") >> bs;
            runtime.setBootstrap(*cd, bs);
        }
    }
    if (module.testStringProperty("pool.entry", "true")) {
        runtime.setEntry(mem);
    }
    
    return true;
}
