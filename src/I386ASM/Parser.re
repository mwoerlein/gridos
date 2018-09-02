#include "I386ASM/Parser.hpp"

#include "sys/String.hpp"

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
    if (limit < buffer + SIZE) {
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

// public
ASMInstructionList & Parser::parse(IStream & input, int line, int column) {
    OStream & log = env().out();
    ASMInstructionList & list = env().create<ASMInstructionList>();
    String comments = env().create<String>();
    
    if (true) {
    
    // reset parsing buffer
    token = current = marker = ctxmarker = limit = buffer + SIZE;
    currentLine = line;
    currentColumn = column;
    
    char *o1, *o2, *o3, *o4, *o5, *o6, *o7, *o8;
    
    log << "parse input\n";
    
    for (;;) {
        token = current;
/*!stags:re2c format = 'char *@@;'; */
/*!re2c
        re2c:flags:T = 1;
        re2c:define:YYCTYPE = char;
        re2c:define:YYCURSOR = current;
        re2c:define:YYMARKER = marker;
        re2c:define:YYCTXMARKER = ctxmarker;
        re2c:define:YYLIMIT = limit;
        re2c:define:YYFILL = "if (!fillBuffer(@@, input)) break;";
        re2c:define:YYFILL:naked = 1;
        
        end     = "\x00";
        eol     = "\r"? "\n" | "\r";
        wsp     = [ \t\r\n]*;

        bin     = "-"? "0"[bB][01]+;
        oct     = "-"? "0"[0-7]+;
        dec     = "0" | "-"? [1-9][0-9]*; 
        hex     = "-"? "0"[xX][0-9a-fA-F]+;
        number  = bin | oct | dec | hex;

        mov     = [mM][oO][vV][bBwWlL]?;
        add     = [aA][dD][dD][bBwWlL]?;
        sub     = [sS][uU][bB][bBwWlL]?;
        mul     = [iI]?[mM][uU][lL][bBwWlL]?;
        hlt     = [hH][lL][tT];
        jmp     = [jJ][mM][pP];
        reg     = "%" ( [eE]?[aAbBcCdD][xX] | [eE]?[dDsS][iI] | [eE]?[bBiIsS][pP] | [aAbBcCdD][hHlL] | [cCdDeEfFgGsS][sS]);
        
        id          = [a-zA-Z0-9_]+;
        comma       = ",";
        semicolon   = ";";
        colon       = ":";
        assign      = ":=";
        
        inst        = hlt | jmp | mov | add | sub | mul;
        operand     = reg | id | number | ((number | id) wsp)? "(" wsp reg ( wsp comma wsp reg ( wsp comma wsp [1,2,4,8] )? )? wsp ")";
        eoinst      = semicolon | eol | "//" | "#" | "/*" ;

        end       { break; }
        wsp       { continue; }
        semicolon { continue; }
        ( "//" | "#" ) @o1 [^\n]* @o2 eol {
                    String comment = env().create<String, char*, char*>(o1, o2);
                    comments << "linec: " << comment << '\n';
                    comment.destroy();
                    continue;
                  }
        "/*" @o1 ([^*] | ("*" [^/]))* @o2 "*""/" {
                    String comment = env().create<String, char*, char*>(o1, o2);
                    comments << "mlcom: " << comment << '\n';
                    comment.destroy();
                    continue;
                  }

        @o1 id @o2 wsp colon {
                    log << "label: "; for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << '\n'; continue; }
        @o1 id @o2 wsp assign wsp @o3 number @o4 wsp / eoinst {
                    log << "defin: "; for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << " as "; for (char * cur = o3; cur < o4; cur++) { log << *cur; };log << '\n'; continue;
                  }
        @o1 inst @o2 wsp / eoinst {
                    log << "inst0: ";
                    for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                    log << '\n'; continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp / eoinst {
                    log << "inst1: ";
                    for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                    for (char * cur = o3; cur < o4; cur++) { log << *cur; }; log << ' ';
                    log << '\n'; continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp comma wsp @o5 operand @o6 wsp / eoinst {
                    log << "inst2: ";
                    for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                    for (char * cur = o3; cur < o4; cur++) { log << *cur; }; log << ' ';
                    for (char * cur = o5; cur < o6; cur++) { log << *cur; }; log << ' ';
                    log << '\n'; continue;
                  }
        @o1 inst @o2 wsp @o3 operand @o4 wsp comma wsp @o5 operand @o6 wsp comma wsp @o7 operand @o8 wsp / eoinst {
                    log << "inst3: ";
                    for (char * cur = o1; cur < o2; cur++) { log << *cur; }; log << ' ';
                    for (char * cur = o3; cur < o4; cur++) { log << *cur; }; log << ' ';
                    for (char * cur = o5; cur < o6; cur++) { log << *cur; }; log << ' ';
                    for (char * cur = o7; cur < o8; cur++) { log << *cur; }; log << ' ';
                    log << '\n'; continue;
                  }
        *         { log << "error: " << *token << " line: " << linesBuffer[token-buffer] << " column: "  << columnsBuffer[token-buffer] << '\n'; break; }
*/
    }
    }
    // TODO: fill list via re2c
    list.addInstruction(env().create<Move, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(0xb8f00),
        &env().create<Register, enum asm_register>(eax),
        l
    ));
    list.addInstruction(env().create<Add, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(74),
        &env().create<Register, enum asm_register>(eax),
        l
    ));
    list.addInstruction(env().create<Move, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(0x073c),
        &env().create<Indirect, Register*>(&env().create<Register, enum asm_register>(eax)),
        w
    ));
    list.addInstruction(env().create<Add, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(4),
        &env().create<Register, enum asm_register>(eax),
        l
    ));
    list.addInstruction(env().create<Move, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(0x0f40),
        &env().create<Indirect, Register*>(&env().create<Register, enum asm_register>(eax)),
        w
    ));
    list.addInstruction(env().create<Add, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(2),
        &env().create<Register, enum asm_register>(eax),
        l
    ));
    list.addInstruction(env().create<Move, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(0x0f40),
        &env().create<Indirect, Register*>(&env().create<Register, enum asm_register>(eax)),
        w
    ));
    list.addInstruction(env().create<Add, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(4),
        &env().create<Register, enum asm_register>(eax),
        l
    ));
    list.addInstruction(env().create<Move, ASMOperand*, ASMOperand*, OperandSize>(
        &env().create<Number, int>(0x073e),
        &env().create<Indirect, Register*>(&env().create<Register, enum asm_register>(eax)),
        w
    ));
    list.addInstruction(env().create<Halt>());
    list.addInstruction(env().create<Jump, Number*>(
        &env().create<Number, int>(-3)
    ));
    
    log << "parse input done\n";
    if (false && comments.length()) {
        log << "comments:\n" << comments << '\n';
    }
    comments.destroy();
    return list;
}
