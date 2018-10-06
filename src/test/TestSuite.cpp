#include "test/TestSuite.hpp"

#include "memory/MemoryRegistry.hpp"
#include "memory/MemoryManager.hpp"

#include "test/sys/BoolTest.hpp"
#include "test/sys/CharTest.hpp"
#include "test/sys/DigitTest.hpp"
#include "test/sys/IntegerTest.hpp"
#include "test/sys/StringTest.hpp"

#include "test/sys/collection/LinkedListTest.hpp"
#include "test/sys/collection/HashMapTest.hpp"
#include "test/sys/collection/PropertyContainerTest.hpp"

#include "test/I386ASM/ParserTest.hpp"
#include "test/I386ASM/Instruction/MoveTest.hpp"
#include "test/I386ASM/Instruction/AddTest.hpp"
#include "test/I386ASM/Instruction/DivTest.hpp"
#include "test/I386ASM/Instruction/JumpTest.hpp"
#include "test/I386ASM/Instruction/ConditionalJumpTest.hpp"
#include "test/I386ASM/Instruction/NoOperandInstructionTest.hpp"

// public
TestSuite::TestSuite(Environment &env, MemoryInfo &mi): Object(env, mi) {}
TestSuite::~TestSuite() {};

void TestSuite::runAll() {
//*/
    run<BoolTest>();
    run<CharTest>();
    run<DigitTest>();
    run<IntegerTest>();
    run<StringTest>();
//*/
    
//*/
    run<LinkedListTest>();
    run<HashMapTest>();
    run<PropertyContainerTest>();
//*/
    
//*/
    run<NoOperandInstructionTest>();
    run<MoveTest>();
    run<AddTest>();
    run<DivTest>();
    run<JumpTest>();
    run<ConditionalJumpTest>();
    run<ParserTest>();
//*/
}

// private
Environment & TestSuite::createTestEnvironment(size_t memorySize) {
    // prepare sandbox memory
    currentTestMemoryInfo = &env().getAllocator().allocate(memorySize, this);
    MemoryRegistry memoryRegistry(env());
    memoryRegistry.registerAvailableMemory(currentTestMemoryInfo->buf, currentTestMemoryInfo->len);
    MemoryManager &mm = env().create<MemoryManager>();
    memoryRegistry.transfer(mm);
    
    // create own test environment    
    Environment &testEnv = env().create<Environment, MemoryAllocator&, OStream&, OStream&>(mm, env().out(), env().err());
    testEnv.setOStreamFactory(env().oStreamFactory());
    
    return testEnv;
}

void TestSuite::destroyTestEnvironment(Environment &testEnvironment, bool checkMemory) {
    MemoryAllocator &testAllocator = testEnvironment.getAllocator();
    
    if (checkMemory && testAllocator.getAvailableBytes() != currentTestMemoryInfo->len) {
        testEnvironment.err() << "memory hole detected!\n";
        testAllocator.dump(testEnvironment.err(), true);
    }
    
    // cleanup test resources
    testEnvironment.destroy();
    testAllocator.destroy();
    env().getAllocator().free(*currentTestMemoryInfo);
}
