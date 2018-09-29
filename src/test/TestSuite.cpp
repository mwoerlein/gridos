#include "test/TestSuite.hpp"

#include "memory/MemoryRegistry.hpp"
#include "memory/MemoryManager.hpp"
#include "KernelJIT/ModuleInfo.hpp"

#include "test/sys/BoolTest.hpp"
#include "test/sys/CharTest.hpp"
#include "test/sys/DigitTest.hpp"
#include "test/sys/IntegerTest.hpp"
#include "test/sys/StringTest.hpp"

#include "test/sys/collection/LinkedListTest.hpp"
#include "test/sys/collection/HashMapTest.hpp"

#include "test/I386ASM/ParserTest.hpp"
#include "test/I386ASM/Instruction/MoveTest.hpp"
#include "test/I386ASM/Instruction/OneByteNoOperandTest.hpp"

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
//*/
    
//*/
    run<OneByteNoOperandTest>();
    run<MoveTest>();
    run<ParserTest>();
//*/
}

// private
Environment & TestSuite::createTestEnvironment(size_t memorySize) {
    // prepare sandbox memory
    MemoryInfo &testMemoryInfo = env().getAllocator().allocate(memorySize, this);
    MemoryRegistry memoryRegistry(env());
    memoryRegistry.registerAvailableMemory(testMemoryInfo.buf, testMemoryInfo.len);
    MemoryManager &mm = env().create<MemoryManager>();
    memoryRegistry.transfer(mm);
    
    // create own test environment    
    Environment &testEnv = env().create<Environment, MemoryAllocator&, OStream&, OStream&>(mm, env().out(), env().err());
    testEnv.setOStreamFactory(env().oStreamFactory());
    // store test memory as module, to be accessible after test for memory hole detection and cleanup
    testEnv.setModules(
        env().create<ModuleInfo, MemoryInfo &, String &>(
            testMemoryInfo,
            env().create<String, const char *>("testMemory")
        )
    );
    
    return testEnv;
}

void TestSuite::destroyTestEnvironment(Environment &testEnvironment, bool checkMemory) {
    ModuleInfo &testMemoryModule = testEnvironment.getModules();
    MemoryAllocator &testAllocator = testEnvironment.getAllocator();
    
    if (checkMemory && testAllocator.getAvailableBytes() != testMemoryModule.memoryInfo.len) {
        testEnvironment.err() << "memory hole detected!\n";
        testAllocator.dump(testEnvironment.err(), true);
    }
    
    // cleanup test resources
    testEnvironment.destroy();
    testAllocator.destroy();
    testMemoryModule.destroy(); // implicit sandbox destruction
}
