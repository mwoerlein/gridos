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
        
        << "pusha\n"
        << "pushad\n"
        << "pushf\n"
        << "pushfd\n"
        << "popa\n"
        << "popad\n"
        << "popf\n"
        << "popfd\n"
        << "lodsb\n"
        << "lodsw\n"
        << "lodsd\n"
        
        << ".code16\n"
        << "pusha\n"
        << "pushad\n"
        << "pushf\n"
        << "pushfd\n"
        << "popa\n"
        << "popad\n"
        << "popf\n"
        << "popfd\n"
        << "lodsb\n"
        << "lodsw\n"
        << "lodsd\n"
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
        
        << (char) 0x66 << (char) 0x60
        << (char) 0x60
        << (char) 0x66 << (char) 0x9C
        << (char) 0x9C
        << (char) 0x66 << (char) 0x61
        << (char) 0x61
        << (char) 0x66 << (char) 0x9D
        << (char) 0x9D
        << (char) 0xAC
        << (char) 0x66 << (char) 0xAD
        << (char) 0xAD
        
        << (char) 0x60
        << (char) 0x66 << (char) 0x60
        << (char) 0x9C
        << (char) 0x66 << (char) 0x9C
        << (char) 0x61
        << (char) 0x66 << (char) 0x61
        << (char) 0x9D
        << (char) 0x66 << (char) 0x9D
        << (char) 0xAC
        << (char) 0xAD
        << (char) 0x66 << (char) 0xAD
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
        
        << "pushaw\n"
        << "pushal\n"
        << "pushfw\n"
        << "pushfl\n"
        << "popaw\n"
        << "popal\n"
        << "popfw\n"
        << "popfl\n"
        << "lodsb\n"
        << "lodsw\n"
        << "lodsl\n"
        
        << ".code16\n"
        << "pushaw\n"
        << "pushal\n"
        << "pushfw\n"
        << "pushfl\n"
        << "popaw\n"
        << "popal\n"
        << "popfw\n"
        << "popfl\n"
        << "lodsb\n"
        << "lodsw\n"
        << "lodsl\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"no operands\"");
    
    return success;
}
