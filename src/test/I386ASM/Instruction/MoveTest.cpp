#include "test/I386ASM/Instruction/MoveTest.hpp"

// public
MoveTest::MoveTest(Environment &env, MemoryInfo &mi): ParserBasedTestCase(env, mi) {}
MoveTest::~MoveTest() {};

bool MoveTest::runAll() {
    bool success = true;
    
    success &= testMR();
    success &= testRM();
    success &= testOI();
    success &= testMI();
    
    return success;
}

// test cases
bool MoveTest::testMR() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "mov %eax, %eax\n"
        << "mov %al, %bh\n"
        << "mov %bx, %ax\n"
        << "movw %cx, %bx\n"
        << "movb %dh, %cl\n"
        << "movl %edi, %edx\n"
        << "movl %esi, %edi\n"
        << "movl %ebp, %esi\n"
        << "movl %esp, %ebp\n"
        << "movl %esp, %esp\n"
    ;
    (bin = "")
        << (char) 0x89 << (char) 0xC0
        << (char) 0x88 << (char) 0xC7
        << (char) 0x66 << (char) 0x89 << (char) 0xD8
        << (char) 0x66 << (char) 0x89 << (char) 0xCB
        << (char) 0x88 << (char) 0xF1
        << (char) 0x89 << (char) 0xFA
        << (char) 0x89 << (char) 0xF7
        << (char) 0x89 << (char) 0xEE
        << (char) 0x89 << (char) 0xE5
        << (char) 0x89 << (char) 0xE4
    ;
    (pretty = "")
        << ".code32\n"
        << "movl %eax, %eax\n"
        << "movb %al, %bh\n"
        << "movw %bx, %ax\n"
        << "movw %cx, %bx\n"
        << "movb %dh, %cl\n"
        << "movl %edi, %edx\n"
        << "movl %esi, %edi\n"
        << "movl %ebp, %esi\n"
        << "movl %esp, %ebp\n"
        << "movl %esp, %esp\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov reg -> reg\"");
    
    (in = "")
        << "buffer:=0xBF000\n"
        << "foo:=0x200\n"
        << "_start:\n"
        << "movb %al, (%eax)\n"
        << "movb %bh, 2(%eax)\n"
        << "movw %ax, (%ebx, %eax)\n"
        << "movw %cx, 6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, buffer(,%esi,2)\n"
        
        << "movl %edi, (0x20)\n"
        << "movl %ebx, (foo)\n"
        << "mov %al, (_start)\n"
        << "mov %ax, (foo)\n"
        << "mov %eax, (0x200)\n"
    ;
    (bin = "")
        << (char) 0x88 << (char) 0x00
        << (char) 0x88 << (char) 0x78 << (char) 0x02
        << (char) 0x66 << (char) 0x89 << (char) 0x04 << (char) 0x03
        << (char) 0x66 << (char) 0x89 << (char) 0x4C << (char) 0xAB << (char) 0x06
        << (char) 0x89 << (char) 0x14 << (char) 0xF9
        << (char) 0x89 << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        
        << (char) 0x89 << (char) 0x3D << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x89 << (char) 0x1D << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0xA2 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xA3 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0xA3 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
    ;
    (pretty = "")
        << ".code32\n"
        << "_start:\n"
        << "movb %al, (%eax)\n"
        << "movb %bh, 0x2(%eax)\n"
        << "movw %ax, (%ebx,%eax)\n"
        << "movw %cx, 0x6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, 0xbf000(,%esi,2)\n"
        
        << "movl %edi, (0x20)\n"
        << "movl %ebx, (0x200)\n"
        << "movb %al, (_start)\n"
        << "movw %ax, (0x200)\n"
        << "movl %eax, (0x200)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov reg -> indirect (32bit)\"", 0x200);
    
    (in = "")
        << ".code16\n"
        << "buffer:=0xBF000\n"
        << "foo:=0x200\n"
        << "_start:\n"
        << "movb %al, (%eax)\n"
        << "movb %bh, 2(%eax)\n"
        << "movw %ax, (%ebx, %eax)\n"
        << "movw %cx, 6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, buffer(,%esi,2)\n"
        
        << "movl %edi, (0x20)\n"
        << "movl %ebx, (foo)\n"
        << "mov %al, (_start)\n"
        << "mov %ax, (foo)\n"
        << "mov %eax, (0x200)\n"
    ;
    (bin = "")
        << (char) 0x67 << (char) 0x88 << (char) 0x00
        << (char) 0x67 << (char) 0x88 << (char) 0x78 << (char) 0x02
        << (char) 0x67 << (char) 0x89 << (char) 0x04 << (char) 0x03
        << (char) 0x67 << (char) 0x89 << (char) 0x4C << (char) 0xAB << (char) 0x06
        << (char) 0x66 << (char) 0x67 << (char) 0x89 << (char) 0x14 << (char) 0xF9
        << (char) 0x66 << (char) 0x67 << (char) 0x89 << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        
        << (char) 0x66 << (char) 0x89 << (char) 0x3E << (char) 0x20 << (char) 0x00
        << (char) 0x66 << (char) 0x89 << (char) 0x1E << (char) 0x00 << (char) 0x02
        << (char) 0xA2 << (char) 0x00 << (char) 0x02
        << (char) 0xA3 << (char) 0x00 << (char) 0x02
        << (char) 0x66 << (char) 0xA3 << (char) 0x00 << (char) 0x02
    ;
    (pretty = "")
        << ".code16\n"
        << "_start:\n"
        << "movb %al, (%eax)\n"
        << "movb %bh, 0x2(%eax)\n"
        << "movw %ax, (%ebx,%eax)\n"
        << "movw %cx, 0x6(%ebx,%ebp,4)\n"
        << "movl %edx, (%ecx,%edi,8)\n"
        << "movl %esp, 0xbf000(,%esi,2)\n"
        
        << "movl %edi, (0x20)\n"
        << "movl %ebx, (0x200)\n"
        << "movb %al, (_start)\n"
        << "movw %ax, (0x200)\n"
        << "movl %eax, (0x200)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov reg -> indirect (16bit)\"", 0x200);
    
    (in = "")
        << "movl %cs, %eax\n"
        << "movl %ds, %ebp\n"
        << "mov %es, %esp\n"
        << "mov %fs, %bx\n"
        << "movw %gs, %di\n"
        << "movw %ss, %dx\n"
    ;
    (bin = "")
        << (char) 0x8C << (char) 0xC8
        << (char) 0x8C << (char) 0xDD
        << (char) 0x8C << (char) 0xC4
        << (char) 0x66 << (char) 0x8C << (char) 0xE3
        << (char) 0x66 << (char) 0x8C << (char) 0xEF
        << (char) 0x66 << (char) 0x8C << (char) 0xD2
    ;
    (pretty = "")
        << ".code32\n"
        << "movl %cs, %eax\n"
        << "movl %ds, %ebp\n"
        << "movl %es, %esp\n"
        << "movw %fs, %bx\n"
        << "movw %gs, %di\n"
        << "movw %ss, %dx\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov sreg -> reg\"");
    
    (in = "")
        << "movw %cs, (%eax)\n"
        << "movw %ds, 300(%esp)\n"
        << "mov %es, (,%esi,8)\n"
        << "mov %fs, 8(%edi,%eax)\n"
    ;
    (bin = "")
        << (char) 0x8C << (char) 0x08
        << (char) 0x8C << (char) 0x9C << (char) 0x24 << (char) 0x2C << (char) 0x01 << (char) 0x00 << (char) 0x00
        << (char) 0x8C << (char) 0x04 << (char) 0xF5 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x8C << (char) 0x64 << (char) 0x07 << (char) 0x08
    ;
    (pretty = "")
        << ".code32\n"
        << "movw %cs, (%eax)\n"
        << "movw %ds, 0x12c(%esp)\n"
        << "movw %es, (,%esi,8)\n"
        << "movw %fs, 0x8(%edi,%eax)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov sreg -> indirect\"");
    
    return success;
}

bool MoveTest::testRM() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "movb (%eax), %dl\n"
        << "movb 5(%ebx), %ch\n"
        << "movw (%eax, %ecx), %bx\n"
        << "movw 127(%ecx,%ebx,4), %bp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xBF000(,%esi,2), %esp\n"
        
        << "movl (0x20), %edi\n"
        << "movl (0x200), %ebx\n"
        << "mov (0x200), %al\n"
        << "mov (0x200), %ax\n"
        << "mov (0x200), %eax\n"
    ;
    (bin = "")
        << (char) 0x8A << (char) 0x10
        << (char) 0x8A << (char) 0x6B << (char) 0x05
        << (char) 0x66 << (char) 0x8B << (char) 0x1C << (char) 0x08
        << (char) 0x66 << (char) 0x8B << (char) 0x6C << (char) 0x99 << (char) 0x7F
        << (char) 0x8B << (char) 0x0C << (char) 0xFA
        << (char) 0x8B << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        
        << (char) 0x8B << (char) 0x3D << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x8B << (char) 0x1D << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0xA0 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xA1 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
        << (char) 0xA1 << (char) 0x00 << (char) 0x02 << (char) 0x00 << (char) 0x00
    ;
    (pretty = "")
        << ".code32\n"
        << "movb (%eax), %dl\n"
        << "movb 0x5(%ebx), %ch\n"
        << "movw (%eax,%ecx), %bx\n"
        << "movw 0x7f(%ecx,%ebx,4), %bp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xbf000(,%esi,2), %esp\n"
        
        << "movl (0x20), %edi\n"
        << "movl (0x200), %ebx\n"
        << "movb (0x200), %al\n"
        << "movw (0x200), %ax\n"
        << "movl (0x200), %eax\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov indirect -> reg (32bit)\"");
    
    (in = "")
        << ".code16\n"
        << "movb (%eax), %dl\n"
        << "movb 5(%ebx), %ch\n"
        << "movw (%eax, %ecx), %bx\n"
        << "movw 127(%ecx,%ebx,4), %bp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xBF000(,%esi,2), %esp\n"
        
        << "movl (0x20), %edi\n"
        << "movl (0x200), %ebx\n"
        << "mov (0x200), %al\n"
        << "mov (0x200), %ax\n"
        << "mov (0x200), %eax\n"
    ;
    (bin = "")
        << (char) 0x67 << (char) 0x8A << (char) 0x10
        << (char) 0x67 << (char) 0x8A << (char) 0x6B << (char) 0x05
        << (char) 0x67 << (char) 0x8B << (char) 0x1C << (char) 0x08
        << (char) 0x67 << (char) 0x8B << (char) 0x6C << (char) 0x99 << (char) 0x7F
        << (char) 0x66 << (char) 0x67 << (char) 0x8B << (char) 0x0C << (char) 0xFA
        << (char) 0x66 << (char) 0x67 << (char) 0x8B << (char) 0x24 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00
        
        << (char) 0x66 << (char) 0x8B << (char) 0x3E << (char) 0x20 << (char) 0x00
        << (char) 0x66 << (char) 0x8B << (char) 0x1E << (char) 0x00 << (char) 0x02
        << (char) 0xA0 << (char) 0x00 << (char) 0x02
        << (char) 0xA1 << (char) 0x00 << (char) 0x02
        << (char) 0x66 << (char) 0xA1 << (char) 0x00 << (char) 0x02
    ;
    (pretty = "")
        << ".code16\n"
        << "movb (%eax), %dl\n"
        << "movb 0x5(%ebx), %ch\n"
        << "movw (%eax,%ecx), %bx\n"
        << "movw 0x7f(%ecx,%ebx,4), %bp\n"
        << "movl (%edx,%edi,8), %ecx\n"
        << "movl 0xbf000(,%esi,2), %esp\n"
        << "movl (0x20), %edi\n"
        << "movl (0x200), %ebx\n"
        << "movb (0x200), %al\n"
        << "movw (0x200), %ax\n"
        << "movl (0x200), %eax\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov indirect -> reg (16bit)\"");
    
    (in = "")
        << "movl %eax, %cs\n"
        << "movl %ebp, %ds\n"
        << "mov %esp, %es\n"
        << "mov %bx, %fs\n"
        << "movw %di, %gs\n"
        << "movw %dx, %ss\n"
    ;
    (bin = "")
        << (char) 0x8E << (char) 0xC8
        << (char) 0x8E << (char) 0xDD
        << (char) 0x8E << (char) 0xC4
        << (char) 0x66 << (char) 0x8E << (char) 0xE3
        << (char) 0x66 << (char) 0x8E << (char) 0xEF
        << (char) 0x66 << (char) 0x8E << (char) 0xD2
    ;
    (pretty = "")
        << ".code32\n"
        << "movl %eax, %cs\n"
        << "movl %ebp, %ds\n"
        << "movl %esp, %es\n"
        << "movw %bx, %fs\n"
        << "movw %di, %gs\n"
        << "movw %dx, %ss\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov reg -> sreg\"");
    
    (in = "")
        << "mov (%eax), %cs\n"
        << "mov 300(%ebp), %ds\n"
        << "movw (,%esi,2), %es\n"
        << "movw 0x6(%eax,%ebx,8), %ss\n"
    ;
    (bin = "")
        << (char) 0x8E << (char) 0x08
        << (char) 0x8E << (char) 0x9D << (char) 0x2C << (char) 0x01 << (char) 0x00 << (char) 0x00
        << (char) 0x8E << (char) 0x04 << (char) 0x75 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0x00
        << (char) 0x8E << (char) 0x54 << (char) 0xD8 << (char) 0x06
    ;
    (pretty = "")
        << ".code32\n"
        << "movw (%eax), %cs\n"
        << "movw 0x12c(%ebp), %ds\n"
        << "movw (,%esi,2), %es\n"
        << "movw 0x6(%eax,%ebx,8), %ss\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov indirect -> sreg\"");
    
    return success;
}

bool MoveTest::testOI() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "zero := 0x0\n"
        << "movb zero, %al\n"
        << "movb 0x1A, %bh\n"
        << "movw 1, %sp\n"
        << "movl 12345678, %esi\n"
    ;
    (bin = "")
        << (char) 0xB0 << (char) 0x00
        << (char) 0xB7 << (char) 0x1A
        << (char) 0x66 << (char) 0xBC << (char) 0x01 << (char) 0x00
        << (char) 0xBE << (char) 0x4E << (char) 0x61 << (char) 0xBC << (char) 0x00
    ;
    (pretty = "")
        << ".code32\n"
        << "movb 0x0, %al\n"
        << "movb 0x1a, %bh\n"
        << "movw 0x1, %sp\n"
        << "movl 0xbc614e, %esi\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov imm -> reg\"");
    
    return success;
}

bool MoveTest::testMI() {
    bool success = true;
    String in(env());
    String bin(env());
    String pretty(env());
    String message(env());
    
    (in = "")
        << "start:\n"
        << "movb start, (%eax)\n"
        << "movb ff, 2(%eax)\n"
        << "movw 12, (%ebx, %eax)\n"
        << "movw 1024, 6(%ebx,%ebp,4)\n"
        << "movl 0xC0FFEE, (%ecx,%edi,8)\n"
        << "movl fefe, 0xBF000(,%esi,2)\n"
        << "movl 0xFEFE, 0xBF000(%ebp,%eax,1)\n"
        << ".addr32 movl 0xDEADBEEF, (0x20)\n"
        
        << "movb start, (%bx)\n"
        << "movb start, (%bp)\n"
        << "movb ff, 2(%bx)\n"
        << "movw 12, (%bx, %di)\n"
        << "movw 1024, 6(%bp,%si)\n"
        << "movl 0xC0FFEE, (%di)\n"
        << "movl fefe, 0xABCD(%si)\n"
        << ".addr16 movl 0xDEADBEEF, (0x20)\n"

        << "fefe := 0xFEFE\n"
        << "ff := 0xFF\n"
    ;
    (bin = "")
        << (char) 0xC6 << (char) 0x00 << (char) 0x00
        << (char) 0xC6 << (char) 0x40 << (char) 0x02 << (char) 0xFF
        << (char) 0x66 << (char) 0xC7 << (char) 0x04 << (char) 0x03 << (char) 0x0C << (char) 0x00
        << (char) 0x66 << (char) 0xC7 << (char) 0x44 << (char) 0xAB << (char) 0x06 << (char) 0x00 << (char) 0x04
        << (char) 0xC7 << (char) 0x04 << (char) 0xF9 << (char) 0xEE << (char) 0xFF << (char) 0xC0 << (char) 0x00
        << (char) 0xC7 << (char) 0x04 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00 << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0xC7 << (char) 0x84 << (char) 0x05 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00 << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0xC7 << (char) 0x05 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE

        << (char) 0x67 << (char) 0xC6 << (char) 0x07 << (char) 0x00
        << (char) 0x67 << (char) 0xC6 << (char) 0x46 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xC6 << (char) 0x47 << (char) 0x02 << (char) 0xFF
        << (char) 0x66 << (char) 0x67 << (char) 0xC7 << (char) 0x01 << (char) 0x0C << (char) 0x00
        << (char) 0x66 << (char) 0x67 << (char) 0xC7 << (char) 0x42 << (char) 0x06 << (char) 0x00 << (char) 0x04
        << (char) 0x67 << (char) 0xC7 << (char) 0x05 << (char) 0xEE << (char) 0xFF << (char) 0xC0 << (char) 0x00
        << (char) 0x67 << (char) 0xC7 << (char) 0x84 << (char) 0xCD << (char) 0xAB << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xC7 << (char) 0x06 << (char) 0x20 << (char) 0x00 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE
    ;
    (pretty = "")
        << ".code32\n"
        << "start:\n"
        << "movb start, (%eax)\n"
        << "movb 0xff, 0x2(%eax)\n"
        << "movw 0xc, (%ebx,%eax)\n"
        << "movw 0x400, 0x6(%ebx,%ebp,4)\n"
        << "movl 0xc0ffee, (%ecx,%edi,8)\n"
        << "movl 0xfefe, 0xbf000(,%esi,2)\n"
        << "movl 0xfefe, 0xbf000(%ebp,%eax)\n"
        << "movl 0xdeadbeef, (0x20)\n"

        << "movb start, (%bx)\n"
        << "movb start, (%bp)\n"
        << "movb 0xff, 0x2(%bx)\n"
        << "movw 0xc, (%bx,%di)\n"
        << "movw 0x400, 0x6(%bp,%si)\n"
        << "movl 0xc0ffee, (%di)\n"
        << "movl 0xfefe, 0xabcd(%si)\n"
        << ".addr16 movl 0xdeadbeef, (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov imm -> indirect (32bit)\"");
    
    (in = "")
        << ".code16\n"
        << "start:\n"
        << "movb start, (%eax)\n"
        << "movb ff, 2(%eax)\n"
        << "movw 12, (%ebx, %eax)\n"
        << "movw 1024, 6(%ebx,%ebp,4)\n"
        << "movl 0xC0FFEE, (%ecx,%edi,8)\n"
        << "movl fefe, 0xBF000(,%esi,2)\n"
        << "movl 0xFEFE, 0xBF000(%ebp,%eax,1)\n"
        << ".addr32 movl 0xDEADBEEF, (0x20)\n"
        
        << "movb start, (%bx)\n"
        << "movb start, (%bp)\n"
        << "movb ff, 2(%bx)\n"
        << "movw 12, (%bx, %di)\n"
        << "movw 1024, 6(%bp,%si)\n"
        << "movl 0xC0FFEE, (%di)\n"
        << "movl fefe, 0xABCD(%si)\n"
        << ".addr16 movl 0xDEADBEEF, (0x20)\n"

        << "fefe := 0xFEFE\n"
        << "ff := 0xFF\n"
    ;
    (bin = "")
        << (char) 0x67 << (char) 0xC6 << (char) 0x00 << (char) 0x00
        << (char) 0x67 << (char) 0xC6 << (char) 0x40 << (char) 0x02 << (char) 0xFF
        << (char) 0x67 << (char) 0xC7 << (char) 0x04 << (char) 0x03 << (char) 0x0C << (char) 0x00
        << (char) 0x67 << (char) 0xC7 << (char) 0x44 << (char) 0xAB << (char) 0x06 << (char) 0x00 << (char) 0x04
        << (char) 0x66 << (char) 0x67 << (char) 0xC7 << (char) 0x04 << (char) 0xF9 << (char) 0xEE << (char) 0xFF << (char) 0xC0 << (char) 0x00
        << (char) 0x66 << (char) 0x67 << (char) 0xC7 << (char) 0x04 << (char) 0x75 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00 << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0x67 << (char) 0xC7 << (char) 0x84 << (char) 0x05 << (char) 0x00 << (char) 0xF0 << (char) 0x0B << (char) 0x00 << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0x67 << (char) 0xC7 << (char) 0x05 << (char) 0x20 << (char) 0x00 << (char) 0x00 << (char) 0x00 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE

        << (char) 0xC6 << (char) 0x07 << (char) 0x00
        << (char) 0xC6 << (char) 0x46 << (char) 0x00 << (char) 0x00
        << (char) 0xC6 << (char) 0x47 << (char) 0x02 << (char) 0xFF
        << (char) 0xC7 << (char) 0x01 << (char) 0x0C << (char) 0x00
        << (char) 0xC7 << (char) 0x42 << (char) 0x06 << (char) 0x00 << (char) 0x04
        << (char) 0x66 << (char) 0xC7 << (char) 0x05 << (char) 0xEE << (char) 0xFF << (char) 0xC0 << (char) 0x00
        << (char) 0x66 << (char) 0xC7 << (char) 0x84 << (char) 0xCD << (char) 0xAB << (char) 0xFE << (char) 0xFE << (char) 0x00 << (char) 0x00
        << (char) 0x66 << (char) 0xC7 << (char) 0x06 << (char) 0x20 << (char) 0x00 << (char) 0xEF << (char) 0xBE << (char) 0xAD << (char) 0xDE
    ;
    (pretty = "")
        << ".code16\n"
        << "start:\n"
        << "movb start, (%eax)\n"
        << "movb 0xff, 0x2(%eax)\n"
        << "movw 0xc, (%ebx,%eax)\n"
        << "movw 0x400, 0x6(%ebx,%ebp,4)\n"
        << "movl 0xc0ffee, (%ecx,%edi,8)\n"
        << "movl 0xfefe, 0xbf000(,%esi,2)\n"
        << "movl 0xfefe, 0xbf000(%ebp,%eax)\n"
        << ".addr32 movl 0xdeadbeef, (0x20)\n"

        << "movb start, (%bx)\n"
        << "movb start, (%bp)\n"
        << "movb 0xff, 0x2(%bx)\n"
        << "movw 0xc, (%bx,%di)\n"
        << "movw 0x400, 0x6(%bp,%si)\n"
        << "movl 0xc0ffee, (%di)\n"
        << "movl 0xfefe, 0xabcd(%si)\n"
        << "movl 0xdeadbeef, (0x20)\n"
    ;
    
    success &= test(in, bin, pretty, message = "test \"mov imm -> indirect (16bit)\"");
    
    return success;
}
