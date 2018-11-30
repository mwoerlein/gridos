// C++14 additional delete operators
#if __cplusplus >= 201402L
__attribute__((weak)) void operator delete(void * ptr, unsigned int) { ::operator delete(ptr); }
__attribute__((weak)) void operator delete[](void * ptr, unsigned int) { ::operator delete(ptr); }
#endif

#include "I386/I386Bootstrap.hpp"
#include "I386/I386KernelRuntime.hpp"
#include "I386ASM/Compiler.hpp"
#include "KernelJIT/ModuleHandler/StartupHandler.hpp"
#include "KernelJIT/ModuleHandler/StoreHandler.hpp"
#include "KernelJIT/ModuleHandler/X86Handler.hpp"
//#include "test/TestSuite.hpp"

#define assertHALT(cond, message) { if (!(cond)) { env.err()<<(message)<<"\nHalting ..."; return; } }

extern "C" {

void startup(unsigned long magic, void *mbi, void *mbh){
    // create environment
    KernelEnvironment &env = I386Bootstrap::buildEnvironment(magic, mbi, mbh);
    if (!&env) {
        return;
    }
    assertHALT(env.hasModule("startup"), "No startup loaded!");
    
    if (env.testSetting("startup", "meta.test", "1")) {
//        TestSuite ts(env); // startup code will be too large with included tests :-(
//        ts.runAll();
    }
    
    // TODO: improve debug handling 
    int debugLevel = 0;
    if (env.testSetting("startup", "meta.debug", "1")) {
        debugLevel = 1;
    }
    if (env.testSetting("startup", "meta.debug", "2")) {
        debugLevel = 2;
    }
    if (env.testSetting("startup", "meta.debug", "3")) {
        debugLevel = 3;
    }
    
    if (debugLevel >= 2) {
        Iterator<Module> &modules = env.modules();
        while (modules.hasNext()) {
            modules.next().dump(env.out(), debugLevel >= 3);
        }
        modules.destroy();
    }
    
    I386KernelRuntime &runtime = env.create<I386KernelRuntime>();
    runtime.addHandler(env.create<StartupHandler>());
    runtime.addHandler(env.create<StoreHandler>());
    runtime.addHandler(env.create<X86Handler>());
    runtime.addHandler(env.create<Compiler>());
    
    // compile kernel from modules
    {
        Iterator<Module> &modules = env.modules();
        while (modules.hasNext()) {
            Module &module = modules.next();
            if (debugLevel >= 2) { module.dump(env.out(), debugLevel >= 3); }
            runtime.registerModule(module);
        }
        modules.destroy();
        env.destroyModules();
    }
    
    assertHALT(runtime.resolveClasses(), "Class resolving failed!");
    assertHALT(runtime.isValid(), "Preparing kernel failed!");
    
    if (debugLevel >= 2) {
        env.out()<<env<<' '<<env.getAllocator()<<' '<<env.out()<<' '<<env.err()<<' '<<runtime<<'\n';
        env.getAllocator().dump(env.err(), debugLevel >= 3);
    }
    
    // run compiled kernel
    if (debugLevel >= 1) {
        env.out()<<"Starting ... "<<(void*) runtime.getStartAddress()<<'\n';
    }
    runtime.run();
}

}

// braucht c++
__asm__(".globl __stack_chk_fail");
__asm__(".globl __pure_virtual");
__asm__(".globl __builtin_delete");
__asm__(".globl __cxa_pure_virtual");
__asm__(".globl __cxa_atexit");
__asm__(".globl _ZdlPv");
__asm__("_ZdlPv:");
__asm__("__cxa_atexit:");
__asm__("__cxa_pure_virtual:");
__asm__("__builtin_delete:");
__asm__("__pure_virtual:");
__asm__("__stack_chk_fail:");
__asm__("	ret");
