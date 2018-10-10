#include "test/I386ASM/Instruction/AddTest.hpp"

// public
AddTest::AddTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
AddTest::~AddTest() {};

bool AddTest::runAll() {
    bool success = true;
    
    success &= testMI();
    success &= testMR();
    success &= testRM();
    
    return success;
}

// test cases
bool AddTest::testMI() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "start:\n"
        << "add start,%al\n"
        << "add start,%ax\n"
        << "add start,%eax\n"
        << "add 0x12,%ah\n"
        << "addb 0x12,(%eax)\n"
        << "add 0x12, %edi\n"
        << "add 0x12345678, %edi\n"
        << "addb 0xFF, 0x2(%esp)\n"
        << "addw 0x4, (%edx)\n"
        << "addw 0x400, 0x6(%eax,%edi,4)\n"
        << "addl -1, (%esp)\n"
        << "addl 0xc0ffee, (%esp,%ecx,8)\n"
        << "addl BEEF, (0x20)\n"
        << "BEEF := 0xDEADBEEF\n"
    ;
    (bin = "")
        << (char) 0x04 << (char) 0x00
        << (char) 0x66 << (char) 0x05 << (char) 0x00 << (char) 0x00
        << (char) 0x05 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x80 << (char) 0xC4 << (char) 0x12
        << (char) 0x80 << (char) 0x00 << (char) 0x12
        << (char) 0x83 << (char) 0xC7 << (char) 0x12
        << (char) 0x81 << (char) 0xC7 << (char) 0x78 << (char) 0x56 << (char) 0x34 << (char) 0x12
        << (char) 0x80 << (char) 0x44 << (char) 0x24 << (char) 0x02 << (char) 0xFF
        << (char) 0x66 << (char) 0x83 << (char) 0x02 << (char) 0x04
        << (char) 0x66 << (char) 0x81 << (char) 0x44 << (char) 0xB8 << (char) 0x06 << (char) 0x00 << (char) 0x04
        << (char) 0x83 << (char) 0x04 << (char) 0x24 << (char) 0xFF
        << (char) 0x81 << (char) 0x04 << (char) 0xCC << (char) 0xEE << (char) 0xFF << (char) 0xC0 << (char) 0x00
        << (char) 0x81 << (char) 0x05 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE
    ;
    (pretty = "")
        << ".code32\n"
        << "start:\n"
        << "addb start, %al\n"
        << "addw start, %ax\n"
        << "addl start, %eax\n"
        << "addb 0x12, %ah\n"
        << "addb 0x12, (%eax)\n"
        << "addl 0x12, %edi\n"
        << "addl 0x12345678, %edi\n"
        << "addb 0xff, 0x2(%esp)\n"
        << "addw 0x4, (%edx)\n"
        << "addw 0x400, 0x6(%eax,%edi,4)\n"
        << "addl 0xffffffff, (%esp)\n"
        << "addl 0xc0ffee, (%esp,%ecx,8)\n"
        << "addl 0xdeadbeef, (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"add imm -> indirect\"");
    
    return success;
}

bool AddTest::testMR() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "add %al,%al\n"
        << "add %bx,%dx\n"
        << "add %esp,%ebp\n"
        << "addb %ah, 0x2(%esp)\n"
        << "addw %di, 0x6(%eax,%edi,4)\n"
        << "addl %ebp, (%esp,%ecx,8)\n"
    ;
    (bin = "")
        << (char) 0x00 << (char) 0xC0
        << (char) 0x66 << (char) 0x01 << (char) 0xDA
        << (char) 0x01 << (char) 0xE5
        << (char) 0x00 << (char) 0x64 << (char) 0x24 << (char) 0x02
        << (char) 0x66 << (char) 0x01 << (char) 0x7C << (char) 0xB8 << (char) 0x06
        << (char) 0x01 << (char) 0x2C << (char) 0xCC
    ;
    (pretty = "")
        << ".code32\n"
        << "addb %al, %al\n"
        << "addw %bx, %dx\n"
        << "addl %esp, %ebp\n"
        << "addb %ah, 0x2(%esp)\n"
        << "addw %di, 0x6(%eax,%edi,4)\n"
        << "addl %ebp, (%esp,%ecx,8)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"add reg -> reg/indirect\"");
    
    return success;
}

bool AddTest::testRM() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "add 0x2(%esp), %ah\n"
        << "add 0x6(%eax,%edi,4), %di\n"
        << "add (%esp,%ecx,8), %ebp\n"
    ;
    (bin = "")
        << (char) 0x02 << (char) 0x64 << (char) 0x24 << (char) 0x02
        << (char) 0x66 << (char) 0x03 << (char) 0x7C << (char) 0xB8 << (char) 0x06
        << (char) 0x03 << (char) 0x2C << (char) 0xCC
    ;
    (pretty = "")
        << ".code32\n"
        << "addb 0x2(%esp), %ah\n"
        << "addw 0x6(%eax,%edi,4), %di\n"
        << "addl (%esp,%ecx,8), %ebp\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"add indirect -> reg\"");
    
    return success;
}
