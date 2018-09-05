#ifndef HALTTEST_HPP_LOCK
#define HALTTEST_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class HaltTest: public ParserBasedTestCase {
    public:
    HaltTest(Environment &env, MemoryInfo &mi);
    virtual ~HaltTest();

    virtual bool runAll() override;
};

#endif //HALTTEST_HPP_LOCK
