#include "test/I386ASM/Instruction/IntTest.hpp"

// public
IntTest::IntTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
IntTest::~IntTest() {};

bool IntTest::runAll() {
    bool success = true;

    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << ".code32\n"
        << "int 0\n"
        << "int 1\n"
        << "int (2*111)\n"
        << ".code16\n"
        << "int 3\n"
        << "int 13\n"
        << "int 0xff\n"
    ;
    (bin = "")
        << (char) 0xCD << (char) 0x00
        << (char) 0xCD << (char) 0x01
        << (char) 0xCD << (char) 0xDE
        << (char) 0xCD << (char) 0x03
        << (char) 0xCD << (char) 0x0D
        << (char) 0xCD << (char) 0xFF
    ;
    (pretty = "")
        << ".code32\n"
        << "int 0x0\n"
        << "int 0x1\n"
        << "int 0xde\n"
        << ".code16\n"
        << "int 0x3\n"
        << "int 0xd\n"
        << "int 0xff\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"int\"");
    
    return success;
}
