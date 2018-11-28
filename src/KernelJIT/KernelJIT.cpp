#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Parser.hpp"
#include "I386ASM/ParseErrorStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"

Kernel &KernelJIT::kernel_compile(Module & module, KernelRuntime &kr) {
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
    
    if (debugLevel >= 2) { env().out()<<"compile module "<<module.getId()<<"\n"; }
    
    if (!module.hasStringProperty("meta.mimetype")) {
        env().err()<<"Missing mimetype\n";
        return *(Kernel *) 0;
    }
    
    // TODO: #12 separate mimetype interpretation, load, compile and register into overall module loading workflow
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
        if (module.testStringProperty("pool.class", "true")) {
            ClassDescriptor *cd = kr.registerClass((pool_class_descriptor*) osk.getStartAddress());
            if (cd && module.hasStringProperty("pool.bootstrapOffset") && list.hasDefinition(module.getStringProperty("pool.bootstrapOffset"))) {
                kr.setBootstrap(*cd, list.getValue(module.getStringProperty("pool.bootstrapOffset")));
            }
        }
        list.destroy();
        return osk;
    }
    
    // TODO: #12 separate mimetype interpretation, load, compile and register into overall module loading workflow
    if (module.testStringProperty("meta.mimetype", "application/x-bin-x86")) {
        size_t size = module.getContentSize();
        OStreamKernel &osk = env().create<I386OStreamKernel, size_t>(size);
        IStream &in = module.getContentIStream();
        if (debugLevel >= 2) { env().out()<<"copying "<<size<< " bytes ..."; }
        osk<<in;
        if (debugLevel >= 2) { env().out()<<" done\n"; }
        in.destroy();
        if (module.testStringProperty("pool.class", "true")) {
            ClassDescriptor *cd = kr.registerClass((pool_class_descriptor*) osk.getStartAddress());
            if (cd && module.hasStringProperty("pool.bootstrapOffset")) {
                int bs = 0;
                module.getStringProperty("pool.bootstrapOffset") >> bs;
                kr.setBootstrap(*cd, bs);
            }
        }
        return osk;
    }
    
    env().err()<<"Unsupported mimetype: "<<module.getStringProperty("meta.mimetype")<<'\n';
    return *(Kernel *) 0;
}
