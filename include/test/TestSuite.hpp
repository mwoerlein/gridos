#ifndef TESTSUITE_HPP_LOCK
#define TESTSUITE_HPP_LOCK

#include "sys/Object.hpp"
#include "test/TestCase.hpp"

class TestSuite: public Object {
    private:
    Environment &createTestEnvironment(size_t memorySize);
    void destroyTestEnvironment(Environment &env, bool checkMemory = true);
    
    public:
    TestSuite(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~TestSuite();
    
    template <class TC> void run(size_t memorySize = 0x100000) {
        Environment &testEnv = createTestEnvironment(memorySize);
        TestCase & tc = testEnv.create<TC>();
        bool success = tc.runAll();
        testEnv.destroy(tc);
        destroyTestEnvironment(testEnv, success);
    }
    
    void runAll();
};

#endif //TESTSUITE_HPP_LOCK

