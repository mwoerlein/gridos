#include "test/sys/DigitTest.hpp"

// public
DigitTest::DigitTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
DigitTest::~DigitTest() {};

bool DigitTest::runAll() {
    bool success = true;
    success &= testAssignment();
    success &= testHashAndEquals();
    success &= testComparable();
    return success;
}

// test cases
bool DigitTest::testAssignment() {
    Digit &d1 = env().create<Digit, char>('A');
    assertEquals((char) d1, 'a', "Creation from native char (char)");
    assertEquals((int) d1, 10, "Creation from native char (int)");
    
    Digit &d2 = env().create<Digit, int>(2);
    assertEquals((char) d2, '2', "Creation from nativ int (char)");
    assertEquals((int) d2, 2, "Creation from nativ int (int)");
    
    Char &c = env().create<Char, char>('3');
    Digit &d3 = env().create<Digit, Char&>(c);
    assertEquals((char) d3, '3', "Creation from Char (char)");
    assertEquals((int) d3, 3, "Creation from Char (int)");
    
    Digit &d4 = env().create<Digit, Digit&>(d1);
    assertEquals((char) d4, 'a', "Creation from Digit (char)");
    assertEquals((int) d4, 10, "Creation from Digit (int)");

    Integer &i = env().create<Integer, int>(5);
    Digit &d5 = env().create<Digit, Integer&>(i);
    assertEquals((char) d5, '5', "Creation from Integer (char)");
    assertEquals((int) d5, 5, "Creation from Integer (int)");
    
    d4 = '0';
    assertEquals((char) d4, '0', "Assign native char (char)");
    assertEquals((int) d4, 0, "Assign native char (int)");

    d4 = 11;
    assertEquals((char) d4, 'b', "Assign native int (char)");
    assertEquals((int) d4, 11, "Assign native int (int)");
    
    d4 = c;
    assertEquals((char) d4, '3', "Assign Char (char)");
    assertEquals((int) d4, 3, "Assign Char (int)");
    
    d4 = d2;
    assertEquals((char) d4, '2', "Assign Digit (char)");
    assertEquals((int) d4, 2, "Assign Digit (int)");
    
    d4 = i;
    assertEquals((char) d4, '5', "Assign Integer (char)");
    assertEquals((int) d4, 5, "Assign Integer (int)");
    
    d1 = '%';
    assertEquals((char) d1, '?', "Assign invalid native char (char)");
    assertEquals((int) d1, -1, "Assign invalid native char (int)");

    d2 = -1;
    assertEquals((char) d2, '?', "Assign invalid native int (char)");
    assertEquals((int) d2, -1, "Assign invalid native int (int)");
    
    c = '&'; d3 = c;
    assertEquals((char) d3, '?', "Assign invalid Char (char)");
    assertEquals((int) d3, -1, "Assign invalid Char (int)");
    
    d4 = d2;
    assertEquals((char) d4, '?', "Assign invalid Digit (char)");
    assertEquals((int) d4, -1, "Assign invalid Digit (int)");
    
    i = 100; d5 = i;
    assertEquals((char) d5, '?', "Assign invalid Integer (char)");
    assertEquals((int) d5, -1, "Assign invalid Integer (int)");
    
    env().destroy(c);
    env().destroy(i);
    env().destroy(d5);
    env().destroy(d4);
    env().destroy(d3);
    env().destroy(d2);
    env().destroy(d1);
    success();
}

bool DigitTest::testHashAndEquals() {
    Digit &d1 = env().create<Digit, int>(19);
    Digit &d2 = env().create<Digit, int>(19);
    Digit &d3 = env().create<Digit, int>(22);
    Digit &d4 = env().create<Digit, int>(-1);
    Digit &d5 = env().create<Digit, int>(40);
    
    assertEquals(d1.hash(), d1.hash(), "Constant hash");
    assertEquals(d1.hash(), d2.hash(), "Same hash for same digit as different Digits");
    assertNotEquals(d1.hash(), d3.hash(), "Different hash for different digits");
    assertEquals(d4.hash(), d5.hash(), "Same hash for all invalid Digits");

    assert(d1.equals(d1), "Identity check");
    assert(d1.equals(d2), "Same digit as different Digits are equal");
    assert(!d1.equals(d3), "Different digits are not equal");
    assert(d4.equals(d5), "Invalid digits are equal");
    
    env().destroy(d5);
    env().destroy(d4);
    env().destroy(d3);
    env().destroy(d2);
    env().destroy(d1);
    success();
}

bool DigitTest::testComparable() {
    Digit &d1 = env().create<Digit, char>('6');
    Digit &d2 = env().create<Digit, char>('B');
    Digit &d3 = env().create<Digit, char>('B');
    Digit &d4 = env().create<Digit, char>('C');
    
    assert(d1 != d2, "6 != b");
    assert(d1 <  d2, "6 <  b");
    assert(d1 <= d2, "6 <= b");
    assert(d2 <= d2, "b <= b (identity)");
    assert(d3 <= d2, "b <= b (different Digits)");
    assert(d2 == d2, "b == b (identity)");
    assert(d3 == d2, "b == b (different Digits)");
    assert(d2 >= d2, "b >= b (identity)");
    assert(d3 >= d2, "b >= b (different Digits)");
    assert(d4 >  d2, "c >  b");
    assert(d4 >= d2, "c >= b");
    assert(d4 != d2, "c != b");
    
    assertEquals(d1.compareTo(d4), ('6'-'c'), "distance 6 to c");
    assertEquals(d4.compareTo(d1), ('c'-'6'), "distance c to 6");
    
    env().destroy(d4);
    env().destroy(d3);
    env().destroy(d2);
    env().destroy(d1);
    success();
}
