#ifndef TEST_I386ASM_INSTRUCTION_PUSHPOPTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_PUSHPOPTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class PushPopTest: public ParserBasedTestCase {
    protected:
    bool testM();
    bool testO();
    bool testI();
    bool testZO();
    
    public:
    PushPopTest(Environment &env, MemoryInfo &mi);
    virtual ~PushPopTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_PUSHPOPTEST_HPP_LOCK
