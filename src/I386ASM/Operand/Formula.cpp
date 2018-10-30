#include "I386ASM/Operand/Formula.hpp"

#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/Operand/Number.hpp"

// public
Formula::Formula(Environment &env, MemoryInfo &mi, FormulaOperation op, Numeric &o1, Numeric &o2):Numeric(env, mi), Object(env, mi), _op(op), _o1(&o1), _o2(&o2) {}
Formula::~Formula() {
    _o1->destroy();
    _o2->destroy();
}

OStream & Formula::operator >>(OStream & stream) {
    return stream << '(' << *_o1 << getOperation(_op) << *_o2 << ')';
}

bool Formula::isConstant(ASMInstructionList & list) {
    return _o1->isConstant(list) && _o2->isConstant(list);
}

int Formula::getValue(ASMInstructionList & list) {
    return compute(_o1->getValue(list), _o2->getValue(list));
}

Numeric & Formula::clone() {
    return env().create<Formula, FormulaOperation, Numeric&, Numeric&>(_op, _o1->clone(), _o2->clone());
}

Numeric * Formula::validateAndReplace(ASMInstructionList & list, BitWidth mode) {
    if (Numeric *n1 = _o1->validateAndReplace(list, mode)) {
        _o1->destroy();
        _o1 = n1;
    }
    if (Numeric *n2 = _o2->validateAndReplace(list, mode)) {
        _o2->destroy();
        _o2 = n2;
    }
    
    if (isConstant(list)) {
        return &env().create<Number,int>(getValue(list));
    }
    return 0;
}

// protected
int Formula::compute(int v1, int v2) {
    switch (_op) {
        case op_add: return v1 + v2;
        case op_sub: return v1 - v2;
        case op_mul: return v1 * v2;
        case op_div: return v1 / v2;
        case op_mod: return v1 % v2;
        case op_shr: return v1 >> v2;
        case op_shl: return v1 << v2;
    }
    return 0;
}

// private
const char* Formula::getOperation(FormulaOperation op) {
    switch (_op) {
        case op_add: return "+";
        case op_sub: return "-";
        case op_mul: return "*";
        case op_div: return "/";
        case op_mod: return "%";
        case op_shr: return ">>";
        case op_shl: return "<<";
    }
    return "?";
}
