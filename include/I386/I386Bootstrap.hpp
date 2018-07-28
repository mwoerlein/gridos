#ifndef I386BOOTSTRAP_HPP_LOCK
#define I386BOOTSTRAP_HPP_LOCK

#include "I386/I386DebugSystem.hpp"
#include "memory/MemoryRegistry.hpp"
#include "memory/MemoryTypes.hpp"
#include "multiboot2/BootInformation.hpp"
#include "sys/Environment.hpp"
#include "sys/OStream.hpp"

class I386Bootstrap{
    private:
    bool valid;
    I386DebugSystem ds;
	BootInformation bootInformation;
	MemoryRegistry memoryRegistry; // TODO: replace with Environment* or MemoryManager*
    public:
	I386Bootstrap(unsigned long magic, void *mbi, void *mbh);
	virtual ~I386Bootstrap();
	virtual bool isValid();
	virtual DebugSystem & getDebugSystem();
	virtual Environment & buildEnvironment();
	virtual MemoryInfo & getKernelTextInfo();
	virtual MemoryInfo & getKernelOutInfo();
};

#endif //I386BOOTSTRAP_HPP_LOCK

