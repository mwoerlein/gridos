#include "KernelJIT/KernelEnvironment.hpp"

#include "sys/collection/HashMap.hpp"

KernelEnvironment::KernelEnvironment(MemoryAllocator &ma, OStream &out, OStream &err)
        :Environment(*this, ma.memInfo(this), ma, out, err), Object(*this, ma.memInfo(this)), _modules(0) {}
        
KernelEnvironment::~KernelEnvironment() {
    destroyModules();
    _modules->destroy();
}
    
void KernelEnvironment::addModule(const char* commandline, MemoryInfo &moduleInfo) {
    if (!_modules) {
        _modules = &create<HashMap<String, ModuleInfo>>();
    }
    // TODO: parse command_line and moduleInfo and use correct id
    _modules->set(create<String, const char*>(commandline), create<ModuleInfo, MemoryInfo &>(moduleInfo));
}

bool KernelEnvironment::hasModule(const char* moduleId) {
    String &tmp = env().create<String, const char*>(moduleId);
    bool ret = hasModule(tmp);
    tmp.destroy();
    return ret;
}

ModuleInfo &KernelEnvironment::getModule(const char* moduleId) {
    String &tmp = env().create<String, const char*>(moduleId);
    ModuleInfo & ret = getModule(tmp);
    tmp.destroy();
    return ret;
}

void KernelEnvironment::destroyModules() {
    if (!_modules) return;
    
    Iterator<String> &mit = _modules->keys();
    while (mit.hasNext()) {
        String & mid = mit.next();
        _modules->unset(mid).destroy();
        mid.destroy();
    }
    mit.destroy();
    _modules->destroy();
}
