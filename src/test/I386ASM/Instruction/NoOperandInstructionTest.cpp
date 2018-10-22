#include "test/I386ASM/Instruction/NoOperandInstructionTest.hpp"

// public
NoOperandInstructionTest::NoOperandInstructionTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
NoOperandInstructionTest::~NoOperandInstructionTest() {};


bool NoOperandInstructionTest::runAll() {
    bool success = true;
    
    {
        const char bin[] = {(char)0xf4, 0};
        success &= test("HLT", bin, ".code32\nhlt\n");
    }
    
    {
        const char bin[] = {(char)0xfa, 0};
        success &= test("ClI", bin, ".code32\ncli\n");
    }
    
    {
        const char bin[] = {(char)0xfb, 0};
        success &= test("STi", bin, ".code32\nsti\n");
    }
    
    {
        const char bin[] = {(char)0x90, 0};
        success &= test("nOP", bin, ".code32\nnop\n");
    }
    
    {
        const char bin[] = {(char)0xCE, 0};
        success &= test("Int0", bin, ".code32\nint0\n");
    }
    
    {
        const char bin[] = {(char)0xF1, 0};
        success &= test("iNt1", bin, ".code32\nint1\n");
    }
    
    {
        const char bin[] = {(char)0xCC, 0};
        success &= test("InT3", bin, ".code32\nint3\n");
    }
    
    return success;
}
