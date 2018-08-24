#ifndef I386ASMINSTRUCTIONLIST_HPP_LOCK
#define I386ASMINSTRUCTIONLIST_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"
#include "sys/Object.hpp"

class ASMInstructionList: public Object {
    private:
    class InstructionElem: public Object {
        public:
        InstructionElem * next;
        ASMInstruction &inst;
        size_t pos;
        
        InstructionElem(Environment &env, ASMInstruction &inst, size_t pos):Object(env),inst(inst),pos(pos),next(0) {}
        virtual ~InstructionElem() {}
    };
    size_t pos;
    InstructionElem *first, *last;
    
    public:
    ASMInstructionList(Environment &env);
    virtual ~ASMInstructionList();
    
    //virtual void addLabel(String &label);
    //virtual void addDefinition(String &definition, NumberArgument &value);
    virtual void addInstruction(ASMInstruction &inst);
    virtual size_t getSizeInBytes();
    
    virtual void writeToStream(OStream &stream);
};

#endif //I386ASMINSTRUCTIONLIST_HPP_LOCK
