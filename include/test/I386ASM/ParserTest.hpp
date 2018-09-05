#ifndef PARSERTEST_HPP_LOCK
#define PARSERTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class ParserTest: public ParserBasedTestCase {
    protected:
    
    public:
    ParserTest(Environment &env, MemoryInfo &mi);
    virtual ~ParserTest();

    virtual bool runAll() override;
};

#endif //PARSERTEST_HPP_LOCK
