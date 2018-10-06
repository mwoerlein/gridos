#include "KernelJIT/Module.hpp"
#include "sys/String.hpp"

Module::Module(Environment & env, MemoryInfo & mi, MemoryInfo & memoryInfo)
        :PropertyContainer(env, mi), Object(env, mi), memoryInfo(memoryInfo) {}

Module::~Module() {
    env().getAllocator().free(memoryInfo);
}

bool Module::parseHeader() {
    // TODO: detect and extract infos from memory
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
        re2c:flags:T = 1;
        re2c:define:YYCTYPE = char;
        re2c:yyfill:enable = 0;
        re2c:define:YYCURSOR = cursor;
        re2c:define:YYMARKER = mark;
        re2c:define:YYCTXMARKER = ctx;
        re2c:define:YYLIMIT = limit;
        
        end         = "\x00";
        wsp         = [ \t]*;
        id          = [a-zA-Z_][a-zA-Z0-9_]+;
        
        @o1 id @o2 {
                    if (!hasId()) {
                        setId(createOwn<String, char*, char*>(o1, o2));
                    }
                    continue;
                  }
        "--" @o1 id @o2 wsp "=" wsp @o3 [^ \x00] @o4 {
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
