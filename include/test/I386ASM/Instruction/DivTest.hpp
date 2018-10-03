#ifndef TEST_I386ASM_INSTRUCTION_DIVTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_DIVTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class DivTest: public ParserBasedTestCase {
    protected:
    bool testM();
    
    public:
    DivTest(Environment &env, MemoryInfo &mi);
    virtual ~DivTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_DIVTEST_HPP_LOCK
