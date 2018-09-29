#include "I386ASM/Parser.hpp"

#include "sys/String.hpp"
#include "sys/Digit.hpp"
#include "memory/MemoryInfoHelper.hpp"

#include "I386ASM/Instruction/Halt.hpp"
#include "I386ASM/Instruction/Jump.hpp"
#include "I386ASM/Instruction/Move.hpp"
#include "I386ASM/Instruction/Add.hpp"

#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Register.hpp"
#include "I386ASM/Operand/Indirect.hpp"
#include "I386ASM/Operand/Identifier.hpp"

/*!max:re2c*/
#define SIZE 500

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
/*!stags:re2c format = 'char *@@;'; */
/*!re2c
        re2c:flags:T = 1;
        re2c:define:YYCTYPE = char;
        re2c:yyfill:enable = 0;

        end         = "\x00";
        eol         = "\r"? "\n" | "\r";
        wsp         = [ \t]*;

        bin         = "0"[bB][01]+;
        oct         = "0"[0-7]+;
        dec         = "0" | [1-9][0-9]*; 
        hex         = "0"[xX][0-9a-fA-F]+;
        number      = "-"? (bin | oct | dec | hex);

        register    = "%" [a-zA-Z][a-zA-Z0-9]+;
        
        id          = [a-zA-Z_][a-zA-Z0-9_]+;
        comma       = ",";
        semicolon   = ";";
        colon       = ":";
        assign      = ":=";
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
    env().err() << "unknown register '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

Identifier * Parser::parseIdentifier(char * start, char * end) {
    return &env().create<Identifier, String&>(parseStringValue(start, end));
}

BitWidth Parser::parseOperandSize(char * start, char * end) {
    if (end - start != 1) {
        return bit_auto;
    }
    switch (*start) {
        case 'l':
        case 'L':
            return bit_32;
        case 'w':
        case 'W':
            return bit_16;
        case 'b':
        case 'B':
            return bit_8;
        default:
            return bit_auto;
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
        
        @o1 number @o2 wsp "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *, int>(
                parseRegister(o3, o4),
                parseNumber(o1, o2),
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        @o1 number @o2 wsp "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *>(
                parseRegister(o3, o4),
                parseNumber(o1, o2),
                parseRegister(o5, o6)
            );
        }
        @o1 number @o2 wsp "(" wsp @o3 register @o4 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *>(
                parseRegister(o3, o4),
                parseNumber(o1, o2)
            );
        }
        "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *, int>(
                parseRegister(o3, o4),
                0,
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        "(" wsp @o3 register @o4 wsp comma wsp @o5 register @o6 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *>(
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
        @o1 number @o2 wsp "(" wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *, int>(
                0,
                parseNumber(o1, o2),
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        "(" wsp comma wsp @o5 register @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *, int>(
                0,
                0,
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        @o1 number @o2 wsp "(" wsp comma wsp @o5 register @o6 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *, Register *>(
                0,
                parseNumber(o1, o2),
                parseRegister(o5, o6)
            );
        }
        "(" wsp @o1 number @o2 wsp ")" {
            if (cur != end) break;
            return &env().create<Indirect, Register *, Number *>(
                0,
                parseNumber(o1, o2)
            );
        }
        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    env().err() << "unknown operand '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
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

        [mM][oO][vV] @o1 [bBwWlL]? @o2 {
            if (!op1 || !op2) return 0;
            return &env().create<Move, ASMOperand*, ASMOperand*, BitWidth> (op1, op2, parseOperandSize(o1, o2));
        }
        [aA][dD][dD] @o1 [bBwWlL]? @o2 {
            if (!op1 || !op2) return 0;
            return &env().create<Add, ASMOperand*, ASMOperand*, BitWidth> (op1, op2, parseOperandSize(o1, o2));
        }
        [sS][uU][bB][bBwWlL]? {
            String s(env(), *notAnInfo, start, operandsEnd);
            env().err() << "not yet supported instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
            return 0;
        }
        [iI]?[mM][uU][lL][bBwWlL]? {
            String s(env(), *notAnInfo, start, operandsEnd);
            env().err() << "not yet supported instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
            return 0;
        }
        [hH][lL][tT] {
            return &env().create<Halt>();
        }
        [jJ][mM][pP] {
            if (!op1) return 0;
            return &env().create<Jump, ASMOperand*>(op1);
        }
        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, operandsEnd);
    env().err() << "unknown instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

// public
ASMInstructionList & Parser::parse(IStream & input, int line, int column) {
    OStream & log = env().out();
    
    ASMInstructionList & list = env().create<ASMInstructionList>();
    
    // reset parsing buffer
    token = current = marker = ctxmarker = limit = buffer + SIZE;
    currentLine = line;
    currentColumn = column;
    
    char *o1, *o2, *o3, *o4, *o5, *o6, *o7, *o8;
    
    for (;;) {
        token = current;
/*!re2c
        re2c:define:YYCURSOR = current;
        re2c:define:YYMARKER = marker;
        re2c:define:YYCTXMARKER = ctxmarker;
        re2c:define:YYLIMIT = limit;
        re2c:yyfill:enable = 1;
        re2c:define:YYFILL = "if (!fillBuffer(@@, input)) break;";
        re2c:define:YYFILL:naked = 1;
        
        inst        = id;
        operand     = register | id | number
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

        @o1 id @o2 wsp colon {
                    String & label = parseStringValue(o1, o2);
                    list.addLabel(label);
                    continue;
                  }
        @o1 id @o2 wsp assign wsp @o3 number @o4 wsp / eoinst {
                    String & label = parseStringValue(o1, o2);
                    Number * number = parseNumber(o3, o4);
                    if (number) {
                        list.addDefinition(label, *number);
                    } else {
                        log << "defin: " << label << " as "; for (char * cur = o3; cur < o4; cur++) { log << *cur; };log << '\n';
                    }
                    continue;
                  }
        @o1 inst @o2 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o2);
                    if (inst) {
                        list.addInstruction(*inst);
                    } else {
                        log << "inst0: ";
                        for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                        log << '\n';
                    }
                    continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o4, parseOperand(o3, o4));
                    if (inst) {
                        list.addInstruction(*inst);
                    } else {
                        log << "inst1: ";
                        for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                        for (char * cur = o3; cur < o4; cur++) { log << *cur; }; log << ' ';
                        log << '\n';
                    }
                    continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp comma wsp @o5 operand @o6 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o6, parseOperand(o3, o4), parseOperand(o5, o6));
                    if (inst) {
                        list.addInstruction(*inst);
                    } else {
                        log << "inst2: ";
                        for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                        for (char * cur = o3; cur < o4; cur++) { log << *cur; }; log << ' ';
                        for (char * cur = o5; cur < o6; cur++) { log << *cur; }; log << ' ';
                        log << '\n';
                    }
                    continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp comma wsp @o5 operand @o6 wsp comma wsp @o7 operand @o8 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2, o8, parseOperand(o3, o4), parseOperand(o5, o6), parseOperand(o7, o8));
                    if (inst) {
                        list.addInstruction(*inst);
                    } else {
                        log << "inst3: ";
                        for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                        for (char * cur = o3; cur < o4; cur++) { log << *cur; }; log << ' ';
                        for (char * cur = o5; cur < o6; cur++) { log << *cur; }; log << ' ';
                        for (char * cur = o7; cur < o8; cur++) { log << *cur; }; log << ' ';
                        log << '\n';
                    }
                    continue;
                  }
        *         { 
                    env().err() << "unexpected character : " << *token << " line: " << linesBuffer[token-buffer] << " column: "  << columnsBuffer[token-buffer] << '\n';
                    list.destroy();
                    return *(ASMInstructionList *)0;
                  }
*/
    }
    return list;
}
