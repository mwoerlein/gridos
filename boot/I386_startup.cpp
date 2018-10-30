// C++14 additional delete operators
#if __cplusplus >= 201402L
__attribute__((weak)) void operator delete(void * ptr, unsigned int) { ::operator delete(ptr); }
__attribute__((weak)) void operator delete[](void * ptr, unsigned int) { ::operator delete(ptr); }
#endif

#include "I386/I386Bootstrap.hpp"
#include "KernelJIT/KernelJIT.hpp"
#include "KernelJIT/HaltKernel.hpp"
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
            Module &module = modules.next();
            env.out() << '[' << module.getId() << "] (at "<<module.memoryInfo.buf<<")\n"; 
            if (debugLevel >= 3) { module.dumpProperties(env.out()); }
        }
        modules.destroy();
    }
    
    // compile kernel from modules
    assertHALT(env.hasModule("kernel"), "No kernel loaded!");
    KernelJIT &jit = env.create<KernelJIT>();
    if (debugLevel >= 1) { env.out()<<"Compiling ... with "<<&jit<<'\n'; }
    Kernel &k = jit.kernel_compile(env.getModule("kernel"));
    
    jit.destroy();
    env.destroyModules();
    
    if (debugLevel >= 2) {
        env.out()<<env<<' '<<env.getAllocator()<<' '<<env.out()<<' '<<env.err();
        if (&k) { env.out()<<' '<<k; }
        env.out()<<'\n';
        env.getAllocator().dump(env.err(), debugLevel >= 3);
    }
    
    assertHALT(&k, "Compiling kernel failed!");
    
    // run compiled kernel    
    if (debugLevel >= 1) {
        env.out()<<"Starting kernel ... "<<(void*) k.getStartAddress()<<'\n';
    }
    k.run();
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
