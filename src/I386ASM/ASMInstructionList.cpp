#include "I386ASM/ASMInstructionList.hpp"

class ASMInstructionList::_Elem: virtual public Object {
    public:
    _Elem * next;
    size_t pos;
    ASMInstruction *inst;
    String *identifier;
    Number *value;
    BitWidth mode, data, addr;
    
    _Elem(Environment &env, MemoryInfo &mi, BitWidth mode)
        :Object(env, mi),inst(0),identifier(0),value(0),
        pos(0),next(0),mode(mode),data(bit_auto),addr(bit_auto) {}
    _Elem(Environment &env, MemoryInfo &mi, String *identifier, Number *value = 0)
        :Object(env, mi),inst(0),identifier(identifier),value(value),
        pos(0),next(0),mode(bit_auto),data(bit_auto),addr(bit_auto) {}
    _Elem(Environment &env, MemoryInfo &mi, ASMInstruction *inst, BitWidth data, BitWidth addr)
        :Object(env, mi),inst(inst),identifier(0),value(0),
        pos(0),next(0),mode(bit_auto),data(data),addr(addr) {}
    virtual ~_Elem() {
        if (inst) {
            inst->destroy();
        }
        if (identifier) {
            identifier->destroy();
        }
        if (value) {
            value->destroy();
        }
    }
};

// public
ASMInstructionList::ASMInstructionList(Environment &env, MemoryInfo &mi, OStream &error)
    : Object(env, mi), warn(error), err(env.create<ParseErrorStream, OStream&>(error)),
      ids(env.create<HashMap<String, _Elem>>()), pos(-1), first(0), last(0) {
    setMode(bit_32);
}
ASMInstructionList::~ASMInstructionList() {
    _Elem * cur = first;
    while (cur) {
        _Elem * kill = cur;
        cur = cur->next;
        kill->destroy();
    }
    last = first = 0;
    pos = -1;
    ids.destroy();
    err.destroy();
}

void ASMInstructionList::setMode(BitWidth mode) {
    if (last && !last->inst && !last->identifier) {
        // reuse previous mode, if available
        last->mode = mode;
        return;
    }
    _Elem * e = &env().create<_Elem, BitWidth>(mode);
    if (!first) {
        first = last = e;
    } else {
        last = last->next = e;
    }
}

void ASMInstructionList::addInstruction(ASMInstruction &inst, BitWidth data, BitWidth addr) {
    _Elem * e = &env().create<_Elem, ASMInstruction*>(&inst, data, addr);
    e->mode = last->mode;
    last = last->next = e;
    inst.list = this;
}

void ASMInstructionList::addLabel(String &label) {
    _Elem * e = &env().create<_Elem, String*>(&label);
    e->mode = last->mode;
    last = last->next = e;
    ids.set(label, *e);
}

void ASMInstructionList::addDefinition(String &definition, Number &value) {
    _Elem * e = &env().create<_Elem, String*, Number*>(&definition, &value);
    e->mode = last->mode;
    last = last->next = e;
    ids.set(definition, *e);
}

bool ASMInstructionList::hasLabel(String &label) {
    return ids.has(label) && !ids.get(label).value;
}

bool ASMInstructionList::hasDefinition(String &label) {
    return ids.has(label) && ids.get(label).value;
}

size_t ASMInstructionList::getLabel(String &label) {
    return ids.get(label).pos;
}

Number & ASMInstructionList::getNumberForDefinition(String &label) {
    _Elem & e = ids.get(label);
    return env().create<Number,int>(e.value ? e.value->value(): e.pos);
}

bool ASMInstructionList::hasLabel(Identifier &id) { return hasLabel(id.id()); }
bool ASMInstructionList::hasDefinition(Identifier &id) { return hasDefinition(id.id()); }
size_t ASMInstructionList::getLabel(Identifier &id) { return getLabel(id.id()); }
Number & ASMInstructionList::getNumberForDefinition(Identifier &id) { return getNumberForDefinition(id.id()); }


size_t ASMInstructionList::compile() {
    if (pos != -1) {
        err << "List is already compiled!\n";
        return pos;
    }
    pos = 0;
    for (_Elem * cur = first; cur ; cur = cur->next) {
        cur->pos = pos;
        if (cur->inst) {    
            cur->inst->pos = pos;
            pos += cur->inst->prepare(
                (cur->data == bit_auto) ? cur->mode : cur->data,
                (cur->addr == bit_auto) ? cur->mode : cur->addr,
                cur->mode
            );
        }
    }
    pos = 0;
    for (_Elem * cur = first; cur ; cur = cur->next) {
        cur->pos = pos;
        if (cur->inst) {    
            cur->inst->pos = pos;
            pos += cur->inst->compile(
                (cur->data == bit_auto) ? cur->mode : cur->data,
                (cur->addr == bit_auto) ? cur->mode : cur->addr,
                cur->mode
            );
        }
    }
    return pos;
}

void ASMInstructionList::finalize(size_t startAddress) {
    if (pos == -1) {
        err << "List is not compiled!\n";
        return;
    }
    if (startAddress) {
        for (_Elem * cur = first; cur ; cur = cur->next) {
            cur->pos += startAddress;
            if (cur->inst) {
                cur->inst->pos = cur->pos;
            }
        }
    }
}

bool ASMInstructionList::hasErrors() {
    return (int) err;
}

void ASMInstructionList::writeToStream(OStream &stream) {
    if (pos == -1) {
        err << "List is not compiled!\n";
        return;
    }
    for (_Elem * cur = first; cur ; cur = cur->next) {
        if (cur->inst) {
            cur->inst->writeToStream(stream);
        }
    }
}

class DebugOStreamWrapper: public OStream {
    private:
    OStream &out;
    
    public:
    using OStream::operator <<;
    DebugOStreamWrapper(Environment &env, MemoryInfo &mi, OStream &out): Object(env, mi), out(out) {}
    virtual ~DebugOStreamWrapper() { }
    
    virtual OStream &operator <<(char c) override {
        (out<<' ').printuhex((unsigned char)c,2);
        return *this;
    }
};

void ASMInstructionList::logToStream(OStream &stream, bool debug) {
    for (_Elem * cur = first; cur ; cur = cur->next) {
        if (cur->inst) {      
            if (cur->data != cur->mode) switch (cur->data) {
                case bit_32: stream << ".data32 "; break;
                case bit_16: stream << ".data16 "; break;
            }
            if (cur->addr != cur->mode) switch (cur->addr) {
                case bit_32: stream << ".addr32 "; break;
                case bit_16: stream << ".addr16 "; break;
            }
            stream << *cur->inst;
            if (debug) {
                DebugOStreamWrapper wrap(env(), *notAnInfo, stream);
                stream << "\t// " << (void*) cur->inst->pos << ": (" << cur->inst->size << ")";
                cur->inst->writeToStream(wrap);
            }
        } else if (cur->identifier) {
            if (cur->value) {
                if (pos != -1) {
                    // skip definitions after compilation
                    // instructions replace definition usages with corresponding numbers
                    if (debug) {
                        stream << "// ";
                    } else {
                        continue;
                    }
                } 
                stream << *cur->identifier << " := " << *cur->value;
            } else {
                stream << *cur->identifier << ":";
            }
        } else {
            switch (cur->mode) {
                case bit_32: stream << ".code32"; break;
                case bit_16: stream << ".code16"; break;
            }
        }
        stream << '\n';
    }
}
