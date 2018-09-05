#include "test/I386ASM/Instruction/HaltTest.hpp"

// public
HaltTest::HaltTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
HaltTest::~HaltTest() {};


bool HaltTest::runAll() {
    bool success = true;
    const char bin[] = {(char)0xf4, 0};
    success &= test("hlt", bin);
    success &= test("HLT", bin, "hlt\n");
    return success;
}
