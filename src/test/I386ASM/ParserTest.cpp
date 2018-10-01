#include "test/I386ASM/ParserTest.hpp"

// public
ParserTest::ParserTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
ParserTest::~ParserTest() {}


bool ParserTest::runAll() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "cga_lastline := 0xb8f00\n"
        << "_start:\n"
        << "    jmp _init\n"
        << "drawGtAddr: nop; nop; nop; nop\n"
        << "haltAddr: nop; nop; nop; nop\n"
        << "_init:\n"
        << "    movl cga_lastline, %eax\n"
        << "    addl 0x4a, %eax\n"
        << "    movl haltAddr, %ecx\n"
        << "    movl _halt, (%ecx)\n"
        << "    movl drawGtAddr, %ecx\n"
        << "    movl drawGT, (%ecx)\n"
        << "    movl drawLT, %edx\n"
        << "    jmp %edx\n"
        << "_halt:\n"
        << "    hlt\n"
        << "    jmp _halt\n"
        << "drawLT:\n"
        << "    movw 0x73c, (%eax)\n"
        << "    addl 4, %eax\n"
        << "    jmp drawAT\n"
        << "drawGT:\n"
        << "    addl 4, %eax\n"
        << "    movw 0x73e, (%eax)\n"
        << "    jmp (haltAddr)\n"
        << "drawAT:\n"
        << "    movw 0xf40, (%eax)\n"
        << "    addl 2, %eax\n"
        << "    movw 0xf40, (%eax)\n"
        << "    jmp (%ecx)\n"
    ;
    (bin = "")
                                                                                                // _start:
        << (char) 0xeb << (char) 0x08                                                             // jmp _init
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90                             // drawGtAddr:
        << (char) 0x90 << (char) 0x90 << (char) 0x90 << (char) 0x90                             // haltAddr:
                                                                                                // _init:
        << (char) 0xb8 << (char) 0x00 << (char) 0x8f << (char) 0x0b << (char) 0x00                // movl cga_lastline, %eax
        << (char) 0x05 << (char) 0x4a << (char) 0x00 << (char) 0x00 << (char) 0x00                // addl 0x4a, %eax
        << (char) 0xb9 << (char) 0x06 << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl haltAddr, %ecx
        << (char) 0xc7 << (char) 0x01 << (char) 0x31 << (char) 0x00 << (char) 0x00 << (char) 0x00 // movl _halt, (%ecx)
        << (char) 0xb9 << (char) 0x02 << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl drawGtAddr, %ecx
        << (char) 0xc7 << (char) 0x01 << (char) 0x40 << (char) 0x00 << (char) 0x00 << (char) 0x00 // movl drawGT, (%ecx)
        << (char) 0xba << (char) 0x34 << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl drawLT, %ecx
        << (char) 0xff << (char) 0xe2                                                             // jmp %edx
                                                                                                // _halt:
        << (char) 0xf4                                                                            // hlt
        << (char) 0xeb << (char) 0xfd                                                             // jmp _halt
                                                                                                // drawLT:
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x3c << (char) 0x07                // movw 0x73c, (%eax)
        << (char) 0x05 << (char) 0x04 << (char) 0x00 << (char) 0x00 << (char) 0x00                // addl 4, %eax
        << (char) 0xeb << (char) 0x10                                                             // jmp drawAT
                                                                                                // drawGT:
        << (char) 0x05 << (char) 0x04 << (char) 0x00 << (char) 0x00 << (char) 0x00                // addl 4, %eax
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x3e << (char) 0x07                // movw 0x73e, (%eax)
        << (char) 0xff << (char) 0x25 << (char) 0x06 << (char) 0x00 << (char) 0x00 << (char) 0x00 // jmp (haltAddr)
                                                                                                // drawAT:
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x40 << (char) 0x0f                // movw 0xf40, (%eax)
        << (char) 0x05 << (char) 0x02 << (char) 0x00 << (char) 0x00 << (char) 0x00                // addl 2, %eax
        << (char) 0x66 << (char) 0xc7 << (char) 0x00 << (char) 0x40 << (char) 0x0f                // movw 0xf40, (%eax)
        << (char) 0xff << (char) 0x21                                                             // jmp (%ecx)
    ; 
    (pretty = "")
        << "_start:\n"
        << "jmp _init\n"
        << "drawGtAddr:\n"
        << "nop\n"
        << "nop\n"
        << "nop\n"
        << "nop\n"
        << "haltAddr:\n"
        << "nop\n"
        << "nop\n"
        << "nop\n"
        << "nop\n"
        << "_init:\n"
        << "movl 0xb8f00, %eax\n"
        << "addl 0x4a, %eax\n"
        << "movl haltAddr, %ecx\n"
        << "movl _halt, (%ecx)\n"
        << "movl drawGtAddr, %ecx\n"
        << "movl drawGT, (%ecx)\n"
        << "movl drawLT, %edx\n"
        << "jmp %edx\n"
        << "_halt:\n"
        << "hlt\n"
        << "jmp _halt\n"
        << "drawLT:\n"
        << "movw 0x73c, (%eax)\n"
        << "addl 0x4, %eax\n"
        << "jmp drawAT\n"
        << "drawGT:\n"
        << "addl 0x4, %eax\n"
        << "movw 0x73e, (%eax)\n"
        << "jmp (haltAddr)\n"
        << "drawAT:\n"
        << "movw 0xf40, (%eax)\n"
        << "addl 0x2, %eax\n"
        << "movw 0xf40, (%eax)\n"
        << "jmp (%ecx)\n"
    ;
    
    success &= test(in, bin, pretty, message = "\"< @@ >\"-Test");
    return success;
}
