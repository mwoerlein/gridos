#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Halt.hpp"
#include "I386ASM/Jump.hpp"
#include "I386ASM/Mov.hpp"

Kernel &KernelJIT::kernel_compile(IStream & in) {
    int x = 0;
    char c = 255;
    int ackblock = 0;
    
    OStream &out = env().getStdO();
    if (!in.empty()) do {
        in>>c;
        switch (c) {
            case '>': ackblock += 2;
            case '<': ackblock--;
                while(c!='\n') in>>c; //Rest der Zeile ueberlesen
                break;
            default: out<<c;
        }
    } while (ackblock > 0);

    // TODO: "malloc" kernel output space
    OStreamKernel &osk = env()._create<I386OStreamKernel, MemoryInfo&>(env().getAllocator().info((void *) 0));
    //*/
    osk
        << env().create<Mov>()
        << env().create<Halt>()
        << env().create<Jump>()
    ;
    
    /*/
    out<<"copying ";
    while (!in.empty()) {
        in>>c;
        osk<<c;
        x++;
    }
    out<<x<<" bytes"<<'\n';
    //*/
    out<<"ready!"<<'\n';

    return osk;
}

