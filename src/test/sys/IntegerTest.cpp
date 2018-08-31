#include "test/sys/IntegerTest.hpp"

// public
IntegerTest::IntegerTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
IntegerTest::~IntegerTest() {};

bool IntegerTest::runAll() {
    bool success = true;
    success &= testAssignment();
    success &= testHashAndEquals();
    success &= testComparable();
    success &= testArithmetic();
    return success;
}

// test cases
bool IntegerTest::testAssignment() {
    Integer &i1 = env().create<Integer, int>(-7);
    assertEquals((int) i1, -7, "Creation from native int");
    
    Integer &i2 = env().create<Integer, Integer&>(i1);
    assertEquals((int) i2, -7, "Creation from Integer");
    
    i2 = 99;
    assertEquals((int) i2, 99, "Assign native int");
    
    i1 = i2;
    assertEquals((int) i1, 99, "Assign Integer");
    
    env().destroy(i2);
    env().destroy(i1);
    success();
}

bool IntegerTest::testHashAndEquals() {
    Integer &i1 = env().create<Integer, int>(-19);
    Integer &i2 = env().create<Integer, int>(-19);
    Integer &i3 = env().create<Integer, int>(22);
    
    assertEquals(i1.hash(), i1.hash(), "Constant hash");
    assertEquals(i1.hash(), i2.hash(), "Same hash for same int as different Integers");
    assertNotEquals(i1.hash(), i3.hash(), "Different hash for different ints");

    assert(i1.equals(i1), "Identity check");
    assert(i1.equals(i2), "Same int as different Integers are equal");
    assert(!i1.equals(i3), "Different ints are not equal");
    assert(!i1.equals(env()), "Different Objects are not equal");

    env().destroy(i3);
    env().destroy(i2);
    env().destroy(i1);
    success();
}

bool IntegerTest::testComparable() {
    Integer &i1 = env().create<Integer, int>(-7);
    Integer &i2 = env().create<Integer, int>(0);
    Integer &i3 = env().create<Integer, int>(0);
    Integer &i4 = env().create<Integer, int>(4);
    
    assert(i1 != i2, "-7 != 0");
    assert(i1 <  i2, "-7 <  0");
    assert(i1 <= i2, "-7 <= 0");
    assert(i2 <= i2, "0 <= 0 (identity)");
    assert(i3 <= i2, "0 <= 0 (different Integers)");
    assert(i2 == i2, "0 == 0 (identity)");
    assert(i3 == i2, "0 == 0 (different Integers)");
    assert(i2 >= i2, "0 >= 0 (identity)");
    assert(i3 >= i2, "0 >= 0 (different Integers)");
    assert(i4 >  i2, "4 >  0");
    assert(i4 >= i2, "4 >= 0");
    assert(i4 != i2, "4 != 0");
    
    assertEquals(i1.compareTo(i4), -11, "distance -7 to 4");
    assertEquals(i4.compareTo(i1), 11, "distance 4 to -7");
    
    env().destroy(i4);
    env().destroy(i3);
    env().destroy(i2);
    env().destroy(i1);
    success();
}

bool IntegerTest::testArithmetic() {
    Integer &i1 = env().create<Integer, int>(1);
    Integer &i2 = env().create<Integer, int>(2);
    
    ++i1;
    assertEquals((int) i1, 2, "increment");
    
    --i1;
    assertEquals((int) i1, 1, "decrement");
    
    i1 += i1;
    assertEquals((int) i1, 2, "add Integer");

    i1 += 2;
    assertEquals((int) i1, 4, "add int");

    i1 -= i2;
    assertEquals((int) i1, 2, "sub Integer");

    i1 -= 1;
    assertEquals((int) i1, 1, "sub int");

    i1 *= i2;
    assertEquals((int) i1, 2, "mul Integer");

    i1 *= 99;
    assertEquals((int) i1, 198, "mul int");

    i1 /= i2;
    assertEquals((int) i1, 99, "div Integer");

    i1 /= 7;
    assertEquals((int) i1, 14, "div int");

    i1 %= 9;
    assertEquals((int) i1, 5, "mod int");
    
    i1 %= i2;
    assertEquals((int) i1, 1, "mod Integer");
    
    env().destroy(i2);
    env().destroy(i1);
    success();
}
