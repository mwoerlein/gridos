#include "I386ASM/ASMInstructionList.hpp"

#include "sys/Digit.hpp"
#include "sys/String.hpp"

class ASMInstructionList::_Elem: virtual public Object {
    public:
    _Elem * next;
    size_t pos;
    ASMInstruction *inst;
    String *identifier;
    Number *value;
    
    _Elem(Environment &env, MemoryInfo &mi, String *identifier, Number *value = 0)
        :Object(env, mi),inst(0),identifier(identifier),value(value),pos(0),next(0) {}
    _Elem(Environment &env, MemoryInfo &mi, ASMInstruction *inst)
        :Object(env, mi),inst(inst),identifier(0),value(0),pos(0),next(0) {}
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
ASMInstructionList::ASMInstructionList(Environment &env, MemoryInfo &mi): Object(env, mi), ids(env.create<HashMap<String, _Elem>>()), pos(-1), first(0), last(0) {}
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
}

void ASMInstructionList::addInstruction(ASMInstruction &inst) {
    _Elem * e = &env().create<_Elem, ASMInstruction*>(&inst);
    if (!first) {
        first = last = e;
    } else {
        e->pos = last->pos + ((last->inst) ? last->inst->getMaxSizeInBytes() : 0);
        last = last->next = e;
    }
    inst.pos = e->pos;
}

void ASMInstructionList::addLabel(String &label) {
    _Elem * e = &env().create<_Elem, String*>(&label);
    if (!first) {
        first = last = e;
    } else {
        e->pos = last->pos + ((last->inst) ? last->inst->getMaxSizeInBytes() : 0);
        last = last->next = e;
    }
    ids.set(label, *e);
}

void ASMInstructionList::addDefinition(String &definition, Number &value) {
    _Elem * e = &env().create<_Elem, String*, Number*>(&definition, &value);
    if (!first) {
        first = last = e;
    } else {
        e->pos = last->pos + ((last->inst) ? last->inst->getMaxSizeInBytes() : 0);
        last = last->next = e;
    }
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

Number & ASMInstructionList::getDefinition(String &label) {
    return *ids.get(label).value;
}

bool ASMInstructionList::prepare(OStream &err) {
    if (pos != -1) {
        err << "List is already prepared!\n";
        return false;
    }
    pos = 0;
    bool success = true;
    for (_Elem * cur = first; cur ; cur = cur->next) {
        cur->pos = pos;
        if (cur->inst) {    
            cur->inst->pos = pos;
            cur->inst->list = this;
            if (cur->inst->prepare(err) && success) {
                pos += cur->inst->getSizeInBytes();
            } else {
                success = false;
            }
        }
    }
    return success;
}

bool ASMInstructionList::finalize(OStream &err, void * start) {
    if (pos == -1) {
        err << "List is not prepared!\n";
        return false;
    }
    for (_Elem * cur = first; cur ; cur = cur->next) {
        cur->pos += (size_t) start;
        if (cur->inst) {
            cur->inst->pos = cur->pos;
        }
    }
    return true;
}

size_t ASMInstructionList::getSizeInBytes() {
    return pos;
}
    
void ASMInstructionList::writeToStream(OStream &stream) {
    // TODO: resolve definitions;
    for (_Elem * cur = first; cur ; cur = cur->next) {
        // TODO: resolve arguments;
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
        Digit d1(env());
        Digit d2(env());
        d1 = (int) c>>4 & 0xf;
        d2 = (int) c & 0xf;
        out << " 0x" << d1 << d2;
        return *this;
    }
};

void ASMInstructionList::logToStream(OStream &stream, bool debug) {
    for (_Elem * cur = first; cur ; cur = cur->next) {
        if (cur->inst) {        
            stream << *cur->inst;
            if (debug) {
                DebugOStreamWrapper wrap(env(), *notAnInfo, stream);
                stream << "\t// " << cur->pos << ":\t(" << cur->inst->getSizeInBytes() << ")";
                cur->inst->writeToStream(wrap);
            }
        } else if (cur->identifier) {
            if (cur->value) {
                stream << *cur->identifier << " := ";
                cur->value->logToStream(stream);
            } else {
                stream << *cur->identifier << ":";
            }
        }
        stream << '\n';
    }
}
