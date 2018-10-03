#include "I386ASM/Instruction/ConditionalJump.hpp"

#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"

// protected
size_t ConditionalJump::approximateSizeInBytes() {
    return 6; // all over maximum
}

void ConditionalJump::checkOperands() {
    if (!o1) {
        list->err<<"Missing operand!\n";
    }
    if (o2) {
        list->err<<"Unexpected operand: " << *o2 << '\n';
    }
    if (o3) {
        list->err<<"Unexpected operand: " << *o3 << '\n';
    }
    if (operandSize != bit_auto) {
        list->err<<"Invalid operand size!\n";
    }
}

void ConditionalJump::validateOperands() {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    
    if (condition == cond_reg_cx || condition == cond_reg_ecx) {
        if (n1) {
            list->err<<"Only label based addressing allowed in: " << *this << '\n';
        }
        if (id1) {
            int offset = pos - list->getLabel(id1->identifier());
            if (offset < -128 || 127 < offset) {
                list->err<<"Only byte offset allowed in: " << *this << '\n';
            }
        }
        return;
    }
    
    if (id1 || n1) {
        return;
    }
    list->err<<"Invalid operand: " << *o1 << '\n';
    return;
}

size_t ConditionalJump::compileOperands() {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    if (id1) {
        size_t size = 1;
        int offset = pos - list->getLabel(id1->identifier());
        if (-128 <= offset && offset <= 127) {
            if (condition == cond_reg_cx) {
                pre4 = 0x67;
                size++;
                op1 = 0xE3;
            } else if (condition == cond_reg_ecx) {
                op1 = 0xE3;
            } else {
                op1 = 0x70 + instruction_condition_encoding[condition];
            } 
            immSize = (int) bit_8;
        } else if (-32768 <= offset && offset <= 32767) {
            pre3 = 0x66;
            size++;
            op1 = 0x0F;
            size++;
            op2 = 0x80 + instruction_condition_encoding[condition];
            immSize = (int) bit_16;
        } else {
            op1 = 0x0F;
            size++;
            op2 = 0x80 + instruction_condition_encoding[condition];
            immSize = (int) bit_32;
        }
        return size + immSize;
    }
    if (n1) {
        // Offset of explicit address cannot be determined before final positioning in ASMInstructionList::finalize
        op1 = 0x0F;
        op2 = 0x80 + instruction_condition_encoding[condition];
        immSize = (int) bit_32;
        return 2 + immSize;
    }
        
    return 0;
}

void ConditionalJump::writeOperandsToStream(OStream & stream) {
    Identifier *id1 = o1->as<Identifier>(id);
    Number *n1 = o1->as<Number>(number);
    if (n1 || id1) {
        // Reached only for labels. Definitions will be rewritten to numbers before.
        int val = n1 ? n1->value() : list->getLabel(id1->identifier());
        writeNumberToStream(stream, val - (pos + size), immSize);
    }
}

// private
const char* ConditionalJump::mnemonics[] = {
    "ja", //cond_above
    "jae", //cond_above_or_equal
    "jb", //cond_below
    "jbe", //cond_below_or_equal
    "jc", //cond_carry
    "je", //cond_equal
    "jg", //cond_greater
    "jge", //cond_greater_or_equal
    "jl", //cond_lesser
    "jle", //cond_lesser_or_equal
    "jo", //cond_overflow
    "jp", //cond_parity
    "js", //cond_sign
    "jz", //cond_zero

    "jna", //cond_not_above
    "jnae", //cond_not_above_or_equal
    "jnb", //cond_not_below
    "jnbe", //cond_not_below_or_equal
    "jnc", //cond_not_carry
    "jne", //cond_not_equal
    "jng", //cond_not_greater
    "jnge", //cond_not_greater_or_equal
    "jnl", //cond_not_lesser
    "jnle", //cond_not_lesser_or_equal
    "jno", //cond_not_overflow
    "jnp", //cond_not_parity
    "jns", //cond_not_sign
    "jnz", //cond_not_zero

    "jpe", //cond_parity_even
    "jpo", //cond_parity_odd
    
    "jcxz",
    "jecxz",
};

