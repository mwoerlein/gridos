#ifndef I386ASMPARSER_HPP_LOCK
#define I386ASMPARSER_HPP_LOCK

#include "I386ASM/ASMInstructionList.hpp"
#include "sys/IStream.hpp"
#include "sys/Object.hpp"

class Parser: public Object {
    private:
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
    
    public:
    Parser(Environment &env);
    virtual ~Parser();
    
    virtual ASMInstructionList & parse(IStream & input, int line = 1, int column = 1);
};

#endif //I386ASMPARSER_HPP_LOCK
