#ifndef STRINGTEST_HPP_LOCK
#define STRINGTEST_HPP_LOCK

#include "sys/String.hpp"
#include "test/TestCase.hpp"

class StringTest: public TestCase {
    protected:
    bool testAssignmentAndLength();
    bool testHashAndEquals();
    bool testComparable();
    bool testIStream();
    bool testOStreamAndAppend();
    
    public:
    StringTest(Environment &env, MemoryInfo &mi);
    virtual ~StringTest();

    virtual bool runAll() override;
};

#endif //STRINGTEST_HPP_LOCK

