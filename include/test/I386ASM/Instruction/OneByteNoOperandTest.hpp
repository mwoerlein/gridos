#ifndef TEST_I386ASM_INSTRUCTION_ONEBYTENOOPERAND_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_ONEBYTENOOPERAND_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class OneByteNoOperandTest: public ParserBasedTestCase {
    public:
    OneByteNoOperandTest(Environment &env, MemoryInfo &mi);
    virtual ~OneByteNoOperandTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_ONEBYTENOOPERAND_HPP_LOCK
