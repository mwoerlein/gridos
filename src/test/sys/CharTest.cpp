#include "test/sys/CharTest.hpp"

// public
CharTest::CharTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
CharTest::~CharTest() {};

bool CharTest::runAll() {
    bool success = true;
    success &= testAssignment();
    success &= testHashAndEquals();
    success &= testComparable();
    return success;
}

// test cases
bool CharTest::testAssignment() {
    Char &c1 = env().create<Char, char>('a');
    assertEquals((char) c1, 'a', "Creation from native char");
    
    Char &c2 = env().create<Char, Char&>(c1);
    assertEquals((char) c2, 'a', "Creation from Char");
    
    c2 = 'b';
    assertEquals((char) c2, 'b', "Assign native char");
    
    c1 = c2;
    assertEquals((char) c1, 'b', "Assign Char");
    
    env().destroy(c2);
    env().destroy(c1);
    success();
}

bool CharTest::testHashAndEquals() {
    Char &c1 = env().create<Char, char>('x');
    Char &c2 = env().create<Char, char>('x');
    Char &c3 = env().create<Char, char>('y');
    
    assertEquals(c1.hash(), c1.hash(), "Constant hash");
    assertEquals(c1.hash(), c2.hash(), "Same hash for same char as different Chars");
    assertNotEquals(c1.hash(), c3.hash(), "Different hash for different chars");

    assert(c1.equals(c1), "Identity check");
    assert(c1.equals(c2), "Same char as different Chars are equal");
    assert(!c1.equals(c3), "Different chars are not equal");
    assert(!c1.equals(env()), "Different Objects are not equal");
    
    env().destroy(c3);
    env().destroy(c2);
    env().destroy(c1);
    success();
}

bool CharTest::testComparable() {
    Char &c1 = env().create<Char, char>('A');
    Char &c2 = env().create<Char, char>('B');
    Char &c3 = env().create<Char, char>('B');
    Char &c4 = env().create<Char, char>('C');
    
    assert(c1 != c2, "A != B");
    assert(c1 <  c2, "A <  B");
    assert(c1 <= c2, "A <= B");
    assert(c2 <= c2, "B <= B (identity)");
    assert(c3 <= c2, "B <= B (different Chars)");
    assert(c2 == c2, "B == B (identity)");
    assert(c3 == c2, "B == B (different Chars)");
    assert(c2 >= c2, "B >= B (identity)");
    assert(c3 >= c2, "B >= B (different Chars)");
    assert(c4 >  c2, "C >  B");
    assert(c4 >= c2, "C >= B");
    assert(c4 != c2, "C != B");
    
    assertEquals(c1.compareTo(c4), -2, "distance A to C");
    assertEquals(c4.compareTo(c1),  2, "distance C to A");
    
    env().destroy(c4);
    env().destroy(c3);
    env().destroy(c2);
    env().destroy(c1);
    success();
}
