#ifndef BOOLTEST_HPP_LOCK
#define BOOLTEST_HPP_LOCK

#include "sys/Bool.hpp"
#include "test/TestCase.hpp"

class BoolTest: public TestCase {
    protected:
    bool testAssignment();
    bool testHashAndEquals();
    
    public:
    BoolTest(Environment &env, MemoryInfo &mi);
    virtual ~BoolTest();

    virtual bool runAll() override;
};

#endif //BOOLTEST_HPP_LOCK

