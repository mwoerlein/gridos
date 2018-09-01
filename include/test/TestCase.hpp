#ifndef TESTCASE_HPP_LOCK
#define TESTCASE_HPP_LOCK

#include "sys/Object.hpp"

#define assert(successful, message) if (!(successful)) { env().err() << __PRETTY_FUNCTION__ << " failed: " << message << '\n'; return false; }
#define assertEquals(value, expected, message) if ((value) != (expected)) {\
    env().err() << __PRETTY_FUNCTION__ << " failed: " << message << " (expected: " << (expected) << " got: " << (value) << ")\n"; return false;\
}
#define assertNotEquals(value, expected, message) if ((value) == (expected)) {\
    env().err() << __PRETTY_FUNCTION__ << " failed: " << message << " (got not expected: " << (value) << ")\n"; return false;\
}
#define incomplete() env().err() << __PRETTY_FUNCTION__ << " incomplete!" << '\n'; return true;
#define success() env().out() << __PRETTY_FUNCTION__ << " successful!" << '\n'; return true;

class TestCase: public Object {
    protected:
    
    public:
    TestCase(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~TestCase();
    
    virtual bool runAll() = 0;
};

#endif //TESTCASE_HPP_LOCK

