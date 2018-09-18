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
    */
    success &= testOI();
    success &= testMI();
    
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
        << "mov %eax, %eax\n"
        << "mov %al, %bh\n"
        << "mov %bx, %ax\n"
        << "movw %cx, %bx\n"
        << "movb %dh, %cl\n"
        << "movl %edi, %edx\n"
        << "movl %esi, %edi\n"
        << "movl %ebp, %esi\n"
        << "movl %esp, %ebp\n"
        << "movl %esp, %esp\n"
    ;
    (bin = "")
        << (char) 0x89 << (char) 0xC0
        << (char) 0x88 << (char) 0xC7
        << (char) 0x66 << (char) 0x89 << (char) 0xD8
        << (char) 0x66 << (char) 0x89 << (char) 0xCB
        << (char) 0x88 << (char) 0xF1
        << (char) 0x89 << (char) 0xFA
        << (char) 0x89 << (char) 0xF7
        << (char) 0x89 << (char) 0xEE
        << (char) 0x89 << (char) 0xE5
        << (char) 0x89 << (char) 0xE4
    ;
    (pretty = "")
        << "movl %eax, %eax\n"
        << "movb %al, %bh\n"
        << "movw %bx, %ax\n"
        << "movw %cx, %bx\n"
        << "movb %dh, %cl\n"
        << "movl %edi, %edx\n"
        << "movl %esi, %edi\n"
        << "movl %ebp, %esi\n"
        << "movl %esp, %ebp\n"
        << "movl %esp, %esp\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"movl reg -> reg\"");
    
    (in = "")
        << "movb %al, (%eax)\n"
        << "movb %bh, 2(%eax)\n"
        << "movw %ax, (%ebx, %eax)\n"
        << "movw %cx, 6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, 0xBF000(,%esi,2)\n"
        << "movl %edi, (0x20)\n"
    ;
    (bin = "")
        << (char) 0x88 << (char) 0x00
        << (char) 0x88 << (char) 0x78                << (char) 0x02
        << (char) 0x66 << (char) 0x89 << (char) 0x04 << (char) 0x03
        << (char) 0x66 << (char) 0x89 << (char) 0x4C << (char) 0xAB << (char) 0x06
        << (char) 0x89 << (char) 0x14 << (char) 0xF9
        << (char) 0x89 << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        << (char) 0x89 << (char) 0x3D                << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
    ;
    (pretty = "")
        << "movb %al, (%eax)\n"
        << "movb %bh, 0x2(%eax)\n"
        << "movw %ax, (%ebx,%eax)\n"
        << "movw %cx, 0x6(%ebx,%ebp,4)\n"
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
        << "movb (%eax), %dl\n"
        << "movb 5(%ebx), %ch\n"
        << "movw (%eax, %ecx), %bx\n"
        << "movw 127(%ecx,%ebx,4), %bp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xBF000(,%esi,2), %esp\n"
        << "movl (0x20), %edi\n"
    ;
    (bin = "")
        << (char) 0x8A << (char) 0x10
        << (char) 0x8A << (char) 0x6B                << (char) 0x05
        << (char) 0x66 << (char) 0x8B << (char) 0x1C << (char) 0x08
        << (char) 0x66 << (char) 0x8B << (char) 0x6C << (char) 0x99 << (char) 0x7F
        << (char) 0x8B << (char) 0x0C << (char) 0xFA
        << (char) 0x8B << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        << (char) 0x8B << (char) 0x3D                << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
    ;
    (pretty = "")
        << "movb (%eax), %dl\n"
        << "movb 0x5(%ebx), %ch\n"
        << "movw (%eax,%ecx), %bx\n"
        << "movw 0x7f(%ecx,%ebx,4), %bp\n"
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
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "movb 0x0, %al\n"
        << "movb 0x1A, %bh\n"
        << "movw 1, %sp\n"
        << "movl 12345678, %esi\n"
    ;
    (bin = "")
        << (char) 0xB0 << (char) 0x00
        << (char) 0xB7 << (char) 0x1A
        << (char) 0x66 << (char) 0xBC << (char) 0x01 << (char) 0x00
        << (char) 0xBE << (char) 0x4E << (char) 0x61 << (char) 0xBC << (char) 0x00
    ;
    (pretty = "")
        << "movb 0x0, %al\n"
        << "movb 0x1a, %bh\n"
        << "movw 0x1, %sp\n"
        << "movl 0xbc614e, %esi\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"movl imm -> reg\"");
    
    return success;
}

bool MoveTest::testMI() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "movb 0x0, (%eax)\n"
        << "movb 0xFF, 2(%eax)\n"
        << "movw 12, (%ebx, %eax)\n"
        << "movw 1024, 6(%ebx,%ebp,4)\n"
        << "movl 0xC0FFEE, (%ecx,%edi,8)\n"
        << "movl 0xFEFE, 0xBF000(,%esi,2)\n"
        << "movl 0xFEFE, 0xBF000(%ebp,%eax,1)\n"
        << "movl 0xDEADBEEF, (0x20)\n"
    ;
    (bin = "")
        << (char) 0xC6 << (char) 0x00 << (char) 0x00
        << (char) 0xC6 << (char) 0x40 << (char) 0x02 << (char) 0xFF
        << (char) 0x66 << (char) 0xC7 << (char) 0x04 << (char) 0x03 << (char) 0x0C << (char) 0x00
        << (char) 0x66 << (char) 0xC7 << (char) 0x44 << (char) 0xAB << (char) 0x06 << (char) 0x00 << (char) 0x04
        << (char) 0xC7 << (char) 0x04 << (char) 0xF9 << (char) 0xEE << (char) 0xFF << (char) 0xC0 << (char) 0x00
        << (char) 0xC7 << (char) 0x04 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00 << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0xC7 << (char) 0x84 << (char) 0x05 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00 << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0xC7 << (char) 0x05 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE
    ;
    (pretty = "")
        << "movb 0x0, (%eax)\n"
        << "movb 0xff, 0x2(%eax)\n"
        << "movw 0xc, (%ebx,%eax)\n"
        << "movw 0x400, 0x6(%ebx,%ebp,4)\n"
        << "movl 0xc0ffee, (%ecx,%edi,8)\n"
        << "movl 0xfefe, 0xbf000(,%esi,2)\n"
        << "movl 0xfefe, 0xbf000(%ebp,%eax)\n"
        << "movl 0xdeadbeef, (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"movl imm -> indirect\"");
    
    return success;
}
