#include "I386ASM/ASMInstructionList.hpp"

class ASMInstructionList::_Elem: virtual public Object {
    public:
    _Elem * next;
    ASMInstruction &inst;
    size_t pos;
    
    _Elem(Environment &env, MemoryInfo &mi, ASMInstruction &inst, size_t pos)
        :Object(env, mi),inst(inst),pos(pos),next(0) {}
    virtual ~_Elem() {}
};

// public
ASMInstructionList::ASMInstructionList(Environment &env, MemoryInfo &mi): Object(env, mi), pos(0), first(0), last(0) {}
ASMInstructionList::~ASMInstructionList() {
    _Elem * cur = first;
    while (cur) {
        _Elem * kill = cur;
        cur = cur->next;
        kill->inst.destroy();
        kill->destroy();
    }
    last = first = 0;
    pos = 0;
}

void ASMInstructionList::addInstruction(ASMInstruction &inst) {
    _Elem * e = &env().create<_Elem, ASMInstruction&, size_t>(inst, pos);
    pos += inst.getSizeInBytes();
    if (!first) {
        first = last = e;
    } else {
        last = last->next = e;
    }
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

void ASMInstructionList::logToStream(OStream &stream) {
    for (_Elem * cur = first; cur ; cur = cur->next) {
        stream << cur->inst << '\n';
    }
}
