#ifndef TEST_I386ASM_INSTRUCTION_JUMPTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_JUMPTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class JumpTest: public ParserBasedTestCase {
    protected:
    bool testRelative();
    bool testIndirect();
    
    public:
    JumpTest(Environment &env, MemoryInfo &mi);
    virtual ~JumpTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_JUMPTEST_HPP_LOCK
