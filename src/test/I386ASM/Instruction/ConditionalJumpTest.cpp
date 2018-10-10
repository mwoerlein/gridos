#include "test/I386ASM/Instruction/ConditionalJumpTest.hpp"

// public
ConditionalJumpTest::ConditionalJumpTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
ConditionalJumpTest::~ConditionalJumpTest() {};

bool ConditionalJumpTest::runAll() {
    bool success = true;
    
    success &= testD();
    
    return success;
}

// test cases
bool ConditionalJumpTest::testD() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << ".code32\n"
        << "start:\n"
        << "ja start\n"
        << "jae end\n"
        << "jb start\n"
        << "jbe end\n"
        << "jc start\n"
        << "je end\n"
        << "jg start\n"
        << "jge end\n"
        << "jl start\n"
        << "jle end\n"
        << "jo start\n"
        << "jp end\n"
        << "js start\n"
        << "jz end\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "jna start\n"
        << "jnae end\n"
        << "jnb start\n"
        << "jnbe end\n"
        << "jnc start\n"
        << "jne end\n"
        << "jng start\n"
        << "jnge end\n"
        << "jnl start\n"
        << "jnle end\n"
        << "jno start\n"
        << "jnp end\n"
        << "jns start\n"
        << "jnz end\n"
        << "jpe start\n"
        << "jpo end\n"
        << "end:\n"
        << "jcxz end\n"
        << "jecxz end\n"
    ;
    (bin = "")
        << (char) 0x77 << (char) 0xFE
        << (char) 0x66 << (char) 0x0F << (char) 0x83 << (char) 0xC2 << (char) 0x00
        << (char) 0x72 << (char) 0xF7
        << (char) 0x66 << (char) 0x0F << (char) 0x86 << (char) 0xBB << (char) 0x00
        << (char) 0x72 << (char) 0xF0
        << (char) 0x66 << (char) 0x0F << (char) 0x84 << (char) 0xB4 << (char) 0x00
        << (char) 0x7F << (char) 0xE9
        << (char) 0x66 << (char) 0x0F << (char) 0x8D << (char) 0xAD << (char) 0x00
        << (char) 0x7C << (char) 0xE2
        << (char) 0x66 << (char) 0x0F << (char) 0x8E << (char) 0xA6 << (char) 0x00
        << (char) 0x70 << (char) 0xDB
        << (char) 0x66 << (char) 0x0F << (char) 0x8A << (char) 0x9F << (char) 0x00
        << (char) 0x78 << (char) 0xD4
        << (char) 0x66 << (char) 0x0F << (char) 0x84 << (char) 0x98 << (char) 0x00
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x66 << (char) 0x0F << (char) 0x86 << (char) 0x6A << (char) 0xFF
        << (char) 0x72 << (char) 0x31
        << (char) 0x66 << (char) 0x0F << (char) 0x83 << (char) 0x63 << (char) 0xFF
        << (char) 0x77 << (char) 0x2A
        << (char) 0x66 << (char) 0x0F << (char) 0x83 << (char) 0x5C << (char) 0xFF
        << (char) 0x75 << (char) 0x23
        << (char) 0x66 << (char) 0x0F << (char) 0x8E << (char) 0x55 << (char) 0xFF
        << (char) 0x7C << (char) 0x1C
        << (char) 0x66 << (char) 0x0F << (char) 0x8D << (char) 0x4E << (char) 0xFF
        << (char) 0x7F << (char) 0x15
        << (char) 0x66 << (char) 0x0F << (char) 0x81 << (char) 0x47 << (char) 0xFF
        << (char) 0x7B << (char) 0x0E
        << (char) 0x66 << (char) 0x0F << (char) 0x89 << (char) 0x40 << (char) 0xFF
        << (char) 0x75 << (char) 0x07
        << (char) 0x66 << (char) 0x0F << (char) 0x8A << (char) 0x39 << (char) 0xFF
        << (char) 0x7B << (char) 0x00
        << (char) 0x67 << (char) 0xE3 << (char) 0xFD
        << (char) 0xE3 << (char) 0xFB
    ;
    
    success &= test(in, bin, in, message = "test \"conditional jump\"");
    
    return success;
}
