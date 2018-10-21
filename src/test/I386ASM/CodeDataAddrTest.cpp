#include "test/I386ASM/CodeDataAddrTest.hpp"

// public
CodeDataAddrTest::CodeDataAddrTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
CodeDataAddrTest::~CodeDataAddrTest() {}


bool CodeDataAddrTest::runAll() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << ".code16\n"
        << ".addr16 .data16 movw 0x16, (0x16)\n"
        << ".addr16 .data32 movw 0x32, (0x16)\n"
        << ".addr32 .data16 movw 0x16, (0x32)\n"
        << ".addr32 .data32 movw 0x32, (0x32)\n"
        << ".addr16 .data16 addl 0x16, (0x16)\n"
        << ".addr16 .data32 addl 0x32, (0x16)\n"
        << ".addr32 .data16 addl 0x16, (0x32)\n"
        << ".addr32 .data32 addl 0x32, (0x32)\n"
        << ".code32\n"
        << ".addr16 .data16 addw 0x16, (0x16)\n"
        << ".addr16 .data32 addw 0x32, (0x16)\n"
        << ".addr32 .data16 addw 0x16, (0x32)\n"
        << ".addr32 .data32 addw 0x32, (0x32)\n"
        << ".addr16 .data16 movl 0x16, (0x16)\n"
        << ".addr16 .data32 movl 0x32, (0x16)\n"
        << ".addr32 .data16 movl 0x16, (0x32)\n"
        << ".addr32 .data32 movl 0x32, (0x32)\n"
    ;
    (bin = "")
        // .code16 movw
        << (char) 0xc7 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x16 << (char) 0x00
        << (char) 0x66 << (char) 0xc7 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x32 << (char) 0x00
        << (char) 0x67 << (char) 0xc7 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x16 << (char) 0x00
        << (char) 0x66 << (char) 0x67 << (char) 0xc7 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x32 << (char) 0x00
        // .code16 addl imm8
        << (char) 0x66 << (char) 0x83 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x16
        << (char) 0x83 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x32
        << (char) 0x66 << (char) 0x67 << (char) 0x83 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x16
        << (char) 0x67 << (char) 0x83 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x32
        // .code32 addw imm8
        << (char) 0x67 << (char) 0x83 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x16
        << (char) 0x66 << (char) 0x67 << (char) 0x83 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x32
        << (char) 0x83 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x16
        << (char) 0x66 << (char) 0x83 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x32
        // .code32 movl
        << (char) 0x66 << (char) 0x67 << (char) 0xc7 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x16 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xc7 << (char) 0x06 << (char) 0x16 << (char) 0x00 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xc7 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x16 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xc7 << (char) 0x05 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x32 << (char) 0x00 << (char) 0x00 << (char) 0x00
    ; 
    (pretty = "")
        << ".code16\n"
        << "movw 0x16, (0x16)\n"
        << ".data32 movw 0x32, (0x16)\n"
        << ".addr32 movw 0x16, (0x32)\n"
        << ".data32 .addr32 movw 0x32, (0x32)\n"
        << "addl 0x16, (0x16)\n"
        << ".data32 addl 0x32, (0x16)\n"
        << ".addr32 addl 0x16, (0x32)\n"
        << ".data32 .addr32 addl 0x32, (0x32)\n"
        << ".code32\n"
        << ".data16 .addr16 addw 0x16, (0x16)\n"
        << ".addr16 addw 0x32, (0x16)\n"
        << ".data16 addw 0x16, (0x32)\n"
        << "addw 0x32, (0x32)\n"
        << ".data16 .addr16 movl 0x16, (0x16)\n"
        << ".addr16 movl 0x32, (0x16)\n"
        << ".data16 movl 0x16, (0x32)\n"
        << "movl 0x32, (0x32)\n"
    ;
    
    success &= test(in, bin, pretty, message = "\"code/data/addr\"-Test");
    
    return success;
}
