#include "test/sys/BoolTest.hpp"

// public
BoolTest::BoolTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
BoolTest::~BoolTest() {};

bool BoolTest::runAll() {
    bool success = true;
    success &= testAssignment();
    success &= testHashAndEquals();
    return success;
}

// test cases
bool BoolTest::testAssignment() {
    Bool &b1 = env().create<Bool, bool>(true);
    assertEquals((bool) b1, true, "Creation from native bool");
    
    Bool &b2 = env().create<Bool, Bool&>(b1);
    assertEquals((bool) b1, true, "Creation from Bool");
    
    b2 = false;
    assertEquals((bool) b2, false, "Assign native bool");
    
    b1 = b2;
    assertEquals((bool) b1, false, "Assign Bool");
    
    b2.destroy();
    b1.destroy();
    success();
}

bool BoolTest::testHashAndEquals() {
    Bool &b1 = env().create<Bool, bool>(true);
    Bool &b2 = env().create<Bool, bool>(true);
    Bool &b3 = env().create<Bool, bool>(false);
    
    assertEquals(b1.hash(), b1.hash(), "Constant hash");
    assertEquals(b1.hash(), b2.hash(), "Same hash for same bool as different Bools");
    assertNotEquals(b1.hash(), b3.hash(), "Different hash for different bools");

    assert(b1.equals(b1), "Identity check");
    assert(b1.equals(b2), "Same char as different Chars are equal");
    assert(!b1.equals(b3), "Different chars are not equal");
    assert(!b1.equals(env()), "Different Objects are not equal");
    
    b3.destroy();
    b2.destroy();
    b1.destroy();
    success();
}
