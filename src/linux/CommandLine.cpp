#include "linux/CommandLine.hpp"

#include "sys/collection/LinkedList.hpp"

#define MODE_START 0
#define MODE_SHORT_OPT 1
#define MODE_LONG_OPT 2
#define MODE_OPT_VALUE 3
#define MODE_ARG 4

#define PUSH_ARG(arg) {\
    if (!(arg).length()) { return false; }\
    _arguments.add(createOwn<String, String&>((arg)));\
    (arg) = "";\
}
#define PUSH_OPT(opt) {\
    if (!arg.length()) { return false; }\
    set(createOwn<String, String&>((opt)), True);\
    (opt) = "";\
}
#define PUSH_OPT_VALUE(opt, value) {\
    if (!(opt).length() || !(value).length()) { return false; }\
    set(createOwn<String, String&>((opt)), createOwn<String, String&>((value)));\
    (opt) = "";\
    (value) = "";\
}

CommandLine::CommandLine(Environment & env, MemoryInfo & mi)
        :PropertyContainer(env,mi), Object(env,mi), True(env.create<Bool, bool>(true)),
        _arguments(env.create<LinkedList<String>>()) {
}
CommandLine::~CommandLine() {
    _arguments.destroy();
}    

bool CommandLine::parse(int argc, char* argv[]) {
    int mode = MODE_START;
    String arg(env());
    String value(env());
    
    for (int argn = 1; argn < argc; argn++) {
        char *current = argv[argn];
        char *c = current++;
        switch (*c) {
            case '-':
                switch (mode) {
                    case MODE_START:
                        break;
                    case MODE_SHORT_OPT:
                    case MODE_LONG_OPT:
                        PUSH_OPT(arg);
                        break;
                    case MODE_OPT_VALUE:
                        PUSH_OPT_VALUE(arg, value);
                        break;
                    case MODE_ARG:
                        PUSH_ARG(arg);
                        break;
                }
                mode = MODE_SHORT_OPT;
                break;
            default:
                switch (mode) {
                    case MODE_START:
                        mode = MODE_ARG;
                        arg << *c;
                        break;
                    case MODE_SHORT_OPT:
                    case MODE_LONG_OPT:
                        mode = MODE_OPT_VALUE;
                        value << *c;
                        break;
                    case MODE_OPT_VALUE:
                        PUSH_OPT_VALUE(arg, value);
                        mode = MODE_ARG;
                        arg << *c;
                        break;
                    case MODE_ARG:
                        PUSH_ARG(arg);
                        arg << *c;
                        break;
                }
                break;
        }
        if (!*current) {
            return false;
        }
        while (*(c = current++)) {
            switch (*c) {
                case '-':
                    switch (mode) {
                        case MODE_SHORT_OPT:
                            if (arg.length()) { return false; }
                            mode = MODE_LONG_OPT;
                            break;
                        case MODE_LONG_OPT:
                        case MODE_ARG:
                            if (!arg.length()) { return false; }
                            arg << *c;
                            break;
                        case MODE_OPT_VALUE:
                            value << *c;
                            break;
                    }
                    break;
                case '=':
                    switch (mode) {
                        case MODE_SHORT_OPT:
                            mode = MODE_OPT_VALUE;
                            break;
                        case MODE_LONG_OPT:
                            mode = MODE_OPT_VALUE;
                            break;
                        case MODE_ARG:
                            arg << *c;
                            break;
                        case MODE_OPT_VALUE:
                            value << *c;
                            break;
                    }
                    break;
                default:
                    switch (mode) {
                        case MODE_SHORT_OPT:
                            if (arg.length()) { PUSH_OPT(arg); }
                            arg << *c;
                            break;
                        case MODE_LONG_OPT:
                        case MODE_ARG:
                            arg << *c;
                            break;
                        case MODE_OPT_VALUE:
                            value << *c;
                            break;
                    }
                    break;
            }
        }
    }
    switch (mode) {
        case MODE_START:
            break;
        case MODE_SHORT_OPT:
        case MODE_LONG_OPT:
            PUSH_OPT(arg);
            break;
        case MODE_OPT_VALUE:
            PUSH_OPT_VALUE(arg, value);
            break;
        case MODE_ARG:
            PUSH_ARG(arg);
            break;
    }
    return true;
}
