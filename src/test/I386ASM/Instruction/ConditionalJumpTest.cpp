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
        << (char) 0x0F << (char) 0x83 << (char) 0xD0 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x72 << (char) 0xF6
        << (char) 0x0F << (char) 0x86 << (char) 0xC8 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x72 << (char) 0xEE
        << (char) 0x0F << (char) 0x84 << (char) 0xC0 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x7F << (char) 0xE6
        << (char) 0x0F << (char) 0x8D << (char) 0xB8 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x7C << (char) 0xDE
        << (char) 0x0F << (char) 0x8E << (char) 0xB0 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x70 << (char) 0xD6
        << (char) 0x0F << (char) 0x8A << (char) 0xA8 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x78 << (char) 0xCE
        << (char) 0x0F << (char) 0x84 << (char) 0xA0 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x0F << (char) 0x86 << (char) 0x62 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x72 << (char) 0x38
        << (char) 0x0F << (char) 0x83 << (char) 0x5A << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x77 << (char) 0x30
        << (char) 0x0F << (char) 0x83 << (char) 0x52 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x75 << (char) 0x28
        << (char) 0x0F << (char) 0x8E << (char) 0x4A << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x7C << (char) 0x20
        << (char) 0x0F << (char) 0x8D << (char) 0x42 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x7F << (char) 0x18
        << (char) 0x0F << (char) 0x81 << (char) 0x3A << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x7B << (char) 0x10
        << (char) 0x0F << (char) 0x89 << (char) 0x32 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x75 << (char) 0x08
        << (char) 0x0F << (char) 0x8A << (char) 0x2A << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x7B << (char) 0x00
        << (char) 0x67 << (char) 0xE3 << (char) 0xFD
        << (char) 0xE3 << (char) 0xFB
    ;
    
    success &= test(in, bin, in, message = "test \"conditional jump (32bit)\"");
    
    (in = "")
        << ".code16\n"
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
        << (char) 0x0F << (char) 0x83 << (char) 0xB4 << (char) 0x00
        << (char) 0x72 << (char) 0xF8
        << (char) 0x0F << (char) 0x86 << (char) 0xAE << (char) 0x00
        << (char) 0x72 << (char) 0xF2
        << (char) 0x0F << (char) 0x84 << (char) 0xA8 << (char) 0x00
        << (char) 0x7F << (char) 0xEC
        << (char) 0x0F << (char) 0x8D << (char) 0xA2 << (char) 0x00
        << (char) 0x7C << (char) 0xE6
        << (char) 0x0F << (char) 0x8E << (char) 0x9C << (char) 0x00
        << (char) 0x70 << (char) 0xE0
        << (char) 0x0F << (char) 0x8A << (char) 0x96 << (char) 0x00
        << (char) 0x78 << (char) 0xDA
        << (char) 0x0F << (char) 0x84 << (char) 0x90 << (char) 0x00
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x0F << (char) 0x86 << (char) 0x72 << (char) 0xFF
        << (char) 0x72 << (char) 0x2A
        << (char) 0x0F << (char) 0x83 << (char) 0x6C << (char) 0xFF
        << (char) 0x77 << (char) 0x24
        << (char) 0x0F << (char) 0x83 << (char) 0x66 << (char) 0xFF
        << (char) 0x75 << (char) 0x1E
        << (char) 0x0F << (char) 0x8E << (char) 0x60 << (char) 0xFF
        << (char) 0x7C << (char) 0x18
        << (char) 0x0F << (char) 0x8D << (char) 0x5A << (char) 0xFF
        << (char) 0x7F << (char) 0x12
        << (char) 0x0F << (char) 0x81 << (char) 0x54 << (char) 0xFF
        << (char) 0x7B << (char) 0x0C
        << (char) 0x0F << (char) 0x89 << (char) 0x4E << (char) 0xFF
        << (char) 0x75 << (char) 0x06
        << (char) 0x0F << (char) 0x8A << (char) 0x48 << (char) 0xFF
        << (char) 0x7B << (char) 0x00
        << (char) 0xE3 << (char) 0xFE
        << (char) 0x67 << (char) 0xE3 << (char) 0xFB
    ;
    
    success &= test(in, bin, in, message = "test \"conditional jump (16bit)\"");
    
    return success;
}
