#ifndef I386ASMTYPES_HPP_LOCK
#define I386ASMTYPES_HPP_LOCK

#define ModRM(mod,regO,regM) ((char) ((((mod)&0x3)<<6) + (((regO)&0x7)<<3) + (((regM)&0x7)))) 
#define SIB(ss,index,base) ((char) ((((ss)&0x3)<<6) + (((index)&0x7)<<3) + (((base)&0x7)))) 

enum OperandType { reg, indirect, number, id };

enum BitWidth { bit_8 = 1, bit_16 = 2, bit_32 = 4, bit_auto = 0 };

enum RegisterName {
    reg_al, reg_ah, reg_bl, reg_bh, reg_cl, reg_ch, reg_dl, reg_dh, // 8bit
    reg_ax, reg_bx, reg_cx, reg_dx, reg_di, reg_si, reg_bp, reg_sp, // 16bit
    reg_eax, reg_ebx, reg_ecx, reg_edx, reg_edi, reg_esi, reg_ebp, reg_esp, // 32bit
    reg_cs, reg_ds, reg_es, reg_fs, reg_gs, reg_ss, // segment register
    reg_none
};

enum RegisterKind {
    reg_general, reg_segment
};


#endif //I386ASMTYPES_HPP_LOCK
