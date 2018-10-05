#ifndef TEST_SYS_COLLECTION_PROPERTYCONTAINER_HPP_LOCK
#define TEST_SYS_COLLECTION_PROPERTYCONTAINER_HPP_LOCK

#include "sys/collection/PropertyContainer.hpp"
#include "test/TestCase.hpp"

class PropertyContainerTest: public TestCase {
    protected:
    bool testObjectProperties();
    bool testStringProperties();
    
    public:
    PropertyContainerTest(Environment &env, MemoryInfo &mi);
    virtual ~PropertyContainerTest();

    virtual bool runAll() override;
};

#endif //TEST_SYS_COLLECTION_PROPERTYCONTAINER_HPP_LOCK
