#include "test/I386ASM/Instruction/NoOperandInstructionTest.hpp"

// public
NoOperandInstructionTest::NoOperandInstructionTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
NoOperandInstructionTest::~NoOperandInstructionTest() {};


bool NoOperandInstructionTest::runAll() {
    bool success = true;
    
    {
        const char bin[] = {(char)0xf4, 0};
        success &= test("HLT", bin, "hlt\n");
    }
    
    {
        const char bin[] = {(char)0xfa, 0};
        success &= test("ClI", bin, "cli\n");
    }
    
    {
        const char bin[] = {(char)0xfb, 0};
        success &= test("STi", bin, "sti\n");
    }
    
    {
        const char bin[] = {(char)0x90, 0};
        success &= test("nOP", bin, "nop\n");
    }
    
    return success;
}
