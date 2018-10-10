#include "test/I386ASM/Instruction/DivTest.hpp"

// public
DivTest::DivTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
DivTest::~DivTest() {};

bool DivTest::runAll() {
    bool success = true;
    
    success &= testM();
    
    return success;
}

// test cases
bool DivTest::testM() {
    bool success = true;
    
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "div %ah\n"
        << "div %bx\n"
        << "div %esp\n"
        << "divb 0x2(%edi)\n"
        << "divw (%eax,%ebx,8)\n"
        << "divl (0x12345678)\n"
    ;
    (bin = "")
        << (char) 0xF6 << (char) 0xF4
        << (char) 0x66 << (char) 0xF7 << (char) 0xF3
        << (char) 0xF7 << (char) 0xF4
        << (char) 0xF6 << (char) 0x77 << (char) 0x02
        << (char) 0x66 << (char) 0xF7 << (char) 0x34 << (char) 0xD8
        << (char) 0xF7 << (char) 0x35 << (char) 0x78 << (char) 0x56 << (char) 0x34 << (char) 0x12
    ;
    (pretty = "")
        << ".code32\n"
        << "divb %ah\n"
        << "divw %bx\n"
        << "divl %esp\n"
        << "divb 0x2(%edi)\n"
        << "divw (%eax,%ebx,8)\n"
        << "divl (0x12345678)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"div reg/indirect\"");
    
    return success;
}
