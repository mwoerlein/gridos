#include "KernelJIT/ModuleHandler/StartupHandler.hpp"

// public
StartupHandler::StartupHandler(Environment &env, MemoryInfo &mi):Object(env, mi) {}
StartupHandler::~StartupHandler() {}

bool StartupHandler::handles(Module & module) {
    return module.hasId() && (module.getId() == "startup");
}

bool StartupHandler::handle(Module & module, KernelRuntime & runtime) {
    if (!handles(module)) {
        return false;
    }
    if (module.hasStringProperty("meta.mainThread")) {
        runtime.setStringProperty("meta.mainThread", module.getStringProperty("meta.mainThread"));
    }
    return true;
}
