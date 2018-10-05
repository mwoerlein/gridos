#ifndef I386ASMINSTRUCTIONLIST_HPP_LOCK
#define I386ASMINSTRUCTIONLIST_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/String.hpp"
#include "sys/collection/HashMap.hpp"
#include "I386ASM/ParseErrorStream.hpp"

class Number;
class Identifier;
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
    virtual Number & getNumberForDefinition(String &label);

    virtual bool hasLabel(Identifier &id);
    virtual bool hasDefinition(Identifier &id);
    virtual size_t getLabel(Identifier &id);
    virtual Number & getNumberForDefinition(Identifier &id);
    
    virtual size_t compile();
    virtual void finalize(size_t startAddress);
    virtual bool hasErrors();
    
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream, bool debug = false);
};

#include "I386ASM/ASMOperand.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/ASMInstruction.hpp"

#endif //I386ASMINSTRUCTIONLIST_HPP_LOCK
