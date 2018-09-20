#include "test/sys/collection/LinkedListTest.hpp"

#include "sys/Char.hpp"
#include "sys/Integer.hpp"

// public
LinkedListTest::LinkedListTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
LinkedListTest::~LinkedListTest() {};

bool LinkedListTest::runAll() {
    bool success = true;
    success &= testAddAndRemove();
    success &= testIterableAndClear();
    return success;
}

// test cases
bool LinkedListTest::testAddAndRemove() {
    Char &a = env().create<Char, char>('a');
    Char &b = env().create<Char, char>('b');
    Char &c = env().create<Char, char>('c');
    
    LinkedList<Char> &l = env().create<LinkedList<Char>>();
    assertTrue(l.isEmpty(), "new list is empty");
    assertEquals(l.size(), 0, "new list has size 0");
    assertFalse(l.contains(a), "new list does not contain 'a'");
    assertFalse(l.contains(b), "new list does not contain 'b'");
    assertFalse(l.contains(c), "new list does not contain 'c'");
    
    assertTrue(l.add(a), "list () adds element 'a'");
    assertFalse(l.isEmpty(), "list ('a') is not empty");
    assertEquals(l.size(), 1, "list ('a') has size 1");
    assertTrue(l.contains(a), "list ('a') contains 'a'");
    assertFalse(l.contains(b), "list ('a') does not contain 'b'");
    assertFalse(l.contains(c), "list ('a') does not contain 'c'");
    
    assertTrue(l.add(b), "list ('a') adds element 'b'");
    assertFalse(l.isEmpty(), "list ('a','b') is not empty");
    assertEquals(l.size(), 2, "list ('a','b') has size 2");
    assertTrue(l.contains(a), "list ('a','b') contains 'a'");
    assertTrue(l.contains(b), "list ('a','b') contains 'b'");
    assertFalse(l.contains(c), "list ('a','b') does not contain 'c'");
    
    assertTrue(l.add(a), "list ('a','b') add element 'a'");
    assertFalse(l.isEmpty(), "list ('a','b','a') is not empty");
    assertEquals(l.size(), 3, "list ('a','b','a') has size 3");
    assertTrue(l.contains(a), "list ('a','b','a') contains 'a'");
    assertTrue(l.contains(b), "list ('a','b','a') contains 'b'");
    assertFalse(l.contains(c), "list ('a','b','a') does not contain 'c'");
    
    assertTrue(l.add(c), "list ('a','b','a') adds element 'c'");
    assertFalse(l.isEmpty(), "list ('a','b','a','c') is not empty");
    assertEquals(l.size(), 4, "list ('a','b','a','c') has size 4");
    assertTrue(l.contains(a), "list ('a','b','a','c') contains 'a'");
    assertTrue(l.contains(b), "list ('a','b','a','c') contains 'b'");
    assertTrue(l.contains(c), "list ('a','b','a','c') contains 'c'");
    
    assertTrue(l.remove(b), "list ('a','b','a','c') removes element 'b'");
    assertFalse(l.isEmpty(), "list ('a','a','c') is not empty");
    assertEquals(l.size(), 3, "list ('a','a','c') has size 3");
    assertTrue(l.contains(a), "list ('a','a','c') contains 'a'");
    assertFalse(l.contains(b), "list ('a','a','c') does not contain 'b'");
    assertTrue(l.contains(c), "list ('a','a','c') contains 'c'");
    
    assertFalse(l.remove(b), "list ('a','a','c') does not remove element 'b'");
    
    assertTrue(l.remove(a), "list ('a','a','c') removes element 'a'");
    assertFalse(l.isEmpty(), "list ('a','c') is not empty");
    assertEquals(l.size(), 2, "list ('a','c') has size 2");
    assertTrue(l.contains(a), "list ('a','c') contains 'a'");
    assertFalse(l.contains(b), "list ('a','c') does not contain 'b'");
    assertTrue(l.contains(c), "list ('a','c') contains 'c'");
    
    assertTrue(l.remove(c), "list ('a','c') removes element 'c'");
    assertFalse(l.isEmpty(), "list ('a') is not empty");
    assertEquals(l.size(), 1, "list ('a') has size 1");
    assertTrue(l.contains(a), "list ('a') contains 'a'");
    assertFalse(l.contains(b), "list ('a') does not contain 'b'");
    assertFalse(l.contains(c), "list ('a') does not contain 'c'");
    
    assertTrue(l.remove(a), "list ('a') removes element 'c'");
    assertTrue(l.isEmpty(), "cleared list is empty");
    assertEquals(l.size(), 0, "cleared list has size 0");
    assertFalse(l.contains(a), "cleared list does not contain 'a'");
    assertFalse(l.contains(b), "cleared list does not contain 'b'");
    assertFalse(l.contains(c), "cleared list does not contain 'c'");
    
    assertFalse(l.remove(a), "cleared list does not remove element 'a'");
    
    l.destroy();
    c.destroy();
    b.destroy();
    a.destroy();
    success();
}

bool LinkedListTest::testIterableAndClear() {
    Integer &a = env().create<Integer, int>(0);
    Integer &b = env().create<Integer, int>(1);
    Integer &c = env().create<Integer, int>(6);
    
    LinkedList<Integer> &l = env().create<LinkedList<Integer>>();

    {    
        Iterator<Integer> &it = l.iterator();
        assertFalse(it.hasNext(), "empty list iterator has no element");
        it.destroy();
    }
    
    l.add(a); l.add(b); l.add(c); l.add(a);
    assertFalse(l.isEmpty(), "filled list is not empty");
    assertEquals(l.size(), 4, "filled list has size");

    {    
        Iterator<Integer> &it = l.iterator();
        assertTrue(it.hasNext(), "filled list iterator has first element");
        assertEquals(it.next(), a, "filled list iterator has first element 0");
        assertTrue(it.hasNext(), "filled list iterator has second element");
        assertEquals(it.next(), b, "filled list iterator has second element 1");
        assertTrue(it.hasNext(), "filled list iterator has third element");
        assertEquals(it.next(), c, "filled list iterator has third element 6");
        assertTrue(it.hasNext(), "filled list iterator has forth element");
        assertEquals(it.next(), a, "filled list iterator has forth element 0");
        assertFalse(it.hasNext(), "filled list iterator has no fifth element");
        it.destroy();
    }

    l.clear();
    assertTrue(l.isEmpty(), "cleared list is empty");
    assertEquals(l.size(), 0, "cleared list has size 0");
    {    
        Iterator<Integer> &it = l.iterator();
        assertFalse(it.hasNext(), "cleared list iterator has no element");
        it.destroy();
    }
    
    l.destroy();
    c.destroy();
    b.destroy();
    a.destroy();
    success();
}
