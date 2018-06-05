// C++14 additional delete operators
#if __cplusplus >= 201402L
__attribute__((weak)) void operator delete(void * ptr, unsigned int) { ::operator delete(ptr); }
__attribute__((weak)) void operator delete[](void * ptr, unsigned int) { ::operator delete(ptr); }
#endif

#include "I386/I386MemoryList.hpp"
#include "I386/I386DebugSystem.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386IO_Port.hpp"
#include "KernelJIT/KernelJIT.hpp"
#include "sys/OStream.hpp"
//#include "sys/String.hpp"
extern "C" {

void bootstrap(memlist *ml){
    I386DebugSystem ds;
    I386MemoryList memory(ml);
    
    OStream &out=ds.getOStream();

//    String test((char*)("Hallo"));
    int x=0;
    KernelJIT jit(memory,ds);
    out<<'C'<<'o'<<'m'<<'p'<<'i'<<'l'<<'i'<<'n'<<'g'<<' '<<'.'<<'.'<<'.'<<'\n';
    Kernel &k=jit.kernel_compile();
    out<<'S'<<'t'<<'a'<<'r'<<'t'<<'i'<<'n'<<'g'<<' '<<'k'<<'e'<<'r'<<'n'<<'e'<<'l'<<' '<<'.'<<'.'<<'.'<<'\n';
    k.run();
    while (1) { __asm__("hlt"); };
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

