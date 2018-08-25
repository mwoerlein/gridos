#ifndef I386ASMINSTRUCTIONLIST_HPP_LOCK
#define I386ASMINSTRUCTIONLIST_HPP_LOCK

#include "sys/Object.hpp"
#include "I386ASM/ASMInstruction.hpp"

class ASMInstructionList: virtual public Object {
    private:
    class InstructionElem: virtual public Object {
        public:
        InstructionElem * next;
        ASMInstruction &inst;
        size_t pos;
        
        InstructionElem(Environment &env, MemoryInfo &mi, ASMInstruction &inst, size_t pos):Object(env, mi),inst(inst),pos(pos),next(0) {}
        virtual ~InstructionElem() {}
    };
    size_t pos;
    InstructionElem *first, *last;
    
    public:
    ASMInstructionList(Environment &env, MemoryInfo &mi);
    virtual ~ASMInstructionList();
    
    //virtual void addLabel(String &label);
    //virtual void addDefinition(String &definition, NumberArgument &value);
    virtual void addInstruction(ASMInstruction &inst);
    virtual size_t getSizeInBytes();
    
    virtual void writeToStream(OStream &stream);
};

#endif //I386ASMINSTRUCTIONLIST_HPP_LOCK
