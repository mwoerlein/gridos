#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

#include "I386ASM/Parser.hpp"
#include "I386ASM/ParseErrorStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Number.hpp"

// TODO: #9 improve/separate runtime injection
extern "C" {
    MemoryInfo * _allocator_allocate(MemoryAllocator *allocator, size_t size) {
        return &allocator->allocate(size);
    }
    void _allocator_free(MemoryAllocator *allocator, MemoryInfo *info) {
        allocator->free(*info);
    }
    void _ostream_print_char(OStream *stream, int c) {
        *stream << (char) c;
    }
    void _ostream_print_string(OStream *stream, char * c) {
        *stream << c;
    }
    void _ostream_print_int(OStream *stream, int i) {
        *stream << i;
    }
    void _ostream_print_hex(OStream *stream, int i) {
        stream->printhex(i);
    }
}

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
    
    if (!module.hasStringProperty("meta.mimetype")) {
        env().err()<<"Missing mimetype\n";
        return *(Kernel *) 0;
    }
    
    if (module.testStringProperty("meta.mimetype", "text/x-pasm")) {
        Parser &parser = env().create<Parser>();
        IStream &in = module.getContentIStream();
        ASMInstructionList &list = parser.parse(in, env().err());
        in.destroy();
        parser.destroy();
        
        {
            // TODO: #9 improve/separate runtime injection
            list.addDefinition(
                env().create<String, const char *>("_env_allocator"),
                env().create<Number, int>((int) &env().getAllocator())
            );
            list.addDefinition(
                env().create<String, const char *>("_env_out"),
                env().create<Number, int>((int) &env().out())
            );
            list.addDefinition(
                env().create<String, const char *>("_env_err"),
                env().create<Number, int>((int) &env().err())
            );
            list.addDefinition(
                env().create<String, const char *>("_allocator_allocate"),
                env().create<Number, int>((int) _allocator_allocate)
            );
            list.addDefinition(
                env().create<String, const char *>("_allocator_free"),
                env().create<Number, int>((int) _allocator_free)
            );
            list.addDefinition(
                env().create<String, const char *>("_ostream_print_char"),
                env().create<Number, int>((int) _ostream_print_char)
            );
            list.addDefinition(
                env().create<String, const char *>("_ostream_print_string"),
                env().create<Number, int>((int) _ostream_print_string)
            );
            list.addDefinition(
                env().create<String, const char *>("_ostream_print_int"),
                env().create<Number, int>((int) _ostream_print_int)
            );
            list.addDefinition(
                env().create<String, const char *>("_ostream_print_hex"),
                env().create<Number, int>((int) _ostream_print_hex)
            );
        }
        
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
    
    env().err()<<"Unsupported mimetype: "<<module.getStringProperty("meta.mimetype")<<'\n';
    return *(Kernel *) 0;
}
