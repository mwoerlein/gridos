#include "I386ASM/Parser.hpp"

#include "sys/String.hpp"
#include "sys/Digit.hpp"

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
    buffer((char*) env.getAllocator().allocate(SIZE + YYMAXFILL).buf),
    linesBuffer((int*) env.getAllocator().allocate((SIZE + YYMAXFILL) * sizeof(int)).buf),
    columnsBuffer((int*) env.getAllocator().allocate((SIZE + YYMAXFILL) * sizeof(int)).buf),
    currentLine(1),
    currentColumn(1) {
}

Parser::~Parser() {
    env().getAllocator().free(buffer);
    env().getAllocator().free(linesBuffer);
    env().getAllocator().free(columnsBuffer);
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

        end     = "\x00";
        eol     = "\r"? "\n" | "\r";
        wsp     = [ \t\r\n]*;

        bin     = "-"? "0"[bB][01]+;
        oct     = "-"? "0"[0-7]+;
        dec     = "0" | "-"? [1-9][0-9]*; 
        hex     = "-"? "0"[xX][0-9a-fA-F]+;
        number  = bin | oct | dec | hex;

        reg     = "%" ( [eE]?[aAbBcCdD][xX] | [eE]?[dDsS][iI] | [eE]?[bBiIsS][pP] | [aAbBcCdD][hHlL] | [cCdDeEfFgGsS][sS]);
        
        id          = [a-zA-Z0-9_]+;
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

        "0" [bB] @o1 [01]+ @o2          { return &env().create<Number, int>( parseIntegerValue(o1, o2,  2)); }
        "-0" [bB] @o1 [01]+ @o2         { return &env().create<Number, int>(-parseIntegerValue(o1, o2,  2)); }
        "0" @o1 [0-7]+ @o2              { return &env().create<Number, int>( parseIntegerValue(o1, o2,  8)); }
        "-0" @o1 [0-7]+ @o2             { return &env().create<Number, int>(-parseIntegerValue(o1, o2,  8)); }
        @o1 [1-9][0-9]* @o2             { return &env().create<Number, int>( parseIntegerValue(o1, o2, 10)); } 
        "-" @o1 [1-9][0-9]* @o2         { return &env().create<Number, int>(-parseIntegerValue(o1, o2, 10)); } 
        "0"[xX] @o1 [0-9a-fA-F]+ @o2    { return &env().create<Number, int>( parseIntegerValue(o1, o2, 16)); }
        "-0"[xX] @o1 [0-9a-fA-F]+ @o2   { return &env().create<Number, int>(-parseIntegerValue(o1, o2, 16)); }

        * { return &env().create<Number, int>(0); }
*/
    }
}

Register * Parser::parseRegister(char * start, char * end) {
    return &env().create<Register, enum asm_register>(eax);
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
        
        @o1 reg @o2 { return parseRegister(o1, o2); }
        @o1 number @o2 { return parseNumber(o1, o2); }
        @o1 id @o2  { return parseIdentifier(o1, o2); }
        
        @o1 number @o2 wsp "(" wsp @o3 reg @o4 wsp comma wsp @o5 reg @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            return &env().create<Indirect, Register *, Number *, Register *, int>(
                parseRegister(o3, o4),
                parseNumber(o1, o2),
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        @o1 number @o2 wsp "(" wsp @o3 reg @o4 wsp comma wsp @o5 reg @o6 wsp  ")" {
            return &env().create<Indirect, Register *, Number *, Register *>(
                parseRegister(o3, o4),
                parseNumber(o1, o2),
                parseRegister(o5, o6)
            );
        }
        @o1 number @o2 wsp "(" wsp @o3 reg @o4 wsp ")" {
            return &env().create<Indirect, Register *, Number *>(
                parseRegister(o3, o4),
                parseNumber(o1, o2)
            );
        }
        "(" wsp @o3 reg @o4 wsp comma wsp @o5 reg @o6 wsp comma wsp @o7 [1248] @o8 wsp ")" {
            return &env().create<Indirect, Register *, Number *, Register *, int>(
                parseRegister(o3, o4),
                0,
                parseRegister(o5, o6),
                parseIntegerValue(o7, o8, 10)
            );
        }
        "(" wsp @o3 reg @o4 wsp comma wsp @o5 reg @o6 wsp  ")" {
            return &env().create<Indirect, Register *, Number *, Register *>(
                parseRegister(o3, o4),
                0,
                parseRegister(o5, o6)
            );
        }
        "(" wsp @o3 reg @o4 wsp ")" {
            return &env().create<Indirect, Register *>(
                parseRegister(o3, o4)
            );
        }
        * { break; }
*/
    }
    
    String s(env(), *notAnInfo, start, end);
    env().err() << "unsupported operand '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
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
            return 0;
        }
        [iI]?[mM][uU][lL][bBwWlL]? {
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
    env().err() << "unsupported instruction '" << s << "' at line: " << linesBuffer[start-buffer] << " column: "  << columnsBuffer[start-buffer]<< '\n';
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
        
        mov     = [mM][oO][vV][bBwWlL]?;
        add     = [aA][dD][dD][bBwWlL]?;
        sub     = [sS][uU][bB][bBwWlL]?;
        mul     = [iI]?[mM][uU][lL][bBwWlL]?;
        hlt     = [hH][lL][tT];
        jmp     = [jJ][mM][pP];
        
        inst        = hlt | jmp | mov | add | sub | mul;
        operand     = reg | id | number | ((number | id) wsp)? "(" wsp reg ( wsp comma wsp reg ( wsp comma wsp [1248] )? )? wsp ")";
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
        *         { log << "error: " << *token << " line: " << linesBuffer[token-buffer] << " column: "  << columnsBuffer[token-buffer] << '\n'; break; }
*/
    }
    return list;
}
