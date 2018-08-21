#include "I386ASM/Parser.hpp"

/*!max:re2c*/
#define SIZE 500

Parser::Parser(Environment &env):
    Object(env),
    buffer((char*) env.getAllocator().allocate(SIZE + YYMAXFILL).buf) {
}

Parser:: ~Parser() {
    env().getAllocator().free(buffer);
}

bool Parser::freeBuffer(size_t need) {
    const size_t free = token - buffer;
    if (free < need) {
        return false;
    }
    for (char *src = token, *dest = buffer; src < limit; src++, dest++) {
        *dest = *src;
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
    if (input.empty() || !freeBuffer(need)) {
        return false;
    }
    while (!input.empty() && (limit < buffer + SIZE)) {
        input >> *limit++;
    }
    if (limit < buffer + SIZE) {
        // clear lookahead after end of stream
        char * maxfill = limit + YYMAXFILL;
        while (limit < maxfill) {
            *limit++ = (char) 0;
        }
    }
    return true;
};

// public
ASMInstructionList & Parser::parse(IStream & input) {
    OStream & log = env().getStdO();
    ASMInstructionList & list = env().create<ASMInstructionList>();
    
    // reset parsing buffer
    token = current = marker = ctxmarker = limit = buffer + SIZE;
    
    log << "parse input\n";
    
    for (;;) {
        token = current;
/*!re2c
        re2c:define:YYCTYPE = char;
        re2c:define:YYCURSOR = current;
        re2c:define:YYMARKER = marker;
        re2c:define:YYCTXMARKER = ctxmarker;
        re2c:define:YYLIMIT = limit;
        re2c:define:YYFILL = "if (!fillBuffer(@@, input)) break;";
        re2c:define:YYFILL:naked = 1;
        
        end     = "\x00";
        eol     = "\n";
        wsp     = [ \t]*;

        bin     = "0"[bB][01]+;
        oct     = "0"[0-7]+;
        dec     = "0" | [1-9][0-9]*; 
        hex     = "0"[xX][0-9a-fA-F]+;
        number  = bin | oct | dec | hex;

        mov     = [mM][oO][vV][bBwWlL]?;
        add     = [aA][dD][dD][bBwWlL]?;
        sub     = [sS][uU][bB][bBwWlL]?;
        mul     = [iI]?[mM][uU][lL][bBwWlL]?;
        hlt     = [hH][lL][tT];
        jmp     = [jJ][mM][pP];
        reg     = "%" ( [eE]?[aAbBcCdD][xX] | [eE]?[dDsS][iI] | [eE]?[bBiIsS][pP] | [aAbBcCdD][hHlL] | [cCdDeEsS][sS]);
        
        id      = [a-zA-Z0-9_]+;
        
        inst0   = hlt;
        inst1   = jmp | mul;
        inst2   = mov | add | sub | mul;
        inst3   = mul;
        arg     = reg | id | number | (number wsp)? "(" wsp reg ( wsp "," wsp reg ( wsp "," wsp [1,2,4,8] )? )? wsp ")";

        end       { break; }
        wsp | eol { continue; }

        id ":"    { log << "label: "; for (char * cur = token; cur < current - 1; cur++) { log << *cur; }; log << '\n'; continue; }
        inst0 {
                    log << "inst0: "; for (char * cur = token; cur < current; cur++) { log << *cur; }; log << '\n'; continue;
                  }
        inst1 wsp arg {
                    log << "inst1: "; for (char * cur = token; cur < current; cur++) { log << *cur; }; log << '\n'; continue;
                  }
        inst2 wsp arg wsp "," wsp arg {
                    log << "inst2: "; for (char * cur = token; cur < current; cur++) { log << *cur; }; log << '\n'; continue;
                  }
        inst3 wsp arg wsp "," wsp arg wsp "," wsp arg {
                    log << "inst3: "; for (char * cur = token; cur < current; cur++) { log << *cur; }; log << '\n'; continue;
                  }
        *         { log << "error: " << *token << '\n'; break; }
*/
    }
    
    log << "parse input done\n";
    return list;
}
