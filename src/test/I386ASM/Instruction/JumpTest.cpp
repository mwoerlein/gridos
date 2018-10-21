#include "test/I386ASM/Instruction/JumpTest.hpp"

// public
JumpTest::JumpTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
JumpTest::~JumpTest() {};

bool JumpTest::runAll() {
    bool success = true;
    
    success &= testRelative();
    success &= testIndirect();
    
    return success;
}

// test cases
bool JumpTest::testRelative() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "startDef:=0x10000\n"
        << "start:\n"
        << "jmp near_start\n" // 0 <= offset <= 127
        << "jmp end\n" // 127 < offset <= 32767
        << "jmp 0x10025\n" // 0 <= offset <= 127
        << "jmp 0x10095\n" // 127 < offset <= 32767
        << "jmp 0x1ffff\n" // 32767 < offset
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_start:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_end:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "end:\n"
        << "jmp near_end\n" // -128 <= offset <= 0
        << "jmp start\n" // -32768 <= offset < -128
        << "jmp 0x1007e\n" // -128 <= offset <= 0
        << "jmp startDef\n" // -32768 <= offset < -128
        << "jmp 0x0\n" // offset < -32768
    ;
    (bin = "")
        << (char) 0xEB << (char) 0x23
        << (char) 0x66 << (char) 0xE9 << (char) 0x8F << (char) 0x00
        << (char) 0xE9 << (char) 0x1A << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xE9 << (char) 0x85 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xE9 << (char) 0xEA << (char) 0xFF << (char) 0x00 << (char) 0x00
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0xEB << (char) 0xEE
        << (char) 0x66 << (char) 0xE9 << (char) 0x65 << (char) 0xFF
        << (char) 0xE9 << (char) 0xDE << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0xE9 << (char) 0x5B << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0xE9 << (char) 0x56 << (char) 0xFF << (char) 0xFE << (char) 0xFF
    ;
    (pretty = "")
        << ".code32\n"
        << "start:\n"
        << "jmp near_start\n" // 0 <= offset <= 127
        << "jmp end\n" // 127 < offset <= 32767
        << "jmp 0x10025\n" // 0 <= offset <= 127
        << "jmp 0x10095\n" // 127 < offset <= 32767
        << "jmp 0x1ffff\n" // 32767 < offset
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_start:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_end:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "end:\n"
        << "jmp near_end\n" // -128 <= offset <= 0
        << "jmp start\n" // -32768 <= offset < -128
        << "jmp 0x1007e\n" // -128 <= offset <= 0
        << "jmp 0x10000\n" // -32768 <= offset < -128
        << "jmp 0x0\n" // offset < -32768
    ;
    
    success &= test(in, bin, pretty, message = "test \"jmp relative (32bit)\"", 0x10000);
    
    (in = "")
        << ".code16\n"
        << "startDef:=0x10000\n"
        << "start:\n"
        << "jmp near_start\n" // 0 <= offset <= 127
        << "jmp end\n" // 127 < offset <= 32767
        << "jmp 0x10025\n" // 0 <= offset <= 127
        << "jmp 0x10095\n" // 127 < offset <= 32767
        << "jmp 0x1ffff\n" // 32767 < offset
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_start:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_end:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "end:\n"
        << "jmp near_end\n" // -128 <= offset <= 0
        << "jmp start\n" // -32768 <= offset < -128
        << "jmp 0x1007e\n" // -128 <= offset <= 0
        << "jmp startDef\n" // -32768 <= offset < -128
        << "jmp 0x0\n" // offset < -32768
    ;
    (bin = "")
        << (char) 0xEB << (char) 0x25
        << (char) 0xE9 << (char) 0x92 << (char) 0x00
        << (char) 0x66 << (char) 0xE9 << (char) 0x1A << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xE9 << (char) 0x84 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xE9 << (char) 0xE8 << (char) 0xFF << (char) 0x00 << (char) 0x00
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0xEB << (char) 0xEE
        << (char) 0xE9 << (char) 0x64 << (char) 0xFF
        << (char) 0x66 << (char) 0xE9 << (char) 0xDC << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x66 << (char) 0xE9 << (char) 0x58 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0x66 << (char) 0xE9 << (char) 0x52 << (char) 0xFF << (char) 0xFE << (char) 0xFF
    ;
    (pretty = "")
        << ".code16\n"
        << "start:\n"
        << "jmp near_start\n" // 0 <= offset <= 127
        << "jmp end\n" // 127 < offset <= 32767
        << "jmp 0x10025\n" // 0 <= offset <= 127
        << "jmp 0x10095\n" // 127 < offset <= 32767
        << "jmp 0x1ffff\n" // 32767 < offset
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_start:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "near_end:\n"
        << "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"
        << "end:\n"
        << "jmp near_end\n" // -128 <= offset <= 0
        << "jmp start\n" // -32768 <= offset < -128
        << "jmp 0x1007e\n" // -128 <= offset <= 0
        << "jmp 0x10000\n" // -32768 <= offset < -128
        << "jmp 0x0\n" // offset < -32768
    ;
    
    success &= test(in, bin, pretty, message = "test \"jmp relative (16bit)\"", 0x10000);
    
    return success;
}

bool JumpTest::testIndirect() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << ".code32\n"
        << "jmp %ebx\n"
        << "jmp (%ecx)\n"
        << "jmp 0x2(%ecx,%eax)\n"
        << "jmp 0x200(%edx,%eax,4)\n"
        << "jmp (0x1e)\n"
        
        << "jmp %bx\n"
        << "jmp (%bp)\n"
        << "jmp (%di)\n"
        << "jmp (%bp,%di)\n"
        << "jmp 0x2(%bx,%si)\n"
        << "jmp 0xabcd(%si)\n"
        << ".addr16 jmp (0x16)\n"
    ;
    (bin = "")
        << (char) 0xFF << (char) 0xE3
        << (char) 0xFF << (char) 0x21
        << (char) 0xFF << (char) 0x64 << (char) 0x01 << (char) 0x02
        << (char) 0xFF << (char) 0xA4 << (char) 0x82 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0xFF << (char) 0x25 << (char) 0x1E << (char) 0x00 << (char) 0x00 << (char) 0x00
        
        << (char) 0x66 << (char) 0xFF << (char) 0xE3
        << (char) 0x67 << (char) 0xFF << (char) 0x66 << (char) 0x00
        << (char) 0x67 << (char) 0xFF << (char) 0x25
        << (char) 0x67 << (char) 0xFF << (char) 0x23
        << (char) 0x67 << (char) 0xFF << (char) 0x60 << (char) 0x02
        << (char) 0x67 << (char) 0xFF << (char) 0xA4 << (char) 0xCD << (char) 0xAB
        << (char) 0x67 << (char) 0xFF << (char) 0x26 << (char) 0x16 << (char) 0x00
    ;
   
    success &= test(in, bin, in, message = "test \"jmp indirect (32bit)\"");
    
    (in = "")
        << ".code16\n"
        << "jmp %ebx\n"
        << "jmp (%ecx)\n"
        << "jmp 0x2(%ecx,%eax)\n"
        << "jmp 0x200(%edx,%eax,4)\n"
        << ".addr32 jmp (0x1e)\n"
        
        << "jmp %bx\n"
        << "jmp (%bp)\n"
        << "jmp (%di)\n"
        << "jmp (%bp,%di)\n"
        << "jmp 0x2(%bx,%si)\n"
        << "jmp 0xabcd(%si)\n"
        << "jmp (0x16)\n"
    ;
    (bin = "")
        << (char) 0x66 << (char) 0xFF << (char) 0xE3
        << (char) 0x67 << (char) 0xFF << (char) 0x21
        << (char) 0x67 << (char) 0xFF << (char) 0x64 << (char) 0x01 << (char) 0x02
        << (char) 0x67 << (char) 0xFF << (char) 0xA4 << (char) 0x82 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xFF << (char) 0x25 << (char) 0x1E << (char) 0x00 << (char) 0x00 << (char) 0x00
        
        << (char) 0xFF << (char) 0xE3
        << (char) 0xFF << (char) 0x66 << (char) 0x00
        << (char) 0xFF << (char) 0x25
        << (char) 0xFF << (char) 0x23
        << (char) 0xFF << (char) 0x60 << (char) 0x02
        << (char) 0xFF << (char) 0xA4 << (char) 0xCD << (char) 0xAB
        << (char) 0xFF << (char) 0x26 << (char) 0x16 << (char) 0x00
    ;
   
    success &= test(in, bin, in, message = "test \"jmp indirect (16bit)\"");
    
    return success;
}
