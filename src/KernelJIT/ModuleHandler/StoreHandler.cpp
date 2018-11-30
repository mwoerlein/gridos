#include "KernelJIT/ModuleHandler/StoreHandler.hpp"

// public
StoreHandler::StoreHandler(Environment &env, MemoryInfo &mi):Object(env, mi) {}
StoreHandler::~StoreHandler() {}

bool StoreHandler::handles(Module & module) {
    return module.testStringProperty("meta.mimetype", "application/grid-store");
}

bool StoreHandler::handle(Module & module, KernelRuntime & runtime) {
    if (!handles(module)) {
        return false;
    }
    
    IStream &in = module.getContentIStream();
    for (int pos = in.readRawInt(), size = in.readRawInt(); pos > 0; pos = in.readRawInt(), size = in.readRawInt()) {
        if (logLevel >= 2) {
            env().out()<<"-- element at "<<pos<<":"<<size<<"\n";
        }
        Module & inner = env().create<Module, void*, size_t>((void*) (pos + (size_t)module.memoryInfo.buf), size);
        inner.parseHeader();
        runtime.registerModule(inner);
        inner.destroy();
    }
    in.destroy();
    return true;
}
