#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Parser.hpp"
#include "I386ASM/ASMInstructionList.hpp"

Kernel &KernelJIT::kernel_compile(IStream & in) {
    int x = 0;
    char c = 255;
    int ackblock = 0;
    int line = 1;
    OStream &out = env().out();
    if (!in.empty()) do {
        in>>c;
        switch (c) {
            case '>': ackblock += 2;
            case '<': ackblock--;
                while(c!='\n') in>>c; //Rest der Zeile ueberlesen
                line++;
                break;
            case '\n':
                line++;
            default: out<<c;
        }
    } while (ackblock > 0);
    
    Parser &parser = env().create<Parser>();
    ASMInstructionList &list = parser.parse(in, line);
    
    OStreamKernel &osk = env().create<I386OStreamKernel, size_t>(list.getSizeInBytes());
    list.writeToStream(osk);
    env().destroy(list);
    env().destroy(parser);
    
    // TODO: parse meta information of TEXT block and switch between copy and compile
    /*
    out<<"copying ";
    while (!in.empty()) {
        in>>c;
        osk<<c;
        x++;
    }
    out<<x<<" bytes"<<'\n';
    */
    
    
    out<<"ready!"<<'\n';

    return osk;
}

