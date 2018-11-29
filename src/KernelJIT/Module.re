#include "KernelJIT/Module.hpp"

#include "sys/String.hpp"
#include "memory/MemoryIOStream.hpp"
#include "memory/MemoryInfoHelper.hpp"

Module::Module(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo)
        :PropertyContainer(env, mi), Object(env, mi), memoryInfo(memoryInfo), ownedInfo(&memoryInfo), contentOffset(0) {}
Module::Module(Environment & env, MemoryInfo & mi, void* buf, size_t len)
        :PropertyContainer(env, mi), Object(env, mi), ownedInfo(notAnInfo), contentOffset(0) {
    memoryInfo.buf = buf;
    memoryInfo.len = len;
}

Module::~Module() {
    if (ownedInfo != notAnInfo) {
        env().getAllocator().free(*ownedInfo);
    }
}

IStream & Module::getContentIStream() {
    MemoryIOStream & content = env().create<MemoryIOStream, MemoryInfo&>(memoryInfo);
    content.seek(contentOffset);
    return content;
}

size_t Module::getContentSize() {
    return memoryInfo.len - contentOffset;
}

/*!re2c
        re2c:flags:T = 1;
        re2c:define:YYCTYPE = char;
        re2c:yyfill:enable = 0;
        
        end         = "\x00";
        eol         = "\r"? "\n" | "\r";
        wsp         = [ \t]*;
        id          = [a-zA-Z_][a-zA-Z0-9_.]+;
*/

bool Module::parseHeader() {
    if (memoryInfo.len < 10) {
        // too short for parsable header
        return true;
    }
    char *cursor = (char *) memoryInfo.buf;
    if ((*cursor++ != '/') || (*cursor++ != '*') || (*cursor != '[')) {
        // no parsable header found
        return true;
    }
    char *bufEnd = (char*) ((size_t)memoryInfo.buf + memoryInfo.len);
    char *headerEnd = (char *) memoryInfo.buf;
    while (headerEnd < bufEnd) {
        if (*(headerEnd++) == '*' && *headerEnd == '/') {
            break;
        }
    }
    if (*headerEnd != '/') {
        // no header end found
        return false;
    }
    
    char *contentStart = headerEnd + 1;
    // skip newline
    switch (*contentStart) {
        case '\r':
            if (*contentStart++ == '\n') {
                contentStart++;
            }
            break;
        case '\n':
            contentStart++;
    }
    contentOffset = (size_t) contentStart - (size_t) memoryInfo.buf;
    
    char * limit = headerEnd-1;
    char *token, *mark, *ctx, *b1, *b2, *o1, *o2, *o3, *o4;
        
/*!stags:re2c format = 'char *@@;'; */
#   define YYCTYPE     char
#   define YYPEEK()    *cursor
#   define YYSKIP()    if (cursor++ == limit) break;
#   define YYBACKUP()  mark = cursor
#   define YYRESTORE() cursor = mark
#   define YYSTAGP(t)  t = cursor    
    for (;;) {
        token = cursor;
        
/*!re2c
        re2c:flags:input = custom;
        re2c:define:YYCURSOR = cursor;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        
        "[" wsp @b1 id @b2 wsp "]" wsp eol { continue; }
        ";" [^\n]* wsp eol { continue; }
        @o1 id @o2 wsp "=" wsp @o3 [^\r\n]* @o4 wsp eol {
                    String &key = createOwn<String, char*, char*>(b1, b2);
                    key << '.';
                    for (char *cur = o1; cur < o2; cur++) {
                        key << *cur;
                    }
                    setStringProperty(key, createOwn<String, char*, char*>(o3, o4));
                    continue;
                  }
        wsp       { continue; }
        end       { break; }
        *         { env().err() << "unexpected character: " << *token << '\n'; return false; }
*/    
    }
    
    return true;
}

bool Module::parseCommandline(const char * commandline) {
    char *cursor = (char *) commandline;
    char *limit = cursor;
    char *token, *mark, *ctx, *o1, *o2, *o3, *o4;
    while (*++limit);
    
/*!stags:re2c format = 'char *@@;'; */
    
    for (;;) {
        token = cursor;
/*!re2c
        re2c:flags:input = default;
        re2c:define:YYCURSOR = cursor;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = limit;
        
        @o1 id @o2 {
                    if (!hasId()) {
                        setId(createOwn<String, char*, char*>(o1, o2));
                    }
                    continue;
                  }
        "--" @o1 id @o2 wsp "=" wsp @o3 [^ \x00]+ @o4 {
                    String &key = createOwn<String, const char*>(PROPERTYPREFIX_DEFAULT);
                    for (char *cur = o1; cur < o2; cur++) {
                        key << *cur;
                    }
                    setStringProperty(key, createOwn<String, char*, char*>(o3, o4));
                    continue;
                  }
        wsp       { continue; }
        end       { break; }
        *         { env().err() << "unexpected character: " << *token << '\n'; return false; }
*/    
    }
    return true;
}

void Module::dump(OStream &log, bool properties) {
    log << '[' << getId() << "] ("<<memoryInfo.buf<<":"<<memoryInfoEnd(&memoryInfo)<<")\n"; 
    if (properties) { dumpProperties(log); }
}
