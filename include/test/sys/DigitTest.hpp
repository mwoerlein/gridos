#ifndef DIGITTEST_HPP_LOCK
#define DIGITTEST_HPP_LOCK

#include "sys/Digit.hpp"
#include "test/TestCase.hpp"

class DigitTest: public TestCase {
    protected:
    bool testAssignment();
    bool testHashAndEquals();
    bool testComparable();
    
    public:
    DigitTest(Environment &env, MemoryInfo &mi);
    virtual ~DigitTest();

    virtual bool runAll() override;
};

#endif //DIGITTEST_HPP_LOCK

