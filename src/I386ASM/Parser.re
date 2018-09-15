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
        wsp         = [ \t\r\n]*;

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

        "%"[aA][hH]          { if (cur != end) break; return &env().create<Register, enum asm_register>(ah); }
        "%"[bB][hH]          { if (cur != end) break; return &env().create<Register, enum asm_register>(bh); }
        "%"[cC][hH]          { if (cur != end) break; return &env().create<Register, enum asm_register>(ch); }
        "%"[dD][hH]          { if (cur != end) break; return &env().create<Register, enum asm_register>(dh); }
        "%"[aA][lL]          { if (cur != end) break; return &env().create<Register, enum asm_register>(al); }
        "%"[bB][lL]          { if (cur != end) break; return &env().create<Register, enum asm_register>(bl); }
        "%"[cC][lL]          { if (cur != end) break; return &env().create<Register, enum asm_register>(cl); }
        "%"[dD][lL]          { if (cur != end) break; return &env().create<Register, enum asm_register>(dl); }
        
        "%"[aA][xX]          { if (cur != end) break; return &env().create<Register, enum asm_register>(ax); }
        "%"[bB][xX]          { if (cur != end) break; return &env().create<Register, enum asm_register>(bx); }
        "%"[cC][xX]          { if (cur != end) break; return &env().create<Register, enum asm_register>(cx); }
        "%"[dD][xX]          { if (cur != end) break; return &env().create<Register, enum asm_register>(dx); }
        "%"[dD][iI]          { if (cur != end) break; return &env().create<Register, enum asm_register>(di); }
        "%"[sS][iI]          { if (cur != end) break; return &env().create<Register, enum asm_register>(si); }
        "%"[bB][pP]          { if (cur != end) break; return &env().create<Register, enum asm_register>(bp); }
        "%"[iI][pP]          { if (cur != end) break; return &env().create<Register, enum asm_register>(ip); }
        "%"[sS][pP]          { if (cur != end) break; return &env().create<Register, enum asm_register>(sp); }
        
        "%"[eE][aA][xX]      { if (cur != end) break; return &env().create<Register, enum asm_register>(eax); }
        "%"[eE][bB][xX]      { if (cur != end) break; return &env().create<Register, enum asm_register>(ebx); }
        "%"[eE][cC][xX]      { if (cur != end) break; return &env().create<Register, enum asm_register>(ecx); }
        "%"[eE][dD][xX]      { if (cur != end) break; return &env().create<Register, enum asm_register>(edx); }
        "%"[eE][dD][iI]      { if (cur != end) break; return &env().create<Register, enum asm_register>(edi); }
        "%"[eE][sS][iI]      { if (cur != end) break; return &env().create<Register, enum asm_register>(esi); }
        "%"[eE][bB][pP]      { if (cur != end) break; return &env().create<Register, enum asm_register>(ebp); }
        "%"[eE][iI][pP]      { if (cur != end) break; return &env().create<Register, enum asm_register>(eip); }
        "%"[eE][sS][pP]      { if (cur != end) break; return &env().create<Register, enum asm_register>(esp); }
        
        "%"[cC][sS]          { if (cur != end) break; return &env().create<Register, enum asm_register>(cs); }
        "%"[dD][sS]          { if (cur != end) break; return &env().create<Register, enum asm_register>(ds); }
        "%"[eE][sS]          { if (cur != end) break; return &env().create<Register, enum asm_register>(es); }
        "%"[fF][sS]          { if (cur != end) break; return &env().create<Register, enum asm_register>(fs); }
        "%"[gG][sS]          { if (cur != end) break; return &env().create<Register, enum asm_register>(gs); }
        "%"[sS][sS]          { if (cur != end) break; return &env().create<Register, enum asm_register>(ss); }

        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    env().err() << "unknown register '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
    return 0;
}

Identifier * Parser::parseIdentifier(char * start, char * end) {
    return &env().create<Identifier, String&>(env().create<String, char*, char*>(start, end));
}

OperandSize Parser::parseOperandSize(char * start, char * end) {
    if (end - start != 1) {
        return automatic;
    }
    switch (*start) {
        case 'l':
        case 'L':
            return l;
        case 'w':
        case 'W':
            return w;
        case 'b':
        case 'B':
            return b;
        default:
            return automatic;
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

ASMInstruction * Parser::parseInstruction(char * start, char * end, ASMOperand *op1, ASMOperand *op2, ASMOperand *op3) {
    char *o1, *o2, *mark, *ctx, *cur = start;
    for (;;) {
/*!re2c
        re2c:define:YYCURSOR = cur;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = end;

        [mM][oO][vV] @o1 [bBwWlL]? @o2 {
            if (!op1 || !op2) return 0;
            return &env().create<Move, ASMOperand*, ASMOperand*, OperandSize> (op1, op2, parseOperandSize(o1, o2));
        }
        [aA][dD][dD] @o1 [bBwWlL]? @o2 {
            if (!op1 || !op2) return 0;
            return &env().create<Add, ASMOperand*, ASMOperand*, OperandSize> (op1, op2, parseOperandSize(o1, o2));
        }
        [sS][uU][bB][bBwWlL]? {
            String s(env(), *notAnInfo, start, end);
            env().err() << "not yet supported instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
            return 0;
        }
        [iI]?[mM][uU][lL][bBwWlL]? {
            String s(env(), *notAnInfo, start, end);
            env().err() << "not yet supported instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
            return 0;
        }
        [hH][lL][tT] {
            return &env().create<Halt>();
        }
        [jJ][mM][pP] {
            if (!op1) return 0;
            if (Number *n = op1->as<Number>(number)) {
                return &env().create<Jump, Number*>(n);
            }
        }
        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
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
        wsp       { continue; }
        semicolon { continue; }
        ( "//" | "#" ) @o1 [^\n]* @o2 eol { continue; }
        "/*" @o1 ([^*] | ("*" [^/]))* @o2 "*""/" { continue; }

        @o1 id @o2 wsp colon {
                    log << "label: "; for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << '\n'; continue; }
        @o1 id @o2 wsp assign wsp @o3 number @o4 wsp / eoinst {
                    log << "defin: "; for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << " as "; for (char * cur = o3; cur < o4; cur++) { log << *cur; };log << '\n'; continue;
                  }
        @o1 inst @o2 wsp / eoinst {
                    ASMInstruction * inst = parseInstruction(o1, o2);
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
                    ASMInstruction * inst = parseInstruction(o1, o2, parseOperand(o3, o4));
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
                    ASMInstruction * inst = parseInstruction(o1, o2, parseOperand(o3, o4), parseOperand(o5, o6));
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
                    ASMInstruction * inst = parseInstruction(o1, o2, parseOperand(o3, o4), parseOperand(o5, o6), parseOperand(o7, o8));
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
