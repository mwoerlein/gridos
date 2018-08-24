#ifndef I386ASMINSTRUCTION_HPP_LOCK
#define I386ASMINSTRUCTION_HPP_LOCK

#include "sys/Environment.hpp"
#include "sys/OStream.hpp"
#include "sys/Object.hpp"

class ASMInstruction: public Object {
    private:
    
    public:
    ASMInstruction(Environment &env):Object(env) {}
    virtual ~ASMInstruction() {}
    
    virtual size_t getSizeInBytes() = 0;
    virtual void writeToStream(OStream &stream) = 0;
    
    friend OStream & operator<< (OStream & out, ASMInstruction &instruction);
};

// http://sparksandflames.com/files/x86InstructionChart.html

#endif //I386ASMINSTRUCTION_HPP_LOCK
