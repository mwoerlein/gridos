#include "KernelJIT/KernelRuntime.hpp"

#include "I386ASM/Operand/Number.hpp"

// TODO: #12 improve/separate runtime injection
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
    pool_class_descriptor * _runtime_findClass(KernelRuntime *kr, const char * c) {
        return kr->findClass(c);
    }
}

bool KernelRuntime::registerClass(pool_class_descriptor *desc) {
    if (desc->magic != 0x15AC1A55) {
        env().err() << "try to register invalid class at " << desc << '\n';
        return false;
    }
    
    ClassDescriptor &cd = env().create<ClassDescriptor, pool_class_descriptor*>(desc);
    if (has(cd.name)) {
        env().err() << "class " << cd.name << " already registered\n";
        return false;
    }
    set(cd.name, cd);
    return true;
}

bool KernelRuntime::resolveClasses() {
    Iterator<ClassDescriptor> &cds = values();
    while (cds.hasNext()) {
        pool_class_descriptor *desc = cds.next().desc;
        // resolve vtabs
        for (int i = 0; desc->vtabs[i].classname_offset; i++) {
            const char * name = (const char *) ((size_t) desc + desc->vtabs[i].classname_offset);
            desc->vtabs[i].class_desc = findClass(name);
            if (!desc->vtabs[i].class_desc) {
                env().err() << "unknown class " << name << "\n";
                return false;
            }
        }
    }
    cds.destroy();
    return true;
}

pool_class_descriptor * KernelRuntime::findClass(const char *name) {
    String &s = env().create<String, const char*>(name);
    pool_class_descriptor * ret = has(s) ? get(s).desc : 0;
    s.destroy();
    return ret;
}

void KernelRuntime::injectDefinitions(ASMInstructionList &list) {
    // TODO: #12 improve/separate runtime injection
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
        env().create<String, const char *>("_env_runtime"),
        env().create<Number, int>((int) this)
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
    list.addDefinition(
        env().create<String, const char *>("_runtime_findClass"),
        env().create<Number, int>((int) _runtime_findClass)
    );
}
