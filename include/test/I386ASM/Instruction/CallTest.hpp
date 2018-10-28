#ifndef TEST_I386ASM_INSTRUCTION_CALLTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_CALLTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class CallTest: public ParserBasedTestCase {
    protected:
    bool testRelative();
    bool testIndirect();
    
    public:
    CallTest(Environment &env, MemoryInfo &mi);
    virtual ~CallTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_CALLTEST_HPP_LOCK
