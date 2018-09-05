#ifndef PARSERBASEDTESTCASE_HPP_LOCK
#define PARSERBASEDTESTCASE_HPP_LOCK

#include "I386ASM/Parser.hpp"
#include "test/TestCase.hpp"
#include "sys/String.hpp"

class ParserBasedTestCase: public TestCase {
    protected:
    Parser &parser;
    
    ASMInstructionList & parseSilent(IStream & input);
    
    bool test(const char * input, const char * expectedBinary, const char * expectedPretty = 0, const char * message = 0);
    bool test(String & input, String & expectedBinary, String & expectedPretty, String & message);
    
    public:
    ParserBasedTestCase(Environment &env, MemoryInfo &mi);
    virtual ~ParserBasedTestCase();
};

#endif //PARSERBASEDTESTCASE_HPP_LOCK
