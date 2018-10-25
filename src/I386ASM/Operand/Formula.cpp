#include "I386ASM/Operand/Formula.hpp"

#include "I386ASM/ASMInstructionList.hpp"

// public
Formula::Formula(Environment &env, MemoryInfo &mi, FormulaOperation op, Numeric &o1, Numeric &o2):Numeric(env, mi), Object(env, mi), _op(op), _o1(&o1), _o2(&o2) {}
Formula::~Formula() {
    _o1->destroy();
    _o2->destroy();
}

OStream & Formula::operator >>(OStream & stream) {
    return stream << '(' << *_o1 << operations[_op] << *_o2 << ')';
}

int Formula::getValue(ASMInstructionList & list) {
//    list.warn<<"get value "<<*this<<"\n";
    return compute(_o1->getValue(list), _o2->getValue(list));
}

Numeric & Formula::clone() {
    return env().create<Formula, FormulaOperation, Numeric&, Numeric&>(_op, _o1->clone(), _o2->clone());
}

ASMOperand * Formula::validateAndReplace(ASMInstructionList & list, BitWidth mode) {
//    list.warn<<"validate "<<*this<<"\n";
    ASMOperand *o1 = _o1->validateAndReplace(list, mode);
    Numeric *n1 = o1 ? o1->asNumeric() : 0;
    _o1 = n1 ? n1 : _o1;
    ASMOperand *o2 = _o2->validateAndReplace(list, mode);
    Numeric *n2 = o2 ? o2->asNumeric() : 0;
    _o2 = n2 ? n2 : _o2;
    
    Number *num1 = _o1->as<Number>(number);
    Number *num2 = _o2->as<Number>(number);
    if (num1 && num2) {
//        list.warn<<"compute "<<*this<<"\n";
        return &env().create<Number,int>(compute(num1->value(), num2->value()));
    }
    return 0;
}

// protected
int Formula::compute(int v1, int v2) {
    switch (_op) {
        case op_add:
            return v1 + v2;
        case op_sub:
            return v1 - v2;
        case op_mul:
            return v1 * v2;
        case op_div:
            return v1 / v2;
        case op_mod:
            return v1 % v2;
        case op_shr:
            return v1 >> v2;
        case op_shl:
            return v1 << v2;
    }
    return 0; //TODO;
}

// private
const char* Formula::operations[] = { "+", "-", "*", "/", "%", ">>", "<<" };
