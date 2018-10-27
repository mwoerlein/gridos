#include "test/I386ASM/Instruction/PushPopTest.hpp"

// public
PushPopTest::PushPopTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
PushPopTest::~PushPopTest() {};

bool PushPopTest::runAll() {
    bool success = true;
    
    success &= testM();
    success &= testO();
    success &= testI();
    success &= testZO();
    
    return success;
}

// test cases
bool PushPopTest::testM() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "pushw (%eax)\n"
        << "push 2(%eax)\n"
        << "pushw (%ebx, %eax)\n"
        << "push 6(%ebx,%ebp,4)\n"
        << ".addr32 pushw (0x20)\n"
        
        << "pushl (%bx)\n"
        << "pushw 6(%bp,%si)\n"
        << ".addr16 pushl (0x20)\n"

        << "popw 2(%eax)\n"
        << "pop (%ebx, %eax)\n"
        << "popw (%ecx,%edi,8)\n"
        << "pop 0xBF000(,%esi,2)\n"
        << ".addr32 popw (0x20)\n"
        
        << "popl (%bp)\n"
        << "popw (%bx, %di)\n"
        << "popl (%di)\n"
        << ".addr16 popw (0x20)\n"
    ;
    (bin = "")
        << (char) 0x66 << (char) 0xFF << (char) 0x30
        << (char) 0xFF << (char) 0x70 << (char) 0x02
        << (char) 0x66 << (char) 0xFF << (char) 0x34 << (char) 0x03
        << (char) 0xFF << (char) 0x74 << (char) 0xAB << (char) 0x06
        << (char) 0x66 << (char) 0xFF << (char) 0x35 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xFF << (char) 0x37
        << (char) 0x66 << (char) 0x67 << (char) 0xFF << (char) 0x72 << (char) 0x06
        << (char) 0x67 << (char) 0xFF << (char) 0x36 << (char) 0x20 << (char) 0x00
        
        << (char) 0x66 << (char) 0x8F << (char) 0x40 << (char) 0x02
        << (char) 0x8F << (char) 0x04 << (char) 0x03
        << (char) 0x66 << (char) 0x8F << (char) 0x04 << (char) 0xF9
        << (char) 0x8F << (char) 0x04 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        << (char) 0x66 << (char) 0x8F << (char) 0x05 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0x8F << (char) 0x46 << (char) 0x00
        << (char) 0x66 << (char) 0x67 << (char) 0x8F << (char) 0x01
        << (char) 0x67 << (char) 0x8F << (char) 0x05
        << (char) 0x66 << (char) 0x67 << (char) 0x8F << (char) 0x06 << (char) 0x20 << (char) 0x00
    ;
    (pretty = "")
        << ".code32\n"
        << "pushw (%eax)\n"
        << "pushl 0x2(%eax)\n"
        << "pushw (%ebx,%eax)\n"
        << "pushl 0x6(%ebx,%ebp,4)\n"
        << "pushw (0x20)\n"
        
        << "pushl (%bx)\n"
        << "pushw 0x6(%bp,%si)\n"
        << ".addr16 pushl (0x20)\n"

        << "popw 0x2(%eax)\n"
        << "popl (%ebx,%eax)\n"
        << "popw (%ecx,%edi,8)\n"
        << "popl 0xbf000(,%esi,2)\n"
        << "popw (0x20)\n"
        
        << "popl (%bp)\n"
        << "popw (%bx,%di)\n"
        << "popl (%di)\n"
        << ".addr16 popw (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"push/pop indirect (32bit)\"");
    
    (in = "")
        << ".code16\n"
        << "push (%eax)\n"
        << "pushl 2(%eax)\n"
        << "push (%ebx, %eax)\n"
        << "pushl 6(%ebx,%ebp,4)\n"
        << ".addr32 pushw (0x20)\n"
        
        << "pushl (%bx)\n"
        << "pushw 6(%bp,%si)\n"
        << ".addr16 pushl (0x20)\n"

        << "pop 2(%eax)\n"
        << "popl (%ebx, %eax)\n"
        << "pop (%ecx,%edi,8)\n"
        << "popl 0xBF000(,%esi,2)\n"
        << ".addr32 popw (0x20)\n"
        
        << "popl (%bp)\n"
        << "popw (%bx, %di)\n"
        << "popl (%di)\n"
        << ".addr16 popw (0x20)\n"
    ;
    (bin = "")
        << (char) 0x67 << (char) 0xFF << (char) 0x30
        << (char) 0x66 << (char) 0x67 << (char) 0xFF << (char) 0x70 << (char) 0x02
        << (char) 0x67 << (char) 0xFF << (char) 0x34 << (char) 0x03
        << (char) 0x66 << (char) 0x67 << (char) 0xFF << (char) 0x74 << (char) 0xAB << (char) 0x06
        << (char) 0x67 << (char) 0xFF << (char) 0x35 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xFF << (char) 0x37
        << (char) 0xFF << (char) 0x72 << (char) 0x06
        << (char) 0x66 << (char) 0xFF << (char) 0x36 << (char) 0x20 << (char) 0x00
        
        << (char) 0x67 << (char) 0x8F << (char) 0x40 << (char) 0x02
        << (char) 0x66 << (char) 0x67 << (char) 0x8F << (char) 0x04 << (char) 0x03
        << (char) 0x67 << (char) 0x8F << (char) 0x04 << (char) 0xF9
        << (char) 0x66 << (char) 0x67 << (char) 0x8F << (char) 0x04 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        << (char) 0x67 << (char) 0x8F << (char) 0x05 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0x8F << (char) 0x46 << (char) 0x00
        << (char) 0x8F << (char) 0x01
        << (char) 0x66 << (char) 0x8F << (char) 0x05
        << (char) 0x8F << (char) 0x06 << (char) 0x20 << (char) 0x00
    ;
    (pretty = "")
        << ".code16\n"
        << "pushw (%eax)\n"
        << "pushl 0x2(%eax)\n"
        << "pushw (%ebx,%eax)\n"
        << "pushl 0x6(%ebx,%ebp,4)\n"
        << ".addr32 pushw (0x20)\n"
        
        << "pushl (%bx)\n"
        << "pushw 0x6(%bp,%si)\n"
        << "pushl (0x20)\n"

        << "popw 0x2(%eax)\n"
        << "popl (%ebx,%eax)\n"
        << "popw (%ecx,%edi,8)\n"
        << "popl 0xbf000(,%esi,2)\n"
        << ".addr32 popw (0x20)\n"
        
        << "popl (%bp)\n"
        << "popw (%bx,%di)\n"
        << "popl (%di)\n"
        << "popw (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"push/pop indirect (16bit)\"");
    
    return success;
}
bool PushPopTest::testO() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "push %ax\n"
        << "push %ebx\n"
        << "pushw %di\n"
        << "pushl %esp\n"
        << "pop %sp\n"
        << "pop %ebp\n"
        << "popw %bx\n"
        << "popl %esi\n"
        
        << ".code16\n"
        << "push %di\n"
        << "push %esp\n"
        << "popw %sp\n"
        << "popl %ebp\n"
    ;
    (bin = "")
        << (char) 0x66 << (char) 0x50
        << (char) 0x53
        << (char) 0x66 << (char) 0x57
        << (char) 0x54
        << (char) 0x66 << (char) 0x5C
        << (char) 0x5D
        << (char) 0x66 << (char) 0x5B
        << (char) 0x5E
        
        << (char) 0x57
        << (char) 0x66 << (char) 0x54
        << (char) 0x5C
        << (char) 0x66 << (char) 0x5D
    ;
    (pretty = "")
        << ".code32\n"
        << "pushw %ax\n"
        << "pushl %ebx\n"
        << "pushw %di\n"
        << "pushl %esp\n"
        << "popw %sp\n"
        << "popl %ebp\n"
        << "popw %bx\n"
        << "popl %esi\n"
        
        << ".code16\n"
        << "pushw %di\n"
        << "pushl %esp\n"
        << "popw %sp\n"
        << "popl %ebp\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"push/pop reg\"");
    
    return success;
}
bool PushPopTest::testI() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "start:\n"
        << "push 13\n"
        << "pushw 13\n"
        << "pushl 13\n"
        << "pushw start\n"
        << "pushl BEEF\n"
        
        << ".code16\n"
        << "push 13\n"
        << "pushw 13\n"
        << "pushl 13\n"
        << "pushw start\n"
        << "pushl BEEF\n"
        << "BEEF := 0xDEADBEEF\n"
    ;
    (bin = "")
        << (char) 0x6A << (char) 0x0D
        << (char) 0x66 << (char) 0x6A << (char) 0x0D
        << (char) 0x6A << (char) 0x0D
        << (char) 0x66 << (char) 0x68 << (char) 0x00 << (char) 0x00
        << (char) 0x68 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE
        
        << (char) 0x6A << (char) 0x0D
        << (char) 0x6A << (char) 0x0D
        << (char) 0x66 << (char) 0x6A << (char) 0x0D
        << (char) 0x68 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0x68 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE
    ;
    (pretty = "")
        << ".code32\n"
        << "start:\n"
        << "pushl 0xd\n"
        << "pushw 0xd\n"
        << "pushl 0xd\n"
        << "pushw start\n"
        << "pushl 0xdeadbeef\n"
        
        << ".code16\n"
        << "pushw 0xd\n"
        << "pushw 0xd\n"
        << "pushl 0xd\n"
        << "pushw start\n"
        << "pushl 0xdeadbeef\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"push/pop imm\"");
    
    return success;
}
bool PushPopTest::testZO() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "push %ss\n"
        << "push %cs\n"
        << "pushl %ds\n"
        << "push %es\n"
        << "push %fs\n"
        << "pushw %gs\n"

        << "pop %ss\n"
        << "pop %ds\n"
        << "popl %es\n"
        << "pop %fs\n"
        << "popw %gs\n"
    ;
    (bin = "")
        << (char) 0x16
        << (char) 0x0E
        << (char) 0x1E
        << (char) 0x06
        << (char) 0x0F << (char) 0xA0
        << (char) 0x66 << (char) 0x0F << (char) 0xA8
        
        << (char) 0x17
        << (char) 0x1F
        << (char) 0x07
        << (char) 0x0F << (char) 0xA1
        << (char) 0x66 << (char) 0x0F << (char) 0xA9
    ;
    (pretty = "")
        << ".code32\n"
        << "pushl %ss\n"
        << "pushl %cs\n"
        << "pushl %ds\n"
        << "pushl %es\n"
        << "pushl %fs\n"
        << "pushw %gs\n"

        << "popl %ss\n"
        << "popl %ds\n"
        << "popl %es\n"
        << "popl %fs\n"
        << "popw %gs\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"push/pop seg (32bit)\"");
    
    (in = "")
        << ".code16\n"
        << "push %ss\n"
        << "push %cs\n"
        << "pushl %ds\n"
        << "push %es\n"
        << "push %fs\n"
        << "pushw %gs\n"

        << "pop %ss\n"
        << "pop %ds\n"
        << "popl %es\n"
        << "pop %fs\n"
        << "popw %gs\n"
    ;
    (bin = "")
        << (char) 0x16
        << (char) 0x0E
        << (char) 0x66 << (char) 0x1E
        << (char) 0x06
        << (char) 0x0F << (char) 0xA0
        << (char) 0x0F << (char) 0xA8
        
        << (char) 0x17
        << (char) 0x1F
        << (char) 0x66 << (char) 0x07
        << (char) 0x0F << (char) 0xA1
        << (char) 0x0F << (char) 0xA9
    ;
    (pretty = "")
        << ".code16\n"
        << "pushw %ss\n"
        << "pushw %cs\n"
        << "pushl %ds\n"
        << "pushw %es\n"
        << "pushw %fs\n"
        << "pushw %gs\n"

        << "popw %ss\n"
        << "popw %ds\n"
        << "popl %es\n"
        << "popw %fs\n"
        << "popw %gs\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"push/pop seg (16bit)\"");
    
    return success;
}
