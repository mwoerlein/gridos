#ifndef TEST_I386ASM_INSTRUCTION_INOUTTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_INOUTTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class InOutTest: public ParserBasedTestCase {
    public:
    InOutTest(Environment &env, MemoryInfo &mi);
    virtual ~InOutTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_INOUTTEST_HPP_LOCK
