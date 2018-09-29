#ifndef TEST_I386ASM_INSTRUCTION_MOVETEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_MOVETEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class MoveTest: public ParserBasedTestCase {
    protected:
    bool testMR();
    bool testRM();
    bool testOI();
    bool testMI();
    
    public:
    MoveTest(Environment &env, MemoryInfo &mi);
    virtual ~MoveTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_MOVETEST_HPP_LOCK
