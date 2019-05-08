#include "I386ASM/Parser.hpp"

#include "sys/String.hpp"
#include "sys/Digit.hpp"
#include "memory/MemoryInfoHelper.hpp"

#include "I386ASM/Instruction/Align.hpp"
#include "I386ASM/Instruction/Ascii.hpp"
#include "I386ASM/Instruction/Call.hpp"
#include "I386ASM/Instruction/ConditionalJump.hpp"
#include "I386ASM/Instruction/Div.hpp"
#include "I386ASM/Instruction/GroupOneInstruction.hpp"
#include "I386ASM/Instruction/In.hpp"
#include "I386ASM/Instruction/Inline.hpp"
#include "I386ASM/Instruction/Int.hpp"
#include "I386ASM/Instruction/Jump.hpp"
#include "I386ASM/Instruction/Move.hpp"
#include "I386ASM/Instruction/NoOperandInstruction.hpp"
#include "I386ASM/Instruction/Organize.hpp"
#include "I386ASM/Instruction/Out.hpp"
#include "I386ASM/Instruction/Pop.hpp"
#include "I386ASM/Instruction/Push.hpp"

#include "I386ASM/Operand/Formula.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"

/*!stags:re2c format = 'char *@@;'; */
/*!max:re2c*/
#define SIZE 5000

Parser::Parser(Environment &env, MemoryInfo &mi):
    Object(env, mi),
    buffersInfo(env.getAllocator().allocate((SIZE + YYMAXFILL) * (sizeof(char) + sizeof(int) + sizeof(int)))),
    buffer((char*) buffersInfo.buf),
    linesBuffer((int*) memoryEnd(buffersInfo.buf, (SIZE + YYMAXFILL) * sizeof(char))),
    columnsBuffer((int*) memoryEnd(buffersInfo.buf, (SIZE + YYMAXFILL) * (sizeof(char) + sizeof(int)))),
    currentLine(1),
    currentColumn(1) {
}

Parser::~Parser() {
    env().getAllocator().free(buffersInfo);
}

bool Parser::freeBuffer(size_t need) {
    const size_t free = token - buffer;
    const size_t filled = limit - token;
    if (free < need) {
        return false;
    }
    for (int i = 0; i < filled; i++) {
        buffer[i] = buffer[i + free];
        linesBuffer[i] = linesBuffer[i + free];
        columnsBuffer[i] = columnsBuffer[i + free];
    }
    limit -= free;
    current -= free;
    token -= free;
    marker -= free;
    ctxmarker -= free;
    /*!stags:re2c format = "@@ -= free;\n"; */
    return true;
}

bool Parser::fillBuffer(size_t need, IStream & input)
{
    if (input.isEmpty() || !freeBuffer(need)) {
        return false;
    }
    char current;
    while (!input.isEmpty() && (limit < buffer + SIZE)) {
        input >> current;
        linesBuffer[limit - buffer] = currentLine;
        columnsBuffer[limit - buffer] = currentColumn++;
        *limit++ = current;
        if (current == '\n') {
            currentLine++;
            currentColumn = 1;
        }
    }
    if (input.isEmpty()) {
        // clear lookahead after end of stream
        char * maxfill = limit + YYMAXFILL;
        while (limit < maxfill) {
            linesBuffer[limit - buffer] = 0;
            columnsBuffer[limit - buffer] = 0;
            *limit++ = (char) 0;
        }
    }
    return true;
};

// protected
/*!re2c
        re2c:flags:T = 1;
        re2c:define:YYCTYPE = char;
        re2c:yyfill:enable = 0;

        end         = "\x00";
        eol         = "\r"? "\n" | "\r";
        wsp         = [ \t]*;
        comma       = ",";
        semicolon   = ";";
        colon       = ":";
        assign      = ":=";

        bin         = "0"[bB][01]+;
        oct         = "0"[0-7]+;
        dec         = "0" | [1-9][0-9]*; 
        hex         = "0"[xX][0-9a-fA-F]+;
        number      = "-"? (bin | oct | dec | hex);
        
        bitwidth    = [bBwWlL];
        condition   = [nN]?(([aA]|[bB]|[gG|[lL])[eE]?|[cC]|[eE]|[oO]|[pP]|[sS]|[zZ]) | [pP]([oO]|[eE]);
        register    = "%" [a-zA-Z][a-zA-Z0-9]+;
        id          = [a-zA-Z_][a-zA-Z0-9_]+;
        formula1    = "(" wsp (id|number) wsp ("+"|"-"|"*"|"/"|"%"|">>"|"<<") wsp (id|number) wsp ")";
        formula     = "(" wsp (id|number|formula1) wsp ("+"|"-"|"*"|"/"|"%"|">>"|"<<") wsp (id|number|formula1) wsp ")";
        numeric     = id | number | formula;
        id_num      = id | number;
*/

String & Parser::parseStringValue(char * start, char * end) {
    return env().create<String, char*, char*>(start, end);
}

int Parser::parseIntegerValue(char * start, char * end, int base) {
    int result = 0;
    Digit d(env());
    while (start < end) {
        d = *start++;
        result *= base;
        result += (int) d;
    }
    return result;
}

Number * Parser::parseNumber(char * start, char * end) {
    char *o1, *o2, *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;

        "0" [bB] @o1 [01]+ @o2          { if (cur != end) break; return &env().create<Number, int>( parseIntegerValue(o1, o2,  2)); }
        "-0" [bB] @o1 [01]+ @o2         { if (cur != end) break; return &env().create<Number, int>(-parseIntegerValue(o1, o2,  2)); }
        "0" @o1 [0-7]+ @o2              { if (cur != end) break; return &env().create<Number, int>( parseIntegerValue(o1, o2,  8)); }
        "-0" @o1 [0-7]+ @o2             { if (cur != end) break; return &env().create<Number, int>(-parseIntegerValue(o1, o2,  8)); }
        @o1 [1-9][0-9]* @o2             { if (cur != end) break; return &env().create<Number, int>( parseIntegerValue(o1, o2, 10)); } 
        "-" @o1 [1-9][0-9]* @o2         { if (cur != end) break; return &env().create<Number, int>(-parseIntegerValue(o1, o2, 10)); } 
        "0"[xX] @o1 [0-9a-fA-F]+ @o2    { if (cur != end) break; return &env().create<Number, int>( parseIntegerValue(o1, o2, 16)); }
        "-0"[xX] @o1 [0-9a-fA-F]+ @o2   { if (cur != end) break; return &env().create<Number, int>(-parseIntegerValue(o1, o2, 16)); }

        * { break; }
*/
    }
    return &env().create<Number, int>(0); 
}

InstructionCondition Parser::parseInstructionCondition(char * start, char * end) {
    char *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;

        [aA]          { if (cur != end) break; return cond_above; }
        [aA][eE]      { if (cur != end) break; return cond_above_or_equal; }
        [bB]          { if (cur != end) break; return cond_below; }
        [bB][eE]      { if (cur != end) break; return cond_below_or_equal; }
        [cC]          { if (cur != end) break; return cond_carry; }
        [eE]          { if (cur != end) break; return cond_equal; }
        [gG]          { if (cur != end) break; return cond_greater; }
        [gG][eE]      { if (cur != end) break; return cond_greater_or_equal; }
        [lL]          { if (cur != end) break; return cond_lesser; }
        [lL][eE]      { if (cur != end) break; return cond_lesser_or_equal; }
        [oO]          { if (cur != end) break; return cond_overflow; }
        [pP]          { if (cur != end) break; return cond_parity; }
        [sS]          { if (cur != end) break; return cond_sign; }
        [zZ]          { if (cur != end) break; return cond_zero; }
 
        [nN][aA]      { if (cur != end) break; return cond_not_above; }
        [nN][aA][eE]  { if (cur != end) break; return cond_not_above_or_equal; }
        [nN][bB]      { if (cur != end) break; return cond_not_below; }
        [nN][bB][eE]  { if (cur != end) break; return cond_not_below_or_equal; }
        [nN][cC]      { if (cur != end) break; return cond_not_carry; }
        [nN][eE]      { if (cur != end) break; return cond_not_equal; }
        [nN][gG]      { if (cur != end) break; return cond_not_greater; }
        [nN][gG][eE]  { if (cur != end) break; return cond_not_greater_or_equal; }
        [nN][lL]      { if (cur != end) break; return cond_not_lesser; }
        [nN][lL][eE]  { if (cur != end) break; return cond_not_lesser_or_equal; }
        [nN][oO]      { if (cur != end) break; return cond_not_overflow; }
        [nN][pP]      { if (cur != end) break; return cond_not_parity; }
        [nN][sS]      { if (cur != end) break; return cond_not_sign; }
        [nN][zZ]      { if (cur != end) break; return cond_not_zero; }
 
        [pP][eE]      { if (cur != end) break; return cond_parity_even; }
        [pP][oO]      { if (cur != end) break; return cond_parity_odd; }

        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    list->err << "unknown condition '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return cond_above;
}

Register * Parser::parseRegister(char * start, char * end) {
    char *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;

        "%"[aA][hH]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ah); }
        "%"[bB][hH]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_bh); }
        "%"[cC][hH]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ch); }
        "%"[dD][hH]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_dh); }
        "%"[aA][lL]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_al); }
        "%"[bB][lL]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_bl); }
        "%"[cC][lL]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_cl); }
        "%"[dD][lL]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_dl); }
        
        "%"[aA][xX]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ax); }
        "%"[bB][xX]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_bx); }
        "%"[cC][xX]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_cx); }
        "%"[dD][xX]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_dx); }
        "%"[dD][iI]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_di); }
        "%"[sS][iI]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_si); }
        "%"[bB][pP]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_bp); }
        "%"[sS][pP]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_sp); }
        
        "%"[eE][aA][xX]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_eax); }
        "%"[eE][bB][xX]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ebx); }
        "%"[eE][cC][xX]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ecx); }
        "%"[eE][dD][xX]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_edx); }
        "%"[eE][dD][iI]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_edi); }
        "%"[eE][sS][iI]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_esi); }
        "%"[eE][bB][pP]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ebp); }
        "%"[eE][sS][pP]      { if (cur != end) break; return &env().create<Register, RegisterName>(reg_esp); }
        
        "%"[cC][sS]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_cs); }
        "%"[dD][sS]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ds); }
        "%"[eE][sS]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_es); }
        "%"[fF][sS]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_fs); }
        "%"[gG][sS]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_gs); }
        "%"[sS][sS]          { if (cur != end) break; return &env().create<Register, RegisterName>(reg_ss); }

        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    list->err << "unknown register '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

Identifier * Parser::parseIdentifier(char * start, char * end) {
    return &env().create<Identifier, String&>(parseStringValue(start, end));
}

Formula * Parser::parseFormula(char * start, char * end) {
    char *o1, *o2, *o3, *o4, *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;

        "(" wsp @o1 numeric @o2 wsp "+" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_add, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }
        "(" wsp @o1 numeric @o2 wsp "-" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_sub, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }
        "(" wsp @o1 numeric @o2 wsp "*" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_mul, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }
        "(" wsp @o1 numeric @o2 wsp "/" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_div, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }
        "(" wsp @o1 numeric @o2 wsp "%" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_mod, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }
        "(" wsp @o1 numeric @o2 wsp ">>" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_shr, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }
        "(" wsp @o1 numeric @o2 wsp "<<" wsp @o3 numeric @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Formula, FormulaOperation, Numeric&, Numeric&>(op_shl, *parseNumericOperand(o1, o2), *parseNumericOperand(o3, o4));
        }

        * { break; }
*/
    }
    String s(env(), *notAnInfo, start, end);
    list->err << "unknown formula '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

BitWidth Parser::parseOperandSize(char * start, char * end, BitWidth defaultWidth) {
    if (end - start != 1) {
        return defaultWidth;
    }
    switch (*start) {
        case 'l':
        case 'L':
        case 'd':
        case 'D':
            return bit_32;
        case 'w':
        case 'W':
            return bit_16;
        case 'b':
        case 'B':
            return bit_8;
        default:
            return defaultWidth;
    }
}

ASMOperand * Parser::parseOperand(char * start, char * end) {
    char *o1, *o2, *o3, *o4, *o5, *o6, *o7, *o8, *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;
        
        @o1 register @o2    { if (cur != end) break; return parseRegister(o1, o2); }
        @o1 number @o2      { if (cur != end) break; return parseNumber(o1, o2); }
        @o1 id @o2          { if (cur != end) break; return parseIdentifier(o1, o2); }
        @o1 formula @o2     { if (cur != end) break; return parseFormula(o1, o2); }
        
        @o1 id_num @o2 wsp "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *, int>(
                parseRegister(o3, o4),
                parseNumericOperand(o1, o2),
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        @o1 id_num @o2 wsp "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *>(
                parseRegister(o3, o4),
                parseNumericOperand(o1, o2),
                parseRegister(o5, o6)
            );
        }
        @o1 id_num @o2 wsp "(" wsp @o3 register @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *>(
                parseRegister(o3, o4),
                parseNumericOperand(o1, o2)
            );
        }
        "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *, int>(
                parseRegister(o3, o4),
                0,
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *>(
                parseRegister(o3, o4),
                0,
                parseRegister(o5, o6)
            );
        }
        "(" wsp @o3 register @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *>(
                parseRegister(o3, o4)
            );
        }
        @o1 id_num @o2 wsp "(" wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *, int>(
                0,
                parseNumericOperand(o1, o2),
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        "(" wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *, int>(
                0,
                0,
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        @o1 id_num @o2 wsp "(" wsp comma wsp @o5 register @o6 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *, Register *>(
                0,
                parseNumericOperand(o1, o2),
                parseRegister(o5, o6)
            );
        }
        "(" wsp @o1 id_num @o2 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Numeric *>(
                0,
                parseNumericOperand(o1, o2)
            );
        }

        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    list->err << "unknown operand '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

Numeric * Parser::parseNumericOperand(char * start, char * end) {
    char *o1, *o2, *o3, *o4, *o5, *o6, *o7, *o8, *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;
        
        @o1 number @o2      { if (cur != end) break; return parseNumber(o1, o2); }
        @o1 id @o2          { if (cur != end) break; return parseIdentifier(o1, o2); }
        @o1 formula @o2     { if (cur != end) break; return parseFormula(o1, o2); }
        
        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    list->err << "unknown numeric operand '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

ASMInstruction * Parser::parseInstruction(char * start, char * end, char * operandsEnd, ASMOperand *op1, ASMOperand *op2, ASMOperand *op3) {
    char *o1, *o2, *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;

        [mM][oO][vV] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<Move, ASMOperand*, ASMOperand*, BitWidth> (op1, op2, parseOperandSize(o1, o2));
        }
        [aA][dD][dD] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("add", 0, op1, op2, parseOperandSize(o1, o2));
        }
        [oO][rR] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("or", 1, op1, op2, parseOperandSize(o1, o2));
        }
        [aA][dD][cC] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("adc", 2, op1, op2, parseOperandSize(o1, o2));
        }
        [sS][bB][bB] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("sbb", 3, op1, op2, parseOperandSize(o1, o2));
        }
        [aA][nN][dD] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("and", 4, op1, op2, parseOperandSize(o1, o2));
        }
        [sS][uU][bB] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("sub", 5, op1, op2, parseOperandSize(o1, o2));
        }
        [xX][oO][rR] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("xor", 6, op1, op2, parseOperandSize(o1, o2));
        }
        [cC][mM][pP] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<GroupOneInstruction, const char *, int, ASMOperand*, ASMOperand*, BitWidth> 
                ("cmp", 7, op1, op2, parseOperandSize(o1, o2));
        }
        [dD][iI][vV] @o1 bitwidth? @o2 {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Div, ASMOperand*, BitWidth> (op1, parseOperandSize(o1, o2));
        }
        [iI]?[mM][uU][lL] @o1 bitwidth? @o2 {
            String s(env(), *notAnInfo, start, operandsEnd);
            list->err << "not yet supported instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
            return 0;
        }
        [iI][nN] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<In, ASMOperand*, ASMOperand*, BitWidth> (op1, op2, parseOperandSize(o1, o2));
        }
        [oO][uU][tT] @o1 bitwidth? @o2 {
            if (!op1 || !op2 || op3) return 0;
            return &env().create<Out, ASMOperand*, ASMOperand*, BitWidth> (op1, op2, parseOperandSize(o1, o2));
        }
        [pP][uU][sS][hH] @o1 [wWlL]? @o2 {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Push, ASMOperand*, BitWidth> (op1, parseOperandSize(o1, o2));
        }
        [pP][oO][pP] @o1 [wWlL]? @o2 {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Pop, ASMOperand*, BitWidth> (op1, parseOperandSize(o1, o2));
        }
        [pP][uU][sS][hH][aA] @o1 [wWlLdD]? @o2 {
            return &env().create<NoOperandInstruction, const char *, char, char, char, BitWidth>("pusha", 0x60, 0, 0, parseOperandSize(o1, o2, bit_16));
        }
        [pP][oO][pP][aA] @o1 [wWlLdD]? @o2 {
            return &env().create<NoOperandInstruction, const char *, char, char, char, BitWidth>("popa", 0x61, 0, 0, parseOperandSize(o1, o2, bit_16));
        }
        [pP][uU][sS][hH][fF] @o1 [wWlLdD]? @o2 {
            return &env().create<NoOperandInstruction, const char *, char, char, char, BitWidth>("pushf", 0x9C, 0, 0, parseOperandSize(o1, o2, bit_16));
        }
        [pP][oO][pP][fF] @o1 [wWlLdD]? @o2 {
            return &env().create<NoOperandInstruction, const char *, char, char, char, BitWidth>("popf", 0x9D, 0, 0, parseOperandSize(o1, o2, bit_16));
        }
        [lL][oO][dD][sS][bB] {
            return &env().create<NoOperandInstruction, const char *, char, char, char, BitWidth>("lods", 0xAC, 0, 0, bit_8);
        }
        [lL][oO][dD][sS] @o1 [wWlLdD]? @o2 {
            return &env().create<NoOperandInstruction, const char *, char, char, char, BitWidth>("lods", 0xAD, 0, 0, parseOperandSize(o1, o2));
        }
        [cC][lL][cC] {
            return &env().create<NoOperandInstruction, const char *, char>("clc", 0xF8);
        }
        [cC][lL][dD] {
            return &env().create<NoOperandInstruction, const char *, char>("cld", 0xFC);
        }
        [cC][lL][iI] {
            return &env().create<NoOperandInstruction, const char *, char>("cli", 0xFA);
        }
        [cC][lL][tT][sS] {
            return &env().create<NoOperandInstruction, const char *, char>("clts", 0x0F, 0x06);
        }
        [sS][tT][cC] {
            return &env().create<NoOperandInstruction, const char *, char>("stc", 0xF9);
        }
        [sS][tT][dD] {
            return &env().create<NoOperandInstruction, const char *, char>("std", 0xFD);
        }
        [sS][tT][iI] {
            return &env().create<NoOperandInstruction, const char *, char>("sti", 0xFB);
        }
        [hH][lL][tT] {
            return &env().create<NoOperandInstruction, const char *, char>("hlt", 0xF4);
        }
        [nN][oO][pP] {
            return &env().create<NoOperandInstruction, const char *, char>("nop", 0x90);
        }
        [iI][nN][tT] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Int, ASMOperand*> (op1);
        }
        [iI][nN][tT]"0" {
            return &env().create<NoOperandInstruction, const char *, char>("int0", 0xCE);
        }
        [iI][nN][tT]"1" {
            return &env().create<NoOperandInstruction, const char *, char>("int1", 0xF1);
        }
        [iI][nN][tT]"3" {
            return &env().create<NoOperandInstruction, const char *, char>("int3", 0xCC);
        }
        [jJ][mM][pP] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Jump, ASMOperand*>(op1);
        }
        [cC][aA][lL][lL] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Call, ASMOperand*>(op1);
        }
        [lL][eE][aA][vV][eE] {
            if (op1 || op2 || op3) return 0;
            return &env().create<NoOperandInstruction, const char *, char>("leave", 0xC9);
        }
        [rR][eE][tT] {
            if (op1 || op2 || op3) return 0;
            return &env().create<NoOperandInstruction, const char *, char>("ret", 0xC3);
        }
        [iI][rR][eE][tT] {
            if (op1 || op2 || op3) return 0;
            return &env().create<NoOperandInstruction, const char *, char>("iret", 0xCF);
        }
        [jJ] @o1 condition @o2 {
            if (!op1 || op2 || op3) return 0;
            return &env().create<ConditionalJump, InstructionCondition, ASMOperand*>(parseInstructionCondition(o1, o2), op1);
        }
        [jJ][cC][xX][zZ] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<ConditionalJump, InstructionCondition, ASMOperand*>(cond_reg_cx, op1);
        }
        [jJ][eE][cC][xX][zZ] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<ConditionalJump, InstructionCondition, ASMOperand*>(cond_reg_ecx, op1);
        }

        "."[bB][yY][tT][eE] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Inline, ASMOperand*, BitWidth>(op1, bit_8);
        }
        "."[wW][oO][rR][dD] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Inline, ASMOperand*, BitWidth>(op1, bit_16);
        }
        "."[lL][oO][nN][gG] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Inline, ASMOperand*, BitWidth>(op1, bit_32);
        }
        "."[oO][rR][gG] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Organize, ASMOperand*>(op1);
        }
        "."[aA][lL][iI][gG][nN] {
            if (!op1 || op2 || op3) return 0;
            return &env().create<Align, ASMOperand*>(op1);
        }

        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, operandsEnd);
    list->err << "unknown instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

String * Parser::parseString(IStream & input, char enclosure) {
    String &s = env().create<String>();
    int startLine = linesBuffer[current-buffer];
    int startColumn = columnsBuffer[current-buffer];
    for (;;) {
        char * tok = current;
/*!re2c
        re2c:define:YYCURSOR = current;
        re2c:define:YYMARKER = marker;
        re2c:define:YYCTXMARKER = ctxmarker;
        re2c:define:YYLIMIT = limit;
        re2c:yyfill:enable = 1;
        re2c:define:YYFILL = "if (fillBuffer(@@, input)) tok = current; else break;";
        re2c:define:YYFILL:naked = 1;
        
        *                    { break; }
        [^\n\\]              { if (enclosure == *tok) { return &s; }; s << *tok; continue; }
        "\\n"                { s << '\n'; continue; }
        "\\r"                { s << '\r'; continue; }
        "\\t"                { s << '\t'; continue; }
        "\\\\"               { s << '\\'; continue; }
        "\\'"                { s << '\''; continue; }
        "\\\""               { s << '"';  continue; }
*/
    }
    list->err << "unterminated string '" << s << "' at line: " << startLine << " column: "  << startColumn << '\n';
    s.destroy();
    return 0;
}

// public
ASMInstructionList & Parser::parse(IStream & input, OStream & error, int line, int column, bool silent) {
    list = &env().create<ASMInstructionList, OStream&, bool>(error, silent);
    
    // reset parsing buffer
    token = current = marker = ctxmarker = limit = buffer + SIZE;
    currentLine = line;
    currentColumn = column;
    
    char *o1, *o2, *o3, *o4, *o5, *o6, *o7, *o8;
    for (;;) {
        BitWidth data = bit_auto, addr = bit_auto;
        bool global = false;
detect_instruction:
        token = current;
/*!re2c
        re2c:define:YYCURSOR = current;
        re2c:define:YYMARKER = marker;
        re2c:define:YYCTXMARKER = ctxmarker;
        re2c:define:YYLIMIT = limit;
        re2c:yyfill:enable = 1;
        re2c:define:YYFILL = "if (fillBuffer(@@, input)) token = current; else break;";
        re2c:define:YYFILL:naked = 1;
        
        inst        = id | "."[bB][yY][tT][eE] | "."[wW][oO][rR][dD] | "."[lL][oO][nN][gG] | "."[oO][rR][gG] | "."[aA][lL][iI][gG][nN];
        operand     = register | id | number | formula
                        | "(" wsp (number | id ) wsp ")"
                        | ((number | id) wsp)? "(" (wsp register)? ( wsp comma wsp register ( wsp comma wsp (id | number) )? )? wsp ")"
                    ;
        eoinst      = semicolon | eol | end | "//" | "#" | "/*";

        end       { break; }
        eol       { continue; }
        wsp       { continue; }
        semicolon { continue; }
        ( "//" | "#" ) @o1 [^\n]* @o2 eol { continue; }
        "/*" @o1 ([^*] | ("*" [^/]))* @o2 "*""/" { continue; }

        "."[cC][oO][dD][eE]"16" wsp / eoinst { list->setMode(bit_16); continue; }
        "."[cC][oO][dD][eE]"32" wsp / eoinst { list->setMode(bit_32); continue; }
        "."[dD][aA][tT][aA]"16" wsp { data = bit_16; goto detect_instruction; }
        "."[dD][aA][tT][aA]"32" wsp { data = bit_32; goto detect_instruction; }
        "."[aA][dD][dD][rR]"16" wsp { addr = bit_16; goto detect_instruction; }
        "."[aA][dD][dD][rR]"32" wsp { addr = bit_32; goto detect_instruction; }
        "."[gG][lL][oO][bB][aA][lL] wsp { global = true; goto detect_instruction; }
        
        "."[aA][sS][cC][iI] @o1 [iIzZ] wsp @o2 ['"] {
                    String *s = parseString(input, *o2);
                    if (!s) break;
                    list->addInstruction(env().create<Ascii, String&, bool>(*s, (*o1 == 'z' || *o1 == 'Z')), data, addr);
                    continue;
                  }
 
        @o1 id @o2 wsp colon {
                    list->addLabel(parseStringValue(o1, o2));
                    continue;
                  }
        @o1 id @o2 wsp assign wsp @o3 numeric @o4 wsp / eoinst {
                    list->addDefinition(parseStringValue(o1, o2), *parseNumericOperand(o3, o4), global);
                    continue;
                  }
        @o1 inst @o2 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o2);
                    if (inst) {
                        list->addInstruction(*inst, data, addr);
                    }
                    continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o4, parseOperand(o3, o4));
                    if (inst) {
                        list->addInstruction(*inst, data, addr);
                    }
                    continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp comma wsp @o5 operand @o6 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o6, parseOperand(o3, o4), parseOperand(o5, o6));
                    if (inst) {
                        list->addInstruction(*inst, data, addr);
                    }
                    continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp comma wsp @o5 operand @o6 wsp comma wsp @o7 operand @o8 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o8, parseOperand(o3, o4), parseOperand(o5, o6), parseOperand(o7, o8));
                    if (inst) {
                        list->addInstruction(*inst, data, addr);
                    }
                    continue;
                  }
        *         { 
                    list->err << "unexpected character : " << *token << " line: " << linesBuffer[token-buffer] << " column: "  << columnsBuffer[token-buffer] << '\n';
                    break;
                  }
*/
    }
    return *list;
}
