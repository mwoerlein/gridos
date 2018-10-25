#include "I386ASM/Operand/Identifier.hpp"

#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/ASMInstructionList.hpp"

// public
Identifier::Identifier(Environment &env, MemoryInfo &mi, String &id):Numeric(env, mi), Object(env, mi), _id(id) {}
Identifier::~Identifier() {
    _id.destroy();
}
    
String & Identifier::id() {
    return _id;
}

OStream & Identifier::operator >>(OStream & stream) {
    return stream << _id;
}

int Identifier::getValue(ASMInstructionList & list) {
    return list.getLabel(*this);
}

Numeric & Identifier::clone() {
    return env().create<Identifier, String&>(env().create<String, String&>(_id));
}

Number * Identifier::validateAndResolveDefinition(ASMInstructionList & list) {
    if (list.hasDefinition(_id)) {
        Numeric & num = list.getNumberForDefinition(_id);
        if (Number * n = num.as<Number>(number)) {
            return n;
        }
        num.destroy();
    } else if (!list.hasLabel(_id)) {
        list.err << "Unknown identifier: " << *this << '\n';
    }
    return 0;
}

ASMOperand * Identifier::validateAndReplace(ASMInstructionList & list, BitWidth mode) {
    if (list.hasDefinition(_id)) {
        Numeric & num = list.getNumberForDefinition(_id);
        if (ASMOperand * op = num.validateAndReplace(list, mode)) {
            num.destroy();
            return op;
        }
        return &num;
    } else if (!list.hasLabel(_id)) {
        list.err << "Unknown identifier: " << *this << '\n';
    }
    return 0;
}