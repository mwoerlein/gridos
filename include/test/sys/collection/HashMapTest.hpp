#ifndef COLLECTION_HASHMAPTEST_HPP_LOCK
#define COLLECTION_HASHMAPTEST_HPP_LOCK

#include "sys/collection/HashMap.hpp"
#include "test/TestCase.hpp"

class HashMapTest: public TestCase {
    protected:
    bool testSetGetHasContainsUnset();
    bool testIteratorsAndClear();
    
    public:
    HashMapTest(Environment &env, MemoryInfo &mi);
    virtual ~HashMapTest();

    virtual bool runAll() override;
};

#endif //COLLECTION_HASHMAPTEST_HPP_LOCK

