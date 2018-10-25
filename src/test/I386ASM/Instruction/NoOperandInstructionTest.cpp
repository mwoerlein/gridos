#include "test/I386ASM/Instruction/NoOperandInstructionTest.hpp"

// public
NoOperandInstructionTest::NoOperandInstructionTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
NoOperandInstructionTest::~NoOperandInstructionTest() {};


bool NoOperandInstructionTest::runAll() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "HLT\n"
        << "Clc\n"
        << "ClD\n"
        << "ClI\n"
        << "Clts\n"
        << "STC\n"
        << "STd\n"
        << "STi\n"
        << "nOP\n"
        << "Int0\n"
        << "iNt1\n"
        << "InT3\n"
    ;
    (bin = "")
        << (char) 0xF4
        << (char) 0xF8
        << (char) 0xFC
        << (char) 0xFA
        << (char) 0x0F << (char) 0x06
        << (char) 0xF9
        << (char) 0xFD
        << (char) 0xFB
        << (char) 0x90
        << (char) 0xCE
        << (char) 0xF1
        << (char) 0xCC
    ; 
    (pretty = "")
        << ".code32\n"
        << "hlt\n"
        << "clc\n"
        << "cld\n"
        << "cli\n"
        << "clts\n"
        << "stc\n"
        << "std\n"
        << "sti\n"
        << "nop\n"
        << "int0\n"
        << "int1\n"
        << "int3\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"no operands\"");
    
    return success;
}
