#ifndef MOVETEST_HPP_LOCK
#define MOVETEST_HPP_LOCK

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

#endif //MOVETEST_HPP_LOCK
