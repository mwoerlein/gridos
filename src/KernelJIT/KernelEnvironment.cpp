#include "KernelJIT/KernelEnvironment.hpp"

KernelEnvironment::KernelEnvironment(MemoryAllocator &ma, OStream &out, OStream &err)
        :Environment(*this, ma.memInfo(this), ma, out, err),
         HashMap(*this, ma.memInfo(this), 5),
         Object(*this, ma.memInfo(this)) {
 }
        
KernelEnvironment::~KernelEnvironment() {
    destroyModules();
}
    
void KernelEnvironment::addModule(const char* commandline, MemoryInfo &moduleInfo) {
    // TODO: parse command_line and moduleInfo and use correct id
    set(create<String, const char*>(commandline), create<ModuleInfo, MemoryInfo &>(moduleInfo));
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
    Iterator<String> &mit = keys();
    while (mit.hasNext()) {
        String & mid = mit.next();
        unset(mid).destroy();
        mid.destroy();
    }
    mit.destroy();
}
