#include "test/I386ASM/Instruction/InOutTest.hpp"

// public
InOutTest::InOutTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
InOutTest::~InOutTest() {};

bool InOutTest::runAll() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "in 1, %al\n"
        << "in 2, %ax\n"
        << "in 3, %eax\n"
        << "in %dx, %al\n"
        << "in %dx, %ax\n"
        << "in %dx, %eax\n"
        << ".code16\n"
        << "inb (1<<2), %al\n"
        << "inw (2+3), %ax\n"
        << "inl 128, %eax\n"
    ;
    (bin = "")
        << (char) 0xE4 << (char) 0x01
        << (char) 0x66 << (char) 0xE5 << (char) 0x02
        << (char) 0xE5 << (char) 0x03
        << (char) 0xEC
        << (char) 0x66 << (char) 0xED
        << (char) 0xED
        << (char) 0xE4 << (char) 0x04
        << (char) 0xE5 << (char) 0x05
        << (char) 0x66 << (char) 0xE5 << (char) 0x80
    ;
    (pretty = "")
        << ".code32\n"
        << "inb 0x1, %al\n"
        << "inw 0x2, %ax\n"
        << "inl 0x3, %eax\n"
        << "inb %dx, %al\n"
        << "inw %dx, %ax\n"
        << "inl %dx, %eax\n"
        << ".code16\n"
        << "inb 0x4, %al\n"
        << "inw 0x5, %ax\n"
        << "inl 0x80, %eax\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"in\"");
    
    (in = "")
        << "out %al, 255\n"
        << "out %ax, 254\n"
        << "out %eax, 253\n"
        << "out %al, %dx\n"
        << "out %ax, %dx\n"
        << "out %eax, %dx\n"
        << ".code16\n"
        << "outb %al, (255>>1)\n"
        << "outw %ax, (255-22)\n"
        << "outl %eax, 200\n"
    ;
    (bin = "")
        << (char) 0xE6 << (char) 0xFF
        << (char) 0x66 << (char) 0xE7 << (char) 0xFE
        << (char) 0xE7 << (char) 0xFD
        << (char) 0xEE
        << (char) 0x66 << (char) 0xEF
        << (char) 0xEF
        << (char) 0xE6 << (char) 0x7F
        << (char) 0xE7 << (char) 0xE9
        << (char) 0x66 << (char) 0xE7 << (char) 0xC8
    ;
    (pretty = "")
        << ".code32\n"
        << "outb %al, 0xff\n"
        << "outw %ax, 0xfe\n"
        << "outl %eax, 0xfd\n"
        << "outb %al, %dx\n"
        << "outw %ax, %dx\n"
        << "outl %eax, %dx\n"
        << ".code16\n"
        << "outb %al, 0x7f\n"
        << "outw %ax, 0xe9\n"
        << "outl %eax, 0xc8\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"out\"");
    
    return success;
}
