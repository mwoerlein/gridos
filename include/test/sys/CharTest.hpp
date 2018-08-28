#ifndef CHARTEST_HPP_LOCK
#define CHARTEST_HPP_LOCK

#include "sys/Char.hpp"
#include "test/TestCase.hpp"

class CharTest: public TestCase {
    protected:
    bool testAssignment();
    bool testHashAndEquals();
    bool testComparable();
    
    public:
    CharTest(Environment &env, MemoryInfo &mi);
    virtual ~CharTest();

    virtual bool runAll() override;
};

#endif //CHARTEST_HPP_LOCK

