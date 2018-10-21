#include "I386ASM/Instruction/ConditionalJump.hpp"

// protected
size_t ConditionalJump::approximateSizeInBytes() {
    if (condition == cond_reg_cx || condition == cond_reg_ecx) {
        return 7; // opcode + 2*prefix + offset
    }
    return 6; // opcode + prefix + offset
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
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    
    if (condition == cond_reg_cx || condition == cond_reg_ecx) {
        if (n1) {
            list->err<<"Only label based addressing allowed in: " << *this << '\n';
        }
        if (id1 && (approximateOffsetWidth(id1) != bit_8)) {
            list->err<<"Only byte offset allowed in: " << *this << '\n';
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
    Identifier *id1 = o1->as<Identifier>(identifier);
    Number *n1 = o1->as<Number>(number);
    if (id1 || n1) {
        size_t size = 1;
        // Offset of explicit address cannot be determined before final positioning in ASMInstructionList::finalize
        BitWidth offsetWidth = id1 ? approximateOffsetWidth(id1) : bit_32; 
        if (requiresAddressSizeOverride(offsetWidth)) {
            pre3 = 0x66; size++;
        }
        if (offsetWidth == bit_8) {
            if (condition == cond_reg_cx || condition == cond_reg_ecx) {
                if (requiresAddressSizeOverride((condition == cond_reg_cx) ? bit_16 : bit_32)) {
                    pre4 = 0x67; size++;
                }
                op1 = 0xE3;
            } else {
                op1 = 0x70 + instruction_condition_encoding[condition];
            } 
        } else {
            op1 = 0x0F; size++;
            op2 = 0x80 + instruction_condition_encoding[condition];
        }
        immSize = (int) offsetWidth;
        return size + immSize;
    }
    return -1;
}

void ConditionalJump::writeOperandsToStream(OStream & stream) {
    if (immSize) {
        writeOffsetToStream(stream, o1);
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
