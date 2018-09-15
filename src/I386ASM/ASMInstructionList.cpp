#include "I386ASM/ASMInstructionList.hpp"

#include "sys/Digit.hpp"

class ASMInstructionList::_Elem: virtual public Object {
    public:
    _Elem * next;
    ASMInstruction &inst;
    size_t pos;
    
    _Elem(Environment &env, MemoryInfo &mi, ASMInstruction &inst)
        :Object(env, mi),inst(inst),pos(-1),next(0) {}
    virtual ~_Elem() {}
};

// public
ASMInstructionList::ASMInstructionList(Environment &env, MemoryInfo &mi): Object(env, mi), pos(-1), first(0), last(0) {}
ASMInstructionList::~ASMInstructionList() {
    _Elem * cur = first;
    while (cur) {
        _Elem * kill = cur;
        cur = cur->next;
        kill->inst.destroy();
        kill->destroy();
    }
    last = first = 0;
    pos = -1;
}

void ASMInstructionList::addInstruction(ASMInstruction &inst) {
    _Elem * e = &env().create<_Elem, ASMInstruction&>(inst);
    if (!first) {
        first = last = e;
    } else {
        last = last->next = e;
    }
}

bool ASMInstructionList::prepare(OStream &err) {
    if (pos != -1) {
        err << "List is already prepared!\n";
        return false;
    }
    pos = 0;
    bool success = true;
    for (_Elem * cur = first; cur ; cur = cur->next) {
        if (cur->inst.prepare(err) && success) {
            cur->pos = pos;
            pos += cur->inst.getSizeInBytes();
        } else {
            success = false;
        }
    }
    return success;
}

size_t ASMInstructionList::getSizeInBytes() {
    return pos;
}
    
void ASMInstructionList::writeToStream(OStream &stream) {
    // TODO: resolve definitions;
    for (_Elem * cur = first; cur ; cur = cur->next) {
        // TODO: resolve arguments;
        cur->inst.writeToStream(stream);
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
        stream << cur->inst;
        if (debug) {
            DebugOStreamWrapper wrap(env(), *notAnInfo, stream);
            stream << "\t// " << cur->pos << ":\t(" << cur->inst.getSizeInBytes() << ")";
            cur->inst.writeToStream(wrap);
        }
        stream << '\n';
    }
}
