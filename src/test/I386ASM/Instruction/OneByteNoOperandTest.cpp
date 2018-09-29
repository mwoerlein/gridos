#include "test/I386ASM/Instruction/OneByteNoOperandTest.hpp"

// public
OneByteNoOperandTest::OneByteNoOperandTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
OneByteNoOperandTest::~OneByteNoOperandTest() {};


bool OneByteNoOperandTest::runAll() {
    bool success = true;
    
    {
        const char bin[] = {(char)0xf4, 0};
        success &= test("hlt", bin);
        success &= test("HLT", bin, "hlt\n");
    }
    
    {
        const char bin[] = {(char)0xfa, 0};
        success &= test("cli", bin);
        success &= test("ClI", bin, "cli\n");
    }
    
    {
        const char bin[] = {(char)0xfb, 0};
        success &= test("sti", bin);
        success &= test("STi", bin, "sti\n");
    }
    
    return success;
}
