#include "test/I386ASM/Instruction/MoveTest.hpp"

#include "sys/OStreamFactory.hpp"

// public
MoveTest::MoveTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
MoveTest::~MoveTest() {};


bool MoveTest::runAll() {
    bool success = true;
    
    success &= testMR();
    success &= testRM();
    /*
    success &= testFD();
    success &= testTD();
    success &= testOI();
    success &= testMI();
    */
    
    return success;
}

// test cases
bool MoveTest::testMR() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "movl %eax, %eax\n"
        << "movl %eax, %ebx\n"
        << "movl %ebx, %eax\n"
        << "movl %ecx, %ebx\n"
        << "movl %edx, %ecx\n"
        << "movl %edi, %edx\n"
        << "movl %esi, %edi\n"
        << "movl %ebp, %esi\n"
        << "movl %esp, %ebp\n"
        << "movl %esp, %esp\n"
    ;
    (bin = "")
        << (char) 0x89 << (char) 0xC0
        << (char) 0x89 << (char) 0xC3
        << (char) 0x89 << (char) 0xD8
        << (char) 0x89 << (char) 0xCB
        << (char) 0x89 << (char) 0xD1
        << (char) 0x89 << (char) 0xFA
        << (char) 0x89 << (char) 0xF7
        << (char) 0x89 << (char) 0xEE
        << (char) 0x89 << (char) 0xE5
        << (char) 0x89 << (char) 0xE4
    ;
    
    success &= test(in, bin, in, message = "test \"movl reg -> reg\"");
    
    (in = "")
        << "movl %eax, (%eax)\n"
        << "movl %ebx, 2(%eax)\n"
        << "movl %eax, (%ebx, %eax)\n"
        << "movl %ecx, 6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, 0xBF000(,%esi,2)\n"
        << "movl %edi, (0x20)\n"
    ;
    (bin = "")
        << (char) 0x89 << (char) 0x00
        << (char) 0x89 << (char) 0x58                << (char) 0x02
        << (char) 0x89 << (char) 0x04 << (char) 0x03
        << (char) 0x89 << (char) 0x4C << (char) 0xAB << (char) 0x06
        << (char) 0x89 << (char) 0x14 << (char) 0xF9
        << (char) 0x89 << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        << (char) 0x89 << (char) 0x3D                << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
    ;
    (pretty = "")
        << "movl %eax, (%eax)\n"
        << "movl %ebx, 0x2(%eax)\n"
        << "movl %eax, (%ebx,%eax)\n"
        << "movl %ecx, 0x6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, 0xbf000(,%esi,2)\n"
        << "movl %edi, (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"movl reg -> indirect\"");
    
    return success;
}

bool MoveTest::testRM() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "movl (%eax), %eax\n"
        << "movl 5(%ebx), %eax\n"
        << "movl (%eax, %ecx), %ebx\n"
        << "movl 127(%ecx,%ebx,4), %ebp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xBF000(,%esi,2), %esp\n"
        << "movl (0x20), %edi\n"
    ;
    (bin = "")
        << (char) 0x8B << (char) 0x00
        << (char) 0x8B << (char) 0x43                << (char) 0x05
        << (char) 0x8B << (char) 0x1C << (char) 0x08
        << (char) 0x8B << (char) 0x6C << (char) 0x99 << (char) 0x7F
        << (char) 0x8B << (char) 0x0C << (char) 0xFA
        << (char) 0x8B << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        << (char) 0x8B << (char) 0x3D                << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
    ;
    (pretty = "")
        << "movl (%eax), %eax\n"
        << "movl 0x5(%ebx), %eax\n"
        << "movl (%eax,%ecx), %ebx\n"
        << "movl 0x7f(%ecx,%ebx,4), %ebp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xbf000(,%esi,2), %esp\n"
        << "movl (0x20), %edi\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"movl indirect -> reg\"");
    
    return success;
}

bool MoveTest::testFD() {
    success();
}

bool MoveTest::testTD() {
    success();
}

bool MoveTest::testOI() {
    success();
}

bool MoveTest::testMI() {
    success();
}
