#ifndef I386ASMREGISTER_HPP_LOCK
#define I386ASMREGISTER_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"

enum asm_register {
    none,
    al, ah, bl, bh, cl, ch, dl, dh, // 8bit
    ax, bx, cx, dx, di, si, bp, sp, ip, // 16bit
    eax, ebx, ecx, edx, edi, esi, ebp, esp, eip, // 32bit
    cs, ds, es, fs, gs, ss // segment register
};

class Register: public ASMOperand {
    private:
    enum asm_register _reg;
    
    public:
    Register(Environment &env, MemoryInfo &mi, enum asm_register reg):Object(env, mi), _reg(reg) {}
    virtual ~Register() {}
    
    virtual int number() {
        return (int) _reg;
    }

    virtual void logToStream(OStream &stream) {
        switch (_reg) {
            case al: stream<<"%al"; break;
            case ah: stream<<"%ah"; break;
            case bl: stream<<"%bl"; break;
            case bh: stream<<"%bh"; break;
            case cl: stream<<"%cl"; break;
            case ch: stream<<"%ch"; break;
            case dl: stream<<"%dl"; break;
            case dh: stream<<"%dh"; break;
            
            case ax: stream<<"%ax"; break;
            case bx: stream<<"%bx"; break;
            case cx: stream<<"%cx"; break;
            case dx: stream<<"%dx"; break;
            case di: stream<<"%di"; break;
            case si: stream<<"%si"; break;
            case bp: stream<<"%bp"; break;
            case sp: stream<<"%sp"; break;
            case ip: stream<<"%ip"; break;
            
            case eax: stream<<"%eax"; break;
            case ebx: stream<<"%ebx"; break;
            case ecx: stream<<"%ecx"; break;
            case edx: stream<<"%edx"; break;
            case edi: stream<<"%edi"; break;
            case esi: stream<<"%esi"; break;
            case ebp: stream<<"%ebp"; break;
            case esp: stream<<"%esp"; break;
            case eip: stream<<"%eip"; break;
            
            case cs: stream<<"%cs"; break;
            case ds: stream<<"%ds"; break;
            case es: stream<<"%es"; break;
            case fs: stream<<"%fs"; break;
            case gs: stream<<"%gs"; break;
            case ss: stream<<"%ss"; break;
        }
    }
    
    virtual OperandType type() { return reg; }
};

#endif //I386ASMREGISTER_HPP_LOCK
