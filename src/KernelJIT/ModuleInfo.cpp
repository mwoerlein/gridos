#include "KernelJIT/ModuleInfo.hpp"
#include "sys/String.hpp"

ModuleInfo::ModuleInfo(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo)
        :PropertyContainer(env, mi), Object(env, mi), memoryInfo(memoryInfo) {}

ModuleInfo::~ModuleInfo() {
    env().getAllocator().free(memoryInfo);
}
