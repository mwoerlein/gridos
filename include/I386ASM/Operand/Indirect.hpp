#ifndef I386ASMINDIRECT_HPP_LOCK
#define I386ASMINDIRECT_HPP_LOCK

#include "I386ASM/ASMOperand.hpp"

class Identifier;
class Register;
class Number;
class Indirect: public ASMOperand {
    private:
    Identifier *_displacementId;
    Number *_displacement;
    Register *_base;
    Register *_index;
    int _scale;
    BitWidth addrSize = bit_auto;
    
    public:
    Indirect(Environment &env, MemoryInfo &mi, Register *base = 0, Identifier *displacementId = 0, Number *displacement = 0, Register * index = 0, int scale = 1);
    virtual ~Indirect();
        
    virtual ASMOperand * validateAndReplace(ASMInstructionList & list, BitWidth mode) override;
    virtual BitWidth getAddrSize();
    virtual int getModRMSize();
    virtual int getSibSize();
    virtual BitWidth getDispSize();
    virtual char getModRM(int reg);
    virtual char getSib();
    virtual int getDispValue(ASMInstructionList & list);
    virtual bool isOffset();
    virtual OStream & operator >>(OStream & stream);
    
    virtual OperandType type() { return indirect; }
};

#endif //I386ASMINDIRECT_HPP_LOCK
