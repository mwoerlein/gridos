#ifndef TEST_I386ASM_CODEDATAADDRTEST_HPP_LOCK
#define TEST_I386ASM_CODEDATAADDRTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class CodeDataAddrTest: public ParserBasedTestCase {
    protected:
    
    public:
    CodeDataAddrTest(Environment &env, MemoryInfo &mi);
    virtual ~CodeDataAddrTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_CODEDATAADDRTEST_HPP_LOCK
