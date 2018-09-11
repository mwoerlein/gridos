#ifndef I386ASMINSTRUCTIONLIST_HPP_LOCK
#define I386ASMINSTRUCTIONLIST_HPP_LOCK

#include "sys/Object.hpp"
#include "I386ASM/ASMInstruction.hpp"

class ASMInstructionList: virtual public Object {
    private:
    class _Elem;
    
    size_t pos;
    _Elem *first, *last;
    
    public:
    ASMInstructionList(Environment &env, MemoryInfo &mi);
    virtual ~ASMInstructionList();
    
    //virtual void addLabel(String &label);
    //virtual void addDefinition(String &definition, NumberArgument &value);
    virtual void addInstruction(ASMInstruction &inst);
    
    virtual bool prepare(OStream &err);
    virtual size_t getSizeInBytes();
    
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream);
};

#endif //I386ASMINSTRUCTIONLIST_HPP_LOCK
