#ifndef TEST_I386ASM_INSTRUCTION_ADDTEST_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_ADDTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class AddTest: public ParserBasedTestCase {
    protected:
    bool testMI();
    bool testMR();
    bool testRM();
    
    public:
    AddTest(Environment &env, MemoryInfo &mi);
    virtual ~AddTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_ADDTEST_HPP_LOCK
