#ifndef COLLECTION_LINKEDLISTTEST_HPP_LOCK
#define COLLECTION_LINKEDLISTTEST_HPP_LOCK

#include "sys/collection/LinkedList.hpp"
#include "test/TestCase.hpp"

class LinkedListTest: public TestCase {
    protected:
    bool testAddAndRemove();
    
    public:
    LinkedListTest(Environment &env, MemoryInfo &mi);
    virtual ~LinkedListTest();

    virtual bool runAll() override;
};

#endif //COLLECTION_LINKEDLISTTEST_HPP_LOCK

