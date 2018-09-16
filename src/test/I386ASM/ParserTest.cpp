#include "test/I386ASM/ParserTest.hpp"

// public
ParserTest::ParserTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
ParserTest::~ParserTest() {}


bool ParserTest::runAll() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "_start: movl 0xb8f00, %eax\n"
        << "addl 0x4a, %eax\n"
        << "movw 0x73c, (%eax)\n"
        << "addl 4, %eax\n"
        << "movw 0xf40, (%eax)\n"
        << "addl 2, %eax\n"
        << "movw 0xf40, (%eax)\n"
        << "addl 4, %eax\n"
        << "movw 0x73e, (%eax)\n"
        << "_halt: hlt\n"
//        << "jmp _halt\n"
        << "jmp -3\n"
    ;
    (bin = "")
        << (char) 0xb8 << (char) 0x00 << (char) 0x8f << (char) 0x0b << (char) 0x00
        << (char) 0x05 << (char) 0x4a << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x3c << (char) 0x07
        << (char) 0x05 << (char) 0x04 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x40 << (char) 0x0f
        << (char) 0x05 << (char) 0x02 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x40 << (char) 0x0f
        << (char) 0x05 << (char) 0x04 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x3e << (char) 0x07
        << (char) 0xf4
        << (char) 0xeb << (char) 0xfd
    ; 
    (pretty = "")
        << "movl 0xb8f00, %eax\n"
        << "addl 0x4a, %eax\n"
        << "movw 0x73c, (%eax)\n"
        << "addl 0x4, %eax\n"
        << "movw 0xf40, (%eax)\n"
        << "addl 0x2, %eax\n"
        << "movw 0xf40, (%eax)\n"
        << "addl 0x4, %eax\n"
        << "movw 0x73e, (%eax)\n"
        << "hlt\n"
        << "jmp -0x3\n"
    ;
    
    success &= test(in, bin, pretty, message = "\"< @@ >\"-Test");
    return success;
}
