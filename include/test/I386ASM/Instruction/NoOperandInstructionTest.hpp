#ifndef TEST_I386ASM_INSTRUCTION_NOOPERANDINSTRUCTION_HPP_LOCK
#define TEST_I386ASM_INSTRUCTION_NOOPERANDINSTRUCTION_HPP_LOCK

#include "test/I386ASM/ParserBasedTestCase.hpp"

class NoOperandInstructionTest: public ParserBasedTestCase {
    public:
    NoOperandInstructionTest(Environment &env, MemoryInfo &mi);
    virtual ~NoOperandInstructionTest();

    virtual bool runAll() override;
};

#endif //TEST_I386ASM_INSTRUCTION_NOOPERANDINSTRUCTION_HPP_LOCK
