#include "test/I386ASM/Instruction/InlineAlignOrgTest.hpp"

// public
InlineAlignOrgTest::InlineAlignOrgTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
InlineAlignOrgTest::~InlineAlignOrgTest() {};

bool InlineAlignOrgTest::runAll() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << ".code32\n"
        << ".byte 0x0\n"
        << ".byte 0x12\n"
        << ".align 0x4\n"
        << ".word 0x12\n"
        << ".word (0x1200 + 0x34)\n"
        << ".align 0x8\n"
        << ".long 0x12345678\n"
        << ".align (2*4)\n"
        << ".org ((1<<4)+6)\n"
        << ".align 0x20\n"
        << ".long 0x87654321\n"
    ;
    (bin = "")
        << (char) 0x00 << (char) 0x12 << (char) 0x90 << (char) 0x90
        << (char) 0x12 << (char) 0x00 << (char) 0x34 << (char) 0x12
        << (char) 0x78 << (char) 0x56 << (char) 0x34 << (char) 0x12
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x00 << (char) 0x00 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x21 << (char) 0x43 << (char) 0x65 << (char) 0x87
    ;
    
    (pretty = "")
        << ".code32\n"
        << ".byte 0x0\n"
        << ".byte 0x12\n"
        << ".align 0x4\n"
        << ".word 0x12\n"
        << ".word 0x1234\n"
        << ".align 0x8\n"
        << ".long 0x12345678\n"
        << ".align 0x8\n"
        << ".org 0x16\n"
        << ".align 0x20\n"
        << ".long 0x87654321\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"inline align org\"");
    
    return success;
}
