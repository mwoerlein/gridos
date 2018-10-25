#include "I386ASM/Operand/Number.hpp"

#include "I386ASM/ASMInstructionList.hpp"

// public
Number::Number(Environment &env, MemoryInfo &mi, int number):Numeric(env, mi), Object(env, mi), _number(number) {}
Number::~Number() {}

int Number::value() {
    return _number;
}

int Number::getValue(ASMInstructionList & list) {
    return _number;
}

Numeric & Number::clone() {
    return env().create<Number, int>(_number);
}

OStream & Number::operator >>(OStream & stream) {
    return stream.printuhex(_number);
}
