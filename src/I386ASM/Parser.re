#include "I386ASM/Parser.hpp"

/*!max:re2c*/
#define SIZE 50

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
    OStream & log = env().getStdO();
    if (input.empty() || !freeBuffer(need)) {
        return false;
    }
    while (!input.empty() && (limit < buffer + SIZE)) {
        input >> *limit++;
    }
    if (limit < buffer + SIZE) {
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
    
    // init parsing buffer
    MemoryInfo & bufferInfo = env().getAllocator().allocate(SIZE + YYMAXFILL);
    buffer = (char *) bufferInfo.buf;
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
        
        "_start:" { log << "--start--\n<"; for (char * cur = token; cur < current; cur++) { log << *cur; }; log << '>'; continue; }
        "_halt:"  { log << "--halt--\n<";  for (char * cur = token; cur < current; cur++) { log << *cur; }; log << '>'; continue; }
        *         { log << *token; continue; }
*/
    }
    
    env().destroy(bufferInfo);
    log << "parse input done\n";
    return list;
}
