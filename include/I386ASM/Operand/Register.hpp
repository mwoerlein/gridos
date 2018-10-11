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
    
    virtual void validate(ASMInstructionList & list, BitWidth operandSize) {
        if (operandSize == getOperandSize()) {
            return;
        }
        RegisterName newReg = wideRegister(_reg, operandSize);
        if (newReg == reg_none) {
            list.err<<"Invalid register \""<<*this<<"\" for "<<(operandSize*8)<<" bit operand size\n";
            return;
        }
        list.warn<<"replace \""<<*this<<"\"";
        _reg = newReg;
        list.warn<<" with \""<<*this<<"\" due to "<<(operandSize*8)<<" bit operand size\n";
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

    virtual OStream & operator >>(OStream & stream) {
        switch (_reg) {
            case reg_al: return stream<<"%al";
            case reg_ah: return stream<<"%ah";
            case reg_bl: return stream<<"%bl";
            case reg_bh: return stream<<"%bh";
            case reg_cl: return stream<<"%cl";
            case reg_ch: return stream<<"%ch";
            case reg_dl: return stream<<"%dl";
            case reg_dh: return stream<<"%dh";
            
            case reg_ax: return stream<<"%ax";
            case reg_bx: return stream<<"%bx";
            case reg_cx: return stream<<"%cx";
            case reg_dx: return stream<<"%dx";
            case reg_di: return stream<<"%di";
            case reg_si: return stream<<"%si";
            case reg_bp: return stream<<"%bp";
            case reg_sp: return stream<<"%sp";
            
            case reg_eax: return stream<<"%eax";
            case reg_ebx: return stream<<"%ebx";
            case reg_ecx: return stream<<"%ecx";
            case reg_edx: return stream<<"%edx";
            case reg_edi: return stream<<"%edi";
            case reg_esi: return stream<<"%esi";
            case reg_ebp: return stream<<"%ebp";
            case reg_esp: return stream<<"%esp";
            
            case reg_cs: return stream<<"%cs";
            case reg_ds: return stream<<"%ds";
            case reg_es: return stream<<"%es";
            case reg_fs: return stream<<"%fs";
            case reg_gs: return stream<<"%gs";
            case reg_ss: return stream<<"%ss";
        }
        return stream;
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
    inline RegisterName name() { return _reg; }
    inline bool operator ==(RegisterName reg) { return _reg == reg; }
    inline bool operator !=(RegisterName reg) { return _reg != reg; }
};

#endif //I386ASMREGISTER_HPP_LOCK
