#include "KernelJIT/KernelRuntime.hpp"

KernelRuntime::KernelRuntime(Environment &env, MemoryInfo &mi)
        :PropertyContainer(env, mi), Object(env, mi),
         handlers(env.create<LinkedList<ModuleHandler>>()),
         classes(env.create<HashMap<String, ClassDescriptor>>()),
         mainThread(0), bsClass(0), entry(0) {}
KernelRuntime::~KernelRuntime() {}

void KernelRuntime::addHandler(ModuleHandler &handler) {
    handlers.add(handler);
}

bool KernelRuntime::registerModule(Module &module) {
    bool ret = false;
    Iterator<ModuleHandler> &it = handlers.iterator();
    while (it.hasNext()) {
        ModuleHandler & handler = it.next();
        if (handler.handles(module)) {
            ret = handler.handle(module, *this);
            break;
        }
    }
    it.destroy();
    return ret;
}    

ClassDescriptor *KernelRuntime::registerClass(MemoryIOStream & mem, size_t bootstrapOffset) {
    ClassDescriptor &cd = env().create<ClassDescriptor, MemoryIOStream &, size_t>(mem, bootstrapOffset);
    if (!cd.isValid()) {
        env().err() << "try to register invalid class at " << mem.getStartAddress() << '\n';
        cd.destroy();
        return 0;
    }
//    env().out() << "register " << cd.getName() << " at " << mem.getStartAddress() << '\n';
    if (classes.has(cd.getName())) {
        env().err() << "class " << cd.getName() << " already registered\n";
        cd.destroy();
        return 0;
    }
    classes.set(cd.getName(), cd);
    if (cd.hasBootstrap() && !bsClass) {
//        env().out() << "set bootstrap " << cd.getName() << "\n";
        bsClass = &cd;
    }
    return &cd;
}

bool KernelRuntime::resolveClasses() {
    Iterator<ClassDescriptor> &cds = classes.values();
    while (cds.hasNext()) {
        ClassDescriptor & cd = cds.next();
        if (!cd.resolve(*this)) {
            env().err() << "Resolving class " << cd.getName() << " failed!\n";
            return false;
        }
    }
    cds.destroy();
    
    if (hasStringProperty("meta.mainThread")) {
        String &name = getStringProperty("meta.mainThread");
        mainThread = findClass(name);
        if (!mainThread) {
            env().err() << "Missing main thread class '" << name << "'!\n";
            return false;
        }
    }
    
    return true;
}

bool KernelRuntime::hasClass(String &name) {
    return classes.has(name);
}

ClassDescriptor * KernelRuntime::findClass(String &name) {
    if (!classes.has(name)) {
//        env().err() << "unknown class " << name << "\n";
        return 0;
    }
    return &classes.get(name);
}

bool KernelRuntime::setEntry(MemoryIOStream & mem) {
//    env().out() << "set entry " << &mem << "\n";
    if (entry) {
        return false;
    }
    entry = &mem;
    return true;
}

bool KernelRuntime::isValid() {
    return entry && ((bool) mainThread == (bool) bsClass);
}
