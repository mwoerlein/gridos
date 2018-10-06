#include "KernelJIT/KernelEnvironment.hpp"

KernelEnvironment::KernelEnvironment(MemoryAllocator &ma, OStream &out, OStream &err)
        :Environment(*this, ma.memInfo(this), ma, out, err),
         HashMap(*this, ma.memInfo(this), 5),
         Object(*this, ma.memInfo(this)) {
 }
        
KernelEnvironment::~KernelEnvironment() {
    destroyModules();
}
    
void KernelEnvironment::addModule(const char* commandline, MemoryInfo &moduleInfo, const char* id) {
    Module & module = create<Module, MemoryInfo &>(moduleInfo);
    if (id) {
        module.setId(module.createOwn<String, const char*>(id));
    }
    if (!module.parseHeader()) {
        env().err() << "ignore module at " << moduleInfo.buf << " because of invalid header\n";
        module.destroy();
        return;
    }
    if (!module.parseCommandline(commandline)) {
        env().err() << "ignore module at " << moduleInfo.buf << " because of invalid commandline\n";
        module.destroy();
        return;
    }
    if (!module.hasId()) {
        env().err() << "ignore module at " << moduleInfo.buf << " because of missing module id\n";
        module.destroy();
        return;
    }
    set(module.getId(), module);
}

bool KernelEnvironment::hasModule(const char* moduleId) {
    String &tmp = env().create<String, const char*>(moduleId);
    bool ret = hasModule(tmp);
    tmp.destroy();
    return ret;
}

Module &KernelEnvironment::getModule(const char* moduleId) {
    String &tmp = env().create<String, const char*>(moduleId);
    Module & ret = getModule(tmp);
    tmp.destroy();
    return ret;
}

void KernelEnvironment::destroyModules() {
    Iterator<Module> &modules = values();
    while (modules.hasNext()) {
        modules.next().destroy();
    }
    modules.destroy();
    clear();
}
