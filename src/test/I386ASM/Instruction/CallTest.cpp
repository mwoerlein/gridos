#include "test/I386ASM/Instruction/CallTest.hpp"

// public
CallTest::CallTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
CallTest::~CallTest() {};

bool CallTest::runAll() {
    bool success = true;
    
    success &= testRelative();
    success &= testIndirect();
    
    return success;
}

// test cases
bool CallTest::testRelative() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "startDef:=0x10000\n"
        << "start:\n"
        << "call near_start\n" // 0 <= offset <= 127
        << "call end\n" // 127 < offset <= 32767
        << "call 0x10025\n" // 0 <= offset <= 127
        << "call 0x10095\n" // 127 < offset <= 32767
        << "call 0x1ffff\n" // 32767 < offset
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
        << "call near_end\n" // -128 <= offset <= 0
        << "call start\n" // -32768 <= offset < -128
        << "call 0x1007e\n" // -128 <= offset <= 0
        << "call startDef\n" // -32768 <= offset < -128
        << "call 0x0\n" // offset < -32768
    ;
    (bin = "")
        << (char) 0xE8 << (char) 0x24 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xE8 << (char) 0x8F << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xE8 << (char) 0x16 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xE8 << (char) 0x81 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0xE8 << (char) 0xE6 << (char) 0xFF << (char) 0x00 << (char) 0x00
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0xE8 << (char) 0xEB << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0xE8 << (char) 0x5D << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0xE8 << (char) 0xD6 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0xE8 << (char) 0x53 << (char) 0xFF << (char) 0xFF << (char) 0xFF
        << (char) 0xE8 << (char) 0x4E << (char) 0xFF << (char) 0xFE << (char) 0xFF
    ;
    (pretty = "")
        << ".code32\n"
        << "start:\n"
        << "call near_start\n" // 0 <= offset <= 127
        << "call end\n" // 127 < offset <= 32767
        << "call 0x10025\n" // 0 <= offset <= 127
        << "call 0x10095\n" // 127 < offset <= 32767
        << "call 0x1ffff\n" // 32767 < offset
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
        << "call near_end\n" // -128 <= offset <= 0
        << "call start\n" // -32768 <= offset < -128
        << "call 0x1007e\n" // -128 <= offset <= 0
        << "call 0x10000\n" // -32768 <= offset < -128
        << "call 0x0\n" // offset < -32768
    ;
    
    success &= test(in, bin, pretty, message = "test \"call relative (32bit)\"", 0x10000);
    
    (in = "")
        << ".code16\n"
        << "startDef:=0x1000\n"
        << "start:\n"
        << "call (near_start+16)\n" // 0 <= offset <= 127
        << "call ((end<<16)>>16)\n" // 127 < offset <= 32767
        << "call (startDef + 0x25)\n" // 0 <= offset <= 127
        << "call 0x1095\n" // 127 < offset <= 32767
        << "call 0x1fff\n" // 32767 < offset
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
        << "call near_end\n" // -128 <= offset <= 0
        << "call start\n" // -32768 <= offset < -128
        << "call 0x107e\n" // -128 <= offset <= 0
        << "call startDef\n" // -32768 <= offset < -128
        << "call 0x0\n" // offset < -32768
    ;
    (bin = "")
        << (char) 0xE8 << (char) 0x2C << (char) 0x00
        << (char) 0xE8 << (char) 0x89 << (char) 0x00
        << (char) 0xE8 << (char) 0x1C << (char) 0x00
        << (char) 0xE8 << (char) 0x89 << (char) 0x00
        << (char) 0xE8 << (char) 0xF0 << (char) 0x0F
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90
        << (char) 0xE8 << (char) 0xED << (char) 0xFF
        << (char) 0xE8 << (char) 0x6B << (char) 0xFF
        << (char) 0xE8 << (char) 0xE6 << (char) 0xFF
        << (char) 0xE8 << (char) 0x65 << (char) 0xFF
        << (char) 0xE8 << (char) 0x62 << (char) 0xEF
    ;
    (pretty = "")
        << ".code16\n"
        << "start:\n"
        << "call (near_start+0x10)\n" // 0 <= offset <= 127
        << "call ((end<<0x10)>>0x10)\n" // 127 < offset <= 32767
        << "call 0x1025\n" // 0 <= offset <= 127
        << "call 0x1095\n" // 127 < offset <= 32767
        << "call 0x1fff\n" // 32767 < offset
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
        << "call near_end\n" // -128 <= offset <= 0
        << "call start\n" // -32768 <= offset < -128
        << "call 0x107e\n" // -128 <= offset <= 0
        << "call 0x1000\n" // -32768 <= offset < -128
        << "call 0x0\n" // offset < -32768
    ;
    
    success &= test(in, bin, pretty, message = "test \"call relative (16bit)\"", 0x1000);
    
    return success;
}

bool CallTest::testIndirect() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << ".code32\n"
        << "call %ebx\n"
        << "call (%ecx)\n"
        << "call 0x2(%ecx,%eax)\n"
        << "call 0x200(%edx,%eax,4)\n"
        << "call (0x1e)\n"
        
        << "call %bx\n"
        << "call (%bp)\n"
        << "call (%di)\n"
        << "call (%bp,%di)\n"
        << "call 0x2(%bx,%si)\n"
        << "call 0xabcd(%si)\n"
        << ".addr16 call (0x16)\n"
    ;
    (bin = "")
        << (char) 0xFF << (char) 0xD3
        << (char) 0xFF << (char) 0x11
        << (char) 0xFF << (char) 0x54 << (char) 0x01 << (char) 0x02
        << (char) 0xFF << (char) 0x94 << (char) 0x82 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0xFF << (char) 0x15 << (char) 0x1E << (char) 0x00 << (char) 0x00 << (char) 0x00
        
        << (char) 0x66 << (char) 0xFF << (char) 0xD3
        << (char) 0x67 << (char) 0xFF << (char) 0x56 << (char) 0x00
        << (char) 0x67 << (char) 0xFF << (char) 0x15
        << (char) 0x67 << (char) 0xFF << (char) 0x13
        << (char) 0x67 << (char) 0xFF << (char) 0x50 << (char) 0x02
        << (char) 0x67 << (char) 0xFF << (char) 0x94 << (char) 0xCD << (char) 0xAB
        << (char) 0x67 << (char) 0xFF << (char) 0x16 << (char) 0x16 << (char) 0x00
    ;
   
    success &= test(in, bin, in, message = "test \"call indirect (32bit)\"");
    
    (in = "")
        << ".code16\n"
        << "call %ebx\n"
        << "call (%ecx)\n"
        << "call 0x2(%ecx,%eax)\n"
        << "call 0x200(%edx,%eax,4)\n"
        << ".addr32 call (0x1e)\n"
        
        << "call %bx\n"
        << "call (%bp)\n"
        << "call (%di)\n"
        << "call (%bp,%di)\n"
        << "call 0x2(%bx,%si)\n"
        << "call 0xabcd(%si)\n"
        << "call (0x16)\n"
    ;
    (bin = "")
        << (char) 0x66 << (char) 0xFF << (char) 0xD3
        << (char) 0x67 << (char) 0xFF << (char) 0x11
        << (char) 0x67 << (char) 0xFF << (char) 0x54 << (char) 0x01 << (char) 0x02
        << (char) 0x67 << (char) 0xFF << (char) 0x94 << (char) 0x82 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xFF << (char) 0x15 << (char) 0x1E << (char) 0x00 << (char) 0x00 << (char) 0x00
        
        << (char) 0xFF << (char) 0xD3
        << (char) 0xFF << (char) 0x56 << (char) 0x00
        << (char) 0xFF << (char) 0x15
        << (char) 0xFF << (char) 0x13
        << (char) 0xFF << (char) 0x50 << (char) 0x02
        << (char) 0xFF << (char) 0x94 << (char) 0xCD << (char) 0xAB
        << (char) 0xFF << (char) 0x16 << (char) 0x16 << (char) 0x00
    ;
   
    success &= test(in, bin, in, message = "test \"call indirect (16bit)\"");
    
    return success;
}
