#include "KernelJIT/Module.hpp"
#include "sys/String.hpp"

Module::Module(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo)
        :PropertyContainer(env, mi), Object(env, mi), memoryInfo(memoryInfo) {}

Module::~Module() {
    env().getAllocator().free(memoryInfo);
}

void Module::parseHeader() {
    // TODO: detect and extract infos from memory
}
void Module::parseCommandline(const char * commandline) {
    // TODO: detect and extract infos from commandline
    char * idStart = (char *) commandline;
    char * idEnd = (char *) commandline;
    while (*idEnd && (*idEnd != ' ')) {
        idEnd++;
    }
    if (!hasStringProperty("meta.id")) {
        setStringProperty("meta.id", createOwn<String, char*, char*>(idStart, idEnd));
    }
    //setStringProperty("meta.debug", "1");
    //setStringProperty("meta.test", "1");
}
