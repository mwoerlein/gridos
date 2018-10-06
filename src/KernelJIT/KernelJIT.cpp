#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Parser.hpp"
#include "I386ASM/ParseErrorStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"

Kernel &KernelJIT::kernel_compile(Module & module) {
    // TODO: improve debug handling 
    int debugLevel = 0;
    if (module.testStringProperty("meta.debug", "1")) {
        debugLevel = 1;
    }
    if (module.testStringProperty("meta.debug", "2")) {
        debugLevel = 2;
    }
    if (module.testStringProperty("meta.debug", "3")) {
        debugLevel = 3;
    }
    
    if (module.testStringProperty("meta.mimetype", "text/x-pasm")) {
        Parser &parser = env().create<Parser>();
        IStream &in = module.getContentIStream();
        ASMInstructionList &list = parser.parse(in, env().err());
        in.destroy();
        parser.destroy();
        
        if (list.hasErrors()) {
            if (debugLevel >= 2) { env().err()<<"parsing error\n"; }
            list.destroy();
            return *(Kernel *) 0;
        }
        
        size_t size = list.compile();
        if (list.hasErrors()) {
            if (debugLevel >= 2) { env().err()<<"compile error\n"; }
            list.destroy();
            return *(Kernel *) 0;
        }
        
        OStreamKernel &osk = env().create<I386OStreamKernel, size_t>(size);
        list.finalize(osk.getStartAddress());
        if (list.hasErrors()) {
            if (debugLevel >= 2) { env().err()<<"finalize error\n"; }
            osk.destroy();
            list.destroy();
            return *(Kernel *) 0;
        }
        
        if (debugLevel >= 2) { list.logToStream(env().out(), debugLevel >= 3); }
        list.writeToStream(osk);
        list.destroy();
        return osk;
    }
    
    if (module.testStringProperty("meta.mimetype", "application/x-bin-x86")) {
        size_t size = module.getContentSize();
        OStreamKernel &osk = env().create<I386OStreamKernel, size_t>(size);
        IStream &in = module.getContentIStream();
        if (debugLevel >= 2) { env().out()<<"copying "<<size<< " bytes ..."; }
        osk<<in;
        if (debugLevel >= 2) { env().out()<<" done\n"; }
        in.destroy();
        return osk;
    }
    
    return *(Kernel *) 0;
}
