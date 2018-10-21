#include "I386ASM/ASMInstruction.hpp"

// public
OStream & ASMInstruction::operator >>(OStream & stream) {
    stream << mnemonic;
    switch (operandSize) {
        case bit_8: stream << 'b'; break;
        case bit_16: stream << 'w'; break;
        case bit_32: stream << 'l'; break;
    }
    if (o1) {
        stream << ' ' << *o1;
    }
    if (o2) {
        stream << ", " << *o2;
    }
    if (o3) {
        stream << ", " << *o3;
    }
    return stream;
}

void ASMInstruction::writeToStream(OStream & stream) {
    if (pre1) { stream << pre1; }
    if (pre2) { stream << pre2; }
    if (pre3) { stream << pre3; }
    if (pre4) { stream << pre4; }
    stream << op1;
    if (op1 == 0x0F) {
        stream << op2;
        if (op2 == 0x38 || op2 == 0x3A) {
            stream << op3;
        }
    }
    writeOperandsToStream(stream);
}

// protected
size_t ASMInstruction::approximateSizeInBytes() {
    // 4xpre 3xop 1xmodrm 1xsib 4xdisp 4ximm
    return 17;
}

void ASMInstruction::checkOperands() {}

void ASMInstruction::sanitizeOperands() {
    if (ASMOperand * replacement = o1 ? o1->validateAndReplace(*list, ctx->addr) : 0) {
        o1->destroy();
        o1 = replacement;
    }
    if (ASMOperand * replacement = o2 ? o2->validateAndReplace(*list, ctx->addr) : 0) {
        o2->destroy();
        o2 = replacement;
    }
    if (ASMOperand * replacement = o3 ? o3->validateAndReplace(*list, ctx->addr) : 0) {
        o3->destroy();
        o3 = replacement;
    }
}

void ASMInstruction::validateOperands() {}

size_t ASMInstruction::prepare() {
    checkOperands();
    if (list->hasErrors()) return 0;
    
    sanitizeOperands();
    if (list->hasErrors()) return 0;
    
    return approximateSizeInBytes();
}

size_t ASMInstruction::compile() {
    validateOperands();
    if (list->hasErrors()) return 0;
    
    size = compileOperands();
    if (size < 0) {
        list->err<<"invalid opcode size determined for \""<<*this<<"\"\n";
        size = 0;
    }
    return size;
}

void ASMInstruction::writeNumberToStream(OStream &stream, int val, int size) {
    switch (size) {
        case 1: stream << (char)val; break;
        case 2: stream << (char)val << (char)(val>>8); break;
        case 4: stream << (char)val << (char)(val>>8) << (char)(val>>16) << (char)(val>>24); break;
    }
}

void ASMInstruction::writeOffsetToStream(OStream &stream, ASMOperand *o) {
    if (Identifier *id = o->as<Identifier>(identifier)) {
        writeNumberToStream(stream, list->getLabel(*id) - (ctx->pos + size), immSize);
    } else if (Number *num = o->as<Number>(number)) {
        writeNumberToStream(stream, num->value() - (ctx->pos + size), immSize);
    } else {
        list->err<<"invalid offset operand \""<<*o<<"\"\n";
    }
}

void ASMInstruction::writeImmediateToStream(OStream &stream, ASMOperand *o) {
    if (Identifier *id = o->as<Identifier>(identifier)) {
        writeNumberToStream(stream, list->getLabel(*id), immSize);
    } else if (Number *num = o->as<Number>(number)) {
        writeNumberToStream(stream, num->value(), immSize);
    } else {
        list->err<<"invalid immediate operand \""<<*o<<"\"\n";
    }
}

void ASMInstruction::writeModRMToStream(OStream &stream, int regO, int regM) {
    if (modrmSize) {
        stream << ModRM(3, regO, regM);
    }
}

void ASMInstruction::writeIndirectToStream(OStream &stream, Indirect * i, int reg) {
    if (modrmSize) {
        stream << i->getModRM(reg);
    }
    if (sibSize) {
        stream << i->getSib();
    }
    if (dispSize) {
        writeNumberToStream(stream, i->getDispValue(*list), dispSize);
    }
}

BitWidth ASMInstruction::getBitWidth(int value) {
    if (-128 <= value && value <= 127) {
        return bit_8;
    }
    if (-32768 <= value && value <= 32767) {
        return bit_16;
    }
    return bit_32;
}

BitWidth ASMInstruction::getUnsignedBitWidth(unsigned int value) {
    if (value <= 255) {
        return bit_8;
    }
    if (value <= 65535) {
        return bit_16;
    }
    return bit_32;
}

BitWidth ASMInstruction::approximateOffsetWidth(Identifier *id) {
    return getBitWidth(ctx->approximateOffset(list->getLabel(*id)));
}
