#include "I386ASM/ASMInstructionList.hpp"

// public
ASMInstructionList::ASMInstructionList(Environment &env): Object(env), pos(0) {}
ASMInstructionList::~ASMInstructionList() {
    InstructionElem * cur = first;
    while (cur) {
        InstructionElem * destroy = cur;
        cur = cur->next;
        env().destroy(destroy->inst);
        env().destroy(*destroy);
    }
    last = first = 0;
    pos = 0;
}

void ASMInstructionList::addInstruction(ASMInstruction &inst) {
    InstructionElem * e = &env().create<InstructionElem, ASMInstruction&, size_t>(inst, pos);
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
    for (InstructionElem * cur = first; cur ; cur = cur->next) {
        // TODO: resolve arguments;
        stream << cur->inst;
    }
}