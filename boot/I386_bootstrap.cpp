// C++14 additional delete operators
#if __cplusplus >= 201402L
__attribute__((weak)) void operator delete(void * ptr, unsigned int) { ::operator delete(ptr); }
__attribute__((weak)) void operator delete[](void * ptr, unsigned int) { ::operator delete(ptr); }
#endif

#include "I386/I386Bootstrap.hpp"
#include "KernelJIT/KernelJIT.hpp"
#include "KernelJIT/HaltKernel.hpp"
#include "memory/MemoryIStream.hpp"
//#include "memory/MemoryManager.hpp"
//#include "test/TestSuite.hpp"

extern "C" {

KernelEnvironment & bootstrapEnvironment(unsigned long magic, void *mbi, void *mbh) {
    I386Bootstrap bs;
    return bs.buildEnvironment(magic, mbi, mbh);
}

void bootstrap(unsigned long magic, void *mbi, void *mbh){
    // create environment
    KernelEnvironment &env = bootstrapEnvironment(magic, mbi, mbh);
    if (!&env) {
        return;
    }
/*/
    {
        TestSuite ts(env);
        ts.runAll();
        return;
    }
//*/
//    MemoryManager &ma = *env.as<MemoryManager>(env.getAllocator(), object);
    
    // compile kernel from modules
    if (!env.hasModule("kernel")) {
        env.err()<<"No kernel loaded!\n"<<"Halting ...\n";
        HaltKernel hk(env);
        hk.run();
    }
    MemoryIStream &in = env.create<MemoryIStream, MemoryInfo&>(env.getModule("kernel").memoryInfo);
    KernelJIT &jit = env.create<KernelJIT>();

    env.out()<<"Compiling ... with "<<&jit<<'\n';
    Kernel &k = jit.kernel_compile(in);
    
    env.destroy(jit);
    env.destroy(in);
    env.destroyModules();
    
//    env.out()<<env<<' '<<env.getAllocator()<<' '<<env.out()<<' '<<env.err()<<' '<<k<<'\n';
//    ma.dump(env.err(), true);
    
    if (!&k) {
        env.err()<<"Compiling kernel failed!\n"<<"Halting ...\n";
        HaltKernel hk(env);
        hk.run();
    }
    // run compiled kernel    
    env.out()<<"Starting kernel ... "<<(void*) k.getStartAddress()<<'\n';
    k.run();

//    env.destroy(k);
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
