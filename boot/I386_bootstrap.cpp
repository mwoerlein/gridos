// C++14 additional delete operators
#if __cplusplus >= 201402L
__attribute__((weak)) void operator delete(void * ptr, unsigned int) { ::operator delete(ptr); }
__attribute__((weak)) void operator delete[](void * ptr, unsigned int) { ::operator delete(ptr); }
#endif

#include "Environment.hpp"
#include "I386/I386Bootstrap.hpp"
#include "I386/I386KernelTextIStream.hpp"
#include "I386/I386OStreamKernel.hpp"
#include "KernelJIT/DebugSystem.hpp"
#include "KernelJIT/KernelJIT.hpp"
#include "sys/OStream.hpp"

extern "C" {

void bootstrap(unsigned long magic, void *mbi, void *mbh){
    I386Bootstrap bs(magic, mbi, mbh);
    if (!bs.isValid()) {
        return;
    }
    
    // TODO: fill and use environment instead of bs furthermore
    Environment *env = bs.buildEnvironment();
    
    DebugSystem &ds = bs.getDebugSystem();
    OStream &out = ds.getOStream();
    
    I386KernelTextIStream in(bs.getKernelTextInfo());
    I386OStreamKernel osk(bs.getKernelOutInfo());
    
    KernelJIT jit(in,osk,ds);
    out<<'C'<<'o'<<'m'<<'p'<<'i'<<'l'<<'i'<<'n'<<'g'<<' '<<'.'<<'.'<<'.'<<'\n';
    Kernel &k=jit.kernel_compile();
    out<<'S'<<'t'<<'a'<<'r'<<'t'<<'i'<<'n'<<'g'<<' '<<'k'<<'e'<<'r'<<'n'<<'e'<<'l'<<' '<<'.'<<'.'<<'.'<<'\n';
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

