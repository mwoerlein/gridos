#ifndef TEST_I386ASM_INSTRUCTION_INLINEALIGNORGTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_INLINEALIGNORGTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class InlineAlignOrgTest: public ParserBasedTestCase {
    public:
    InlineAlignOrgTest(Environment &env, MemoryInfo &mi);
    virtual ~InlineAlignOrgTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_INLINEALIGNORGTEST_HPP_LOCK
