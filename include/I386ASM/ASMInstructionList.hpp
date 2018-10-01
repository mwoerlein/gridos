#ifndef I386ASMINSTRUCTIONLIST_HPP_LOCK
#define I386ASMINSTRUCTIONLIST_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/collection/HashMap.hpp"
#include "I386ASM/ParseErrorStream.hpp"

class Number;
class ASMInstruction;
class ASMInstructionList: virtual public Object {
    private:
    class _Elem;
    
    size_t pos;
    _Elem *first, *last;
    HashMap<String, _Elem> &ids; 
    
    public:
    OStream &warn;
    ParseErrorStream &err;
    
    ASMInstructionList(Environment &env, MemoryInfo &mi, OStream &error);
    virtual ~ASMInstructionList();
    
    virtual void addLabel(String &label);
    virtual void addDefinition(String &definition, Number &value);
    virtual void addInstruction(ASMInstruction &inst);
    
    virtual bool hasLabel(String &label);
    virtual bool hasDefinition(String &label);
    virtual size_t getLabel(String &label);
    virtual Number & getDefinition(String &label);
    virtual Number & cloneNumber(String &label);
    
    virtual size_t prepare();
    virtual void finalize(size_t startAddress);
    virtual bool hasErrors();
    
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream, bool debug = false);
};

#include "I386ASM/ASMOperand.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/ASMInstruction.hpp"

#endif //I386ASMINSTRUCTIONLIST_HPP_LOCK
