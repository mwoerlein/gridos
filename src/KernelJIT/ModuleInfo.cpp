#include "KernelJIT/ModuleInfo.hpp"
#include "sys/String.hpp"

ModuleInfo::ModuleInfo(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo, String & cmd, ModuleInfo * next)
    :Object(env, mi), memoryInfo(memoryInfo), cmd(cmd), next(next) {
}

ModuleInfo::~ModuleInfo() {
    cmd.destroy();
    env().getAllocator().free(&memoryInfo);
}
