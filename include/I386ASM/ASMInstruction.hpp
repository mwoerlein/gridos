#ifndef I386ASMINSTRUCTION_HPP_LOCK
#define I386ASMINSTRUCTION_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/OStream.hpp"
#include "I386ASM/ASMOperand.hpp"

enum OperandSize { b = 1, w = 2, l = 4, automatic = 0 };

class ASMInstruction: virtual public Object {
    protected:
    enum OperandSize os;
    ASMOperand *o1, *o2, *o3;
    
    public:
    ASMInstruction(Environment &env, MemoryInfo &mi, OperandSize os = automatic, ASMOperand *o1 = 0, ASMOperand *o2 = 0, ASMOperand *o3 = 0)
        :Object(env, mi), os(os), o1(o1), o2(o2), o3(o3) {}
    virtual ~ASMInstruction() {
        if (o1) {
            o1->destroy();
        }
        if (o2) {
            o2->destroy();
        }
        if (o3) {
            o3->destroy();
        }
    }
    
    virtual size_t getSizeInBytes() = 0;
    virtual void writeToStream(OStream &stream) = 0;
    virtual void logToStream(OStream &stream) = 0;
    
    friend OStream & operator << (OStream & out, ASMInstruction &instruction);
};

// http://sparksandflames.com/files/x86InstructionChart.html

#endif //I386ASMINSTRUCTION_HPP_LOCK
