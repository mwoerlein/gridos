#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Parser.hpp"
#include "I386ASM/ParseErrorStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"

#include "sys/String.hpp"

Kernel &KernelJIT::kernel_compile(IStream & in) {
    int x = 0;
    char c = 255;
    int ackblock = 0;
    int line = 1;
    OStream &out = env().out();
    if (!in.isEmpty()) do {
        in >> c;
        switch (c) {
            case '>': ackblock += 2;
            case '<': ackblock--;
                while (c != '\n') { in >> c; } // ignore whole line
                line++;
                break;
            default:
                out << c;
                while (c != '\n') { in >> c; out << c; } // output whole line
                line++;
        }
    } while (ackblock > 0);
    
    Parser &parser = env().create<Parser>();
    ASMInstructionList &list = parser.parse(in, env().err(), line);
    parser.destroy();
    
    if (list.hasErrors()) {
        list.destroy();
        return *(Kernel *) 0;
    }
    
    size_t size = list.prepare();
    if (list.hasErrors()) {
        list.destroy();
        return *(Kernel *) 0;
    }
    
    OStreamKernel &osk = env().create<I386OStreamKernel, size_t>(size);
    list.finalize(osk.getStartAddress());
    if (list.hasErrors()) {
        osk.destroy();
        list.destroy();
        return *(Kernel *) 0;
    }
    
//    list.logToStream(env().out(), true);
    list.writeToStream(osk);
    list.destroy();
    
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

