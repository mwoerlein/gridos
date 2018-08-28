#ifndef INTEGERTEST_HPP_LOCK
#define INTEGERTEST_HPP_LOCK

#include "sys/Integer.hpp"
#include "test/TestCase.hpp"

class IntegerTest: public TestCase {
    protected:
    bool testAssignment();
    bool testHashAndEquals();
    bool testComparable();
    bool testArithmetic();
    
    public:
    IntegerTest(Environment &env, MemoryInfo &mi);
    virtual ~IntegerTest();

    virtual bool runAll() override;
};

#endif //INTEGERTEST_HPP_LOCK

