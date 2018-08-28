#include "test/TestSuite.hpp"

#include "memory/MemoryRegistry.hpp"
#include "memory/MemoryManager.hpp"
#include "KernelJIT/ModuleInfo.hpp"

#include "test/sys/CharTest.hpp"
#include "test/sys/DigitTest.hpp"
#include "test/sys/IntegerTest.hpp"

// public
TestSuite::TestSuite(Environment &env, MemoryInfo &mi): Object(env, mi) {}
TestSuite::~TestSuite() {};

void TestSuite::runAll() {
    run<CharTest>();
    run<DigitTest>();
    run<IntegerTest>();
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
    Environment &testEnv = env().create<Environment, MemoryAllocator&, OStream&>(mm, env().getStdO());
    // store test memory as module, to be accessible after test for memory hole detection and cleanup
    testEnv.setModules(env().create<ModuleInfo, MemoryInfo &, char *>(testMemoryInfo, (char*) "testMemory"));
    
    return testEnv;
}

void TestSuite::destroyTestEnvironment(Environment &testEnv, bool checkMemory) {
    ModuleInfo &testMemory = testEnv.getModules();
    MemoryAllocator &ma = testEnv.getAllocator();
    
    if (checkMemory && testEnv.getAllocator().getAvailableBytes() != testMemory.memoryInfo.len) {
        testEnv.getStdO() << "memory hole detected!\n";
        ma.dump(true);
    }
    
    // cleanup test resources
    env().destroy(ma);
    env().destroy(testEnv);
    env().destroy(testMemory); // implicit sandbox destruction
}
