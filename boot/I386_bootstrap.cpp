// C++14 additional delete operators
#if __cplusplus >= 201402L
__attribute__((weak)) void operator delete(void * ptr, unsigned int) { ::operator delete(ptr); }
__attribute__((weak)) void operator delete[](void * ptr, unsigned int) { ::operator delete(ptr); }
#endif

#include "I386/I386Bootstrap.hpp"
#include "KernelJIT/KernelJIT.hpp"
#include "memory/MemoryIStream.hpp"
#include "sys/Environment.hpp"

extern "C" {

Environment & bootstrapEnvironment(unsigned long magic, void *mbi, void *mbh) {
    I386Bootstrap bs;
    return bs.buildEnvironment(magic, mbi, mbh);
}

void bootstrap(unsigned long magic, void *mbi, void *mbh){
    // create environment
    Environment &env = bootstrapEnvironment(magic, mbi, mbh);
    if (!&env) {
        return;
    }
    
    // compile kernel from modules
    MemoryIStream &in = env._create<MemoryIStream, MemoryInfo&>(env.getModules()->memoryInfo);
    KernelJIT &jit = env.create<KernelJIT>();

    env.getStdO()<<'C'<<'o'<<'m'<<'p'<<'i'<<'l'<<'i'<<'n'<<'g'<<' '<<'.'<<'.'<<'.'<<' '<<'w'<<'i'<<'t'<<'h'<<' '<<&jit<<'\n';
    Kernel &k = jit.kernel_compile(in);
    
    env.destroy(jit);
    env.destroy(in);

    // run compiled kernel    
    env.getStdO()<<'S'<<'t'<<'a'<<'r'<<'t'<<'i'<<'n'<<'g'<<' '<<'k'<<'e'<<'r'<<'n'<<'e'<<'l'<<' '<<'.'<<'.'<<'.'<<'\n';
    k.run();
}

}
//*/

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

