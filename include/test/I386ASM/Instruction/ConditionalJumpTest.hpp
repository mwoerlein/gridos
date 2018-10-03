#ifndef TEST_I386ASM_INSTRUCTION_CONDITIONALJUMPTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_CONDITIONALJUMPTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class ConditionalJumpTest: public ParserBasedTestCase {
    protected:
    bool testD();
    
    public:
    ConditionalJumpTest(Environment &env, MemoryInfo &mi);
    virtual ~ConditionalJumpTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_CONDITIONALJUMPTEST_HPP_LOCK
