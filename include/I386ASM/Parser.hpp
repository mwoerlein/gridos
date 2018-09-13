#ifndef I386ASMPARSER_HPP_LOCK
#define I386ASMPARSER_HPP_LOCK

#include "sys/Object.hpp"
#include "sys/IStream.hpp"

#include "I386ASM/ASMInstructionList.hpp"
#include "I386ASM/ASMInstruction.hpp"
#include "I386ASM/ASMOperand.hpp"
#include "I386ASM/Operand/Number.hpp"
#include "I386ASM/Operand/Identifier.hpp"
#include "I386ASM/Operand/Register.hpp"

class Parser: virtual public Object {
    private:
    MemoryInfo & buffersInfo;
    char *buffer;
    char *limit;
    char *token;
    char *current;
    char *marker;
    char *ctxmarker;
    
    int *linesBuffer;
    int *columnsBuffer;
    int currentLine;
    int currentColumn;
    
    bool freeBuffer(size_t need);
    bool fillBuffer(size_t need, IStream & input);
    
    protected:
    virtual int parseIntegerValue(char * start, char * end, int base = 10);
    virtual OperandSize parseOperandSize(char * start, char * end);
    virtual Number * parseNumber(char * start, char * end);
    virtual Register * parseRegister(char * start, char * end);
    virtual Identifier * parseIdentifier(char * start, char * end);
    virtual ASMOperand * parseOperand(char * start, char * end);
    virtual ASMInstruction * parseInstruction(char * start, char * end, ASMOperand *op1 = 0, ASMOperand *op2 = 0, ASMOperand *op3 = 0);
    
    public:
    Parser(Environment &env, MemoryInfo &mi);
    virtual ~Parser();
    
    virtual ASMInstructionList & parse(IStream & input, int line = 1, int column = 1);
};

#endif //I386ASMPARSER_HPP_LOCK
