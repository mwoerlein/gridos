#ifndef PARSERBASEDTESTCASE_HPP_LOCK
#define PARSERBASEDTESTCASE_HPP_LOCK

#include "I386ASM/Parser.hpp"
#include "test/TestCase.hpp"
#include "sys/String.hpp"

class ParserBasedTestCase: public TestCase {
    protected:
    Parser &parser;
    
    ASMInstructionList & parseSilent(IStream & input, String & errorBuffer);
    
    bool test(const char * input, const char * expectedBinary, const char * expectedPretty = 0, const char * message = 0, void * start = 0, const char * dumpBinary = 0);
    bool test(String & input, String & expectedBinary, String & expectedPretty, String & message, void * start = 0, const char * dumpBinary = 0);
    
    public:
    ParserBasedTestCase(Environment &env, MemoryInfo &mi);
    virtual ~ParserBasedTestCase();
};

#endif //PARSERBASEDTESTCASE_HPP_LOCK
