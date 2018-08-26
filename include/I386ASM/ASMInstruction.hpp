#ifndef I386ASMINSTRUCTION_HPP_LOCK
#define I386ASMINSTRUCTION_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/OStream.hpp"

class ASMInstruction: virtual public Object {
    private:
    
    public:
    virtual ~ASMInstruction() {}
    
    virtual size_t getSizeInBytes() = 0;
    virtual void writeToStream(OStream &stream) = 0;
    
    friend OStream & operator << (OStream & out, ASMInstruction &instruction);
};

// http://sparksandflames.com/files/x86InstructionChart.html

#endif //I386ASMINSTRUCTION_HPP_LOCK
