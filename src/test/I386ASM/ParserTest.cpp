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

    (in = "")
        << "cga_lastline := 0xb8f00\n"
        << "blinking:\n"
        << "    movl 0, %ebx // column = 0\n"
        << "    movl 0, %ecx // charOffset = 0\n"
        << "blinking_loop:\n"
        << "    // charTmp = charOffset\n"
        << "    movl %ecx, %eax\n"
        << "    // show 'a'+charOffset at column\n"
        << "    addl 0x761, %ecx\n"
        << "    movw %cx, cga_lastline(,%ebx,2)\n"
        << "    // charOffset = (charTmp + 1) % 26\n"
        << "    addl 1, %eax\n"
        << "    movl 26, %ecx\n"
        << "    divb %cl; movb %ah, %cl\n"
        << "    //movw 0, %dx; divw %cx; movw %dx, %cx\n"
        << "    //movl 0, %edx; divl %ecx; movl %edx, %ecx\n"
        << "    // column = (column + 1) % 80\n"
        << "    movl %ebx, %eax\n"
        << "    addl 1, %eax\n"
        << "    movl 80, %ebx\n"
        << "    divb %bl; movb %ah, %bl\n"
        << "    //movw 0, %dx; divw %bx; movw %dx, %bx\n"
        << "    //movl 0, %edx; divl %ebx; movl %edx, %ebx\n"
        << "    // wait a bit\n"
        << "    movl 0x3fffff, %eax\n"    
        << "wait:\n"
        << "    addl -1, %eax\n"
        << "    jnz wait\n"
        << "    // endless loop\n"
        << "    jmp blinking_loop\n"
    ;
    
    (bin = "")
                                                                                                // blinking:
        << (char) 0xbb << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl 0, %ebx
        << (char) 0xb9 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl 0, %ecx
                                                                                                // blinking_loop:
        << (char) 0x89 << (char) 0xc8                                                             // movl %ecx, %eax
        << (char) 0x81 << (char) 0xc1 << (char) 0x61 << (char) 0x07 << (char) 0x00 << (char) 0x00 // addl 0x761, %ecx
        << (char) 0x66 << (char) 0x89 << (char) 0x0c << (char) 0x5d                               // movw %cx, cga_lastline(,%ebx,2)
                       << (char) 0x00 << (char) 0x8f << (char) 0x0b << (char) 0x00                // 
        << (char) 0x05 << (char) 0x01 << (char) 0x00 << (char) 0x00 << (char) 0x00                // addl 1, %eax
        << (char) 0xb9 << (char) 0x1a << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl 26, %ecx
        << (char) 0xf6 << (char) 0xf1                                                             // divb %cl
        << (char) 0x88 << (char) 0xe1                                                             // movb %ah, %cl

        << (char) 0x89 << (char) 0xd8                                                             // movl %ebx, %eax
        << (char) 0x05 << (char) 0x01 << (char) 0x00 << (char) 0x00 << (char) 0x00                // addl 1, %eax
        << (char) 0xbb << (char) 0x50 << (char) 0x00 << (char) 0x00 << (char) 0x00                // movl 80, %ebx
        << (char) 0xf6 << (char) 0xf3                                                             // divb %bl
        << (char) 0x88 << (char) 0xe3                                                             // movb %ah, %bl

        << (char) 0xb8 << (char) 0xff << (char) 0xff << (char) 0x3f << (char) 0x00                // movl 0x3fffff, %eax
                                                                                                // wait:
        << (char) 0x05 << (char) 0xff << (char) 0xff << (char) 0xff << (char) 0xff                // addl -1, %eax
        << (char) 0x75 << (char) 0xf9                                                             // jnz wait
        << (char) 0xeb << (char) 0xc4                                                             // jmp blinking_loop
    ;
     
    (pretty = "")
        << "blinking:\n"
        << "movl 0x0, %ebx\n"
        << "movl 0x0, %ecx\n"
        << "blinking_loop:\n"
        << "movl %ecx, %eax\n"
        << "addl 0x761, %ecx\n"
        << "movw %cx, 0xb8f00(,%ebx,2)\n"
        << "addl 0x1, %eax\n"
        << "movl 0x1a, %ecx\n"
        << "divb %cl\n"
        << "movb %ah, %cl\n"
        << "movl %ebx, %eax\n"
        << "addl 0x1, %eax\n"
        << "movl 0x50, %ebx\n"
        << "divb %bl\n"
        << "movb %ah, %bl\n"
        << "movl 0x3fffff, %eax\n"
        << "wait:\n"
        << "addl 0xffffffff, %eax\n"
        << "jnz wait\n"
        << "jmp blinking_loop\n"
    ;
    
    success &= test(in, bin, pretty, message = "\"Blinking\"-Test");

    return success;
}
