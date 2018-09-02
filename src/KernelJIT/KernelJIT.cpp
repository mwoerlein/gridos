#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Parser.hpp"
#include "I386ASM/ASMInstructionList.hpp"

#include "sys/String.hpp"

Kernel &KernelJIT::kernel_compile(IStream & in) {
    int x = 0;
    char c = 255;
    int ackblock = 0;
    int line = 1;
    OStream &out = env().out();
    if (!in.isEmpty()) do {
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

    if (true) {
        String pretty(env());
        list.logToStream(pretty);
        out<<pretty<<'\n';
        IStream &prettyIn = pretty.toIStream();
        ASMInstructionList &list2 = parser.parse(prettyIn);
        list2.logToStream(out);
        list2.destroy();
        prettyIn.destroy();
    }
    
    OStreamKernel &osk = env().create<I386OStreamKernel, size_t>(list.getSizeInBytes());
    list.writeToStream(osk);
    list.destroy();
    parser.destroy();
    
    // TODO: parse meta information of TEXT block and switch between copy and compile
    /*
    out<<"copying ";
    while (!in.isEmpty()) {
        in>>c;
        osk<<c;
        x++;
    }
    out<<x<<" bytes"<<'\n';
    */
    
    
    out<<"ready!"<<'\n';

    return osk;
}

