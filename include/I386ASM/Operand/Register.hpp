#ifndef I386ASMREGISTER_HPP_LOCK
#define I386ASMREGISTER_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"


class Register: public ASMOperand {
    private:
    RegisterName _reg;
    
    public:
    Register(Environment &env, MemoryInfo &mi, RegisterName reg):Object(env, mi), _reg(reg) {}
    virtual ~Register() {}
    
    virtual BitWidth getOperandSize() {
        switch (_reg) {
            case reg_al:
            case reg_ah:
            case reg_bl:
            case reg_bh:
            case reg_cl:
            case reg_ch:
            case reg_dl:
            case reg_dh:
                return bit_8;
                
            case reg_ax:
            case reg_bx:
            case reg_cx:
            case reg_dx:
            case reg_di:
            case reg_si:
            case reg_bp:
            case reg_sp:
                return bit_16;

            case reg_eax:
            case reg_ebx:
            case reg_ecx:
            case reg_edx:
            case reg_edi:
            case reg_esi:
            case reg_ebp:
            case reg_esp:
                return bit_32;

            case reg_cs:
            case reg_ds:
            case reg_es:
            case reg_fs:
            case reg_gs:
            case reg_ss:
                return bit_16;
        }
    }
    
    virtual RegisterKind kind() {
        switch (_reg) {
            case reg_cs:
            case reg_ds:
            case reg_es:
            case reg_fs:
            case reg_gs:
            case reg_ss:
                return reg_segment;
        }
        return reg_general;
    }
    
    virtual int getOpCodeRegister() {
        switch (_reg) {
            case reg_al:
            case reg_ax:
            case reg_eax:
            case reg_es:
                return 0;
            case reg_cl:
            case reg_cx:
            case reg_ecx:
            case reg_cs:
                return 1;
            case reg_dl:
            case reg_dx:
            case reg_edx:
            case reg_ss:
                return 2;
            case reg_bl:
            case reg_bx:
            case reg_ebx:
            case reg_ds:
                return 3;
            case reg_ah:
            case reg_sp:
            case reg_esp:
            case reg_fs:
                return 4;
            case reg_ch:
            case reg_bp:
            case reg_ebp:
            case reg_gs:
                return 5;
            case reg_dh:
            case reg_si:
            case reg_esi:
                return 6;
            case reg_bh:
            case reg_di:
            case reg_edi:
                return 7;
        }            
        return -1;
    }
    
    virtual bool validate(OStream &error, BitWidth operandSize) {
        if (operandSize == getOperandSize()) {
            return true;
        }
        RegisterName newReg = wideRegister(_reg, operandSize);
        if (newReg == reg_none) {
            error<<"Invalid register \""<<*this<<"\" for "<<(operandSize*8)<<" bit operand size\n";
            return false;
        }
        error<<"replace \""<<*this<<"\"";
        _reg = newReg;
        error<<" with \""<<*this<<"\" due to "<<(operandSize*8)<<" bit operand size\n";
        return true;
    }
    
    virtual RegisterName wideRegister(RegisterName orig, BitWidth size) {
        switch (size) {
            case bit_32:
                switch (orig) {
                    case reg_al: return reg_eax;
                    case reg_bl: return reg_ebx;
                    case reg_cl: return reg_ecx;
                    case reg_dl: return reg_edx;
                        
                    case reg_ax: return reg_eax;
                    case reg_bx: return reg_ebx;
                    case reg_cx: return reg_ecx;
                    case reg_dx: return reg_edx;
                    case reg_di: return reg_edi;
                    case reg_si: return reg_esi;
                    case reg_bp: return reg_ebp;
                    case reg_sp: return reg_esp;
                }
                break;
            case bit_16:
                switch (orig) {
                    case reg_al: return reg_ax;
                    case reg_bl: return reg_bx;
                    case reg_cl: return reg_cx;
                    case reg_dl: return reg_dx;
                        
                    case reg_eax: return reg_ax;
                    case reg_ebx: return reg_bx;
                    case reg_ecx: return reg_cx;
                    case reg_edx: return reg_dx;
                    case reg_edi: return reg_di;
                    case reg_esi: return reg_si;
                    case reg_ebp: return reg_bp;
                    case reg_esp: return reg_sp;
                }
                break;
        }
        return reg_none;
    }

    virtual void logToStream(OStream &stream) {
        switch (_reg) {
            case reg_al: stream<<"%al"; break;
            case reg_ah: stream<<"%ah"; break;
            case reg_bl: stream<<"%bl"; break;
            case reg_bh: stream<<"%bh"; break;
            case reg_cl: stream<<"%cl"; break;
            case reg_ch: stream<<"%ch"; break;
            case reg_dl: stream<<"%dl"; break;
            case reg_dh: stream<<"%dh"; break;
            
            case reg_ax: stream<<"%ax"; break;
            case reg_bx: stream<<"%bx"; break;
            case reg_cx: stream<<"%cx"; break;
            case reg_dx: stream<<"%dx"; break;
            case reg_di: stream<<"%di"; break;
            case reg_si: stream<<"%si"; break;
            case reg_bp: stream<<"%bp"; break;
            case reg_sp: stream<<"%sp"; break;
            
            case reg_eax: stream<<"%eax"; break;
            case reg_ebx: stream<<"%ebx"; break;
            case reg_ecx: stream<<"%ecx"; break;
            case reg_edx: stream<<"%edx"; break;
            case reg_edi: stream<<"%edi"; break;
            case reg_esi: stream<<"%esi"; break;
            case reg_ebp: stream<<"%ebp"; break;
            case reg_esp: stream<<"%esp"; break;
            
            case reg_cs: stream<<"%cs"; break;
            case reg_ds: stream<<"%ds"; break;
            case reg_es: stream<<"%es"; break;
            case reg_fs: stream<<"%fs"; break;
            case reg_gs: stream<<"%gs"; break;
            case reg_ss: stream<<"%ss"; break;
        }
    }
    
    // TODO #6: implement RTTI correctly
    virtual OperandType type() { return reg; }
    virtual int hash() override {
        return (int) _reg;
    }
    virtual bool equals(Object &o) override {
        if (ASMOperand *op = env().as<ASMOperand>(o, asm_operand)) {
            if (Register *r = op->as<Register>(reg)) {
                return _reg == r->_reg;
            }
        }
        return false;
    }
    inline bool operator ==(RegisterName reg) { return _reg == reg; }
    inline bool operator !=(RegisterName reg) { return _reg != reg; }
};

#endif //I386ASMREGISTER_HPP_LOCK
