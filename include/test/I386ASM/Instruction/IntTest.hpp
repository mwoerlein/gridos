#ifndef TEST_I386ASM_INSTRUCTION_INTTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_INTTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class IntTest: public ParserBasedTestCase {
    public:
    IntTest(Environment &env, MemoryInfo &mi);
    virtual ~IntTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_INTTEST_HPP_LOCK
