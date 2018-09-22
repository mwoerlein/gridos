#include "test/sys/collection/HashMapTest.hpp"

#include "sys/Char.hpp"
#include "sys/String.hpp"
#include "sys/Integer.hpp"

// public
HashMapTest::HashMapTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
HashMapTest::~HashMapTest() {};

bool HashMapTest::runAll() {
    bool success = true;
    success &= testSetGetHasContainsUnset();
    success &= testIteratorsAndClear();
    return success;
}

// test cases
bool HashMapTest::testSetGetHasContainsUnset() {
    Char &k1 = env().create<Char, char>('a');
    Char &k2 = env().create<Char, char>('b');
    Char &k3 = env().create<Char, char>('c');
    Char &k3_2 = env().create<Char, char>('c');
    String &v1 = env().create<String, const char *>("Peter");
    String &v2 = env().create<String, const char *>("Paul");
    String &v3 = env().create<String, const char *>("Mary");
    String &v3_2 = env().create<String, const char *>("Mary");
    
    HashMap<Char, String> &m = env().create<HashMap<Char, String>>();
    
    assertTrue(m.isEmpty(), "new map is empty");
    assertEquals(m.size(), 0, "new map has size 0");
    assertFalse(m.has(k1), "new map does not have 'a'");
    assertFalse(m.has(k2), "new map does not have 'b'");
    assertFalse(m.has(k3), "new map does not have 'c'");
    assertEquals(&m.get(k1), 0, "new map gets nothing for 'a'");
    assertEquals(&m.get(k2), 0, "new map gets nothing for 'b'");
    assertEquals(&m.get(k3), 0, "new map gets nothing for 'c'");
    assertFalse(m.contains(v1), "new map does not contain 'Peter'");
    assertFalse(m.contains(v2), "new map does not contain 'Paul'");
    assertFalse(m.contains(v3), "new map does not contain 'Mary'");
    
    assertEquals(&m.set(k1, v1), 0, "map () sets element 'a'=>'Peter'");
    assertFalse(m.isEmpty(), "map ('a'=>'Peter') is not empty");
    assertEquals(m.size(), 1, "map ('a'=>'Peter') has size 1");
    assertTrue(m.has(k1), "map ('a'=>'Peter') has 'a'");
    assertFalse(m.has(k2), "map ('a'=>'Peter') does not have 'b'");
    assertFalse(m.has(k3), "map ('a'=>'Peter') does not have 'c'");
    assertEquals(&m.get(k1), &v1, "map ('a'=>'Peter') gets 'Peter' for 'a'");
    assertEquals(&m.get(k2), 0, "map ('a'=>'Peter') gets nothing for 'b'");
    assertEquals(&m.get(k3_2), 0, "map ('a'=>'Peter') gets nothing for 'c'");
    assertTrue(m.contains(v1), "map ('a'=>'Peter') contains 'Peter'");
    assertFalse(m.contains(v2), "map ('a'=>'Peter') does not contain 'Paul'");
    assertFalse(m.contains(v3_2), "map ('a'=>'Peter') does not contain 'Mary'");
    
    assertEquals(&m.set(k2, v2), 0, "map ('a'=>'Peter') sets element 'b'=>'Paul'");
    assertFalse(m.isEmpty(), "map ('a'=>'Peter','b'=>'Paul') is not empty");
    assertEquals(m.size(), 2, "map ('a'=>'Peter','b'=>'Paul') has size 2");
    assertTrue(m.has(k1), "map ('a'=>'Peter','b'=>'Paul') has 'a'");
    assertTrue(m.has(k2), "map ('a'=>'Peter','b'=>'Paul') has 'b'");
    assertFalse(m.has(k3), "map ('a'=>'Peter','b'=>'Paul') does not have 'c'");
    assertEquals(&m.get(k1), &v1, "map ('a'=>'Peter','b'=>'Paul') gets 'Peter' for 'a'");
    assertEquals(&m.get(k2), &v2, "map ('a'=>'Peter','b'=>'Paul') gets 'Paul' for 'b'");
    assertEquals(&m.get(k3), 0, "map ('a'=>'Peter','b'=>'Paul') gets nothing for 'c'");
    assertTrue(m.contains(v1), "map ('a'=>'Peter','b'=>'Paul') contains 'Peter'");
    assertTrue(m.contains(v2), "map ('a'=>'Peter','b'=>'Paul') contains 'Paul'");
    assertFalse(m.contains(v3), "map ('a'=>'Peter','b'=>'Paul') does not contain 'Mary'");
    
    assertEquals(&m.set(k1, v2), &v1, "map ('a'=>'Peter','b'=>'Paul') replaces element 'a'=>'Paul'");
    assertFalse(m.isEmpty(), "map ('a'=>'Paul','b'=>'Paul') is not empty");
    assertEquals(m.size(), 2, "map ('a'=>'Paul','b'=>'Paul') has size 2");
    assertTrue(m.has(k1), "map ('a'=>'Paul','b'=>'Paul') has 'a'");
    assertTrue(m.has(k2), "map ('a'=>'Paul','b'=>'Paul') has 'b'");
    assertFalse(m.has(k3), "map ('a'=>'Paul','b'=>'Paul') does not have 'c'");
    assertEquals(&m.get(k1), &v2, "map ('a'=>'Paul','b'=>'Paul') gets 'Paul' for 'a'");
    assertEquals(&m.get(k2), &v2, "map ('a'=>'Paul','b'=>'Paul') gets 'Paul' for 'b'");
    assertEquals(&m.get(k3), 0, "map ('a'=>'Paul','b'=>'Paul') gets nothing for 'c'");
    assertFalse(m.contains(v1), "map ('a'=>'Paul','b'=>'Paul') does not contain 'Peter'");
    assertTrue(m.contains(v2), "map ('a'=>'Paul','b'=>'Paul') contains 'Paul'");
    assertFalse(m.contains(v3), "map ('a'=>'Paul','b'=>'Paul') does not contain 'Mary'");
    
    assertEquals(&m.set(k3, v3), 0, "map ('a'=>'Paul','b'=>'Paul') sets element 'c'=>'Mary'");
    assertFalse(m.isEmpty(), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') is not empty");
    assertEquals(m.size(), 3, "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') has size 3");
    assertTrue(m.has(k1), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') has 'a'");
    assertTrue(m.has(k2), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') has 'b'");
    assertTrue(m.has(k3), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') has 'c'");
    assertEquals(&m.get(k1), &v2, "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') gets 'Paul' for 'a'");
    assertEquals(&m.get(k2), &v2, "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') gets 'Paul' for 'b'");
    assertEquals(&m.get(k3_2), &v3, "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') gets 'Mary' for 'c'");
    assertFalse(m.contains(v1), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') does not contain 'Peter'");
    assertTrue(m.contains(v2), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') contains 'Paul'");
    assertTrue(m.contains(v3_2), "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') contains 'Mary'");

    assertEquals(&m.unset(k2), &v2, "map ('a'=>'Paul','b'=>'Paul','c'=>'Mary') unsets element 'b'=>'Paul'");
    assertFalse(m.isEmpty(), "map ('a'=>'Paul','c'=>'Mary') is not empty");
    assertEquals(m.size(), 2, "map ('a'=>'Paul','c'=>'Mary') has size 2");
    assertTrue(m.has(k1), "map ('a'=>'Paul','c'=>'Mary') has 'a'");
    assertFalse(m.has(k2), "map ('a'=>'Paul','c'=>'Mary') does not have 'b'");
    assertTrue(m.has(k3), "map ('a'=>'Paul','c'=>'Mary') has 'c'");
    assertEquals(&m.get(k1), &v2, "map ('a'=>'Paul','c'=>'Mary') gets 'Paul' for 'a'");
    assertEquals(&m.get(k2), 0, "map ('a'=>'Paul','c'=>'Mary') gets nothing for 'b'");
    assertEquals(&m.get(k3), &v3, "map ('a'=>'Paul','c'=>'Mary') gets 'Mary' for 'c'");
    assertFalse(m.contains(v1), "map ('a'=>'Paul','c'=>'Mary') does not contain 'Peter'");
    assertTrue(m.contains(v2), "map ('a'=>'Paul','c'=>'Mary') contains 'Paul'");
    assertTrue(m.contains(v3), "map ('a'=>'Paul','c'=>'Mary') contains 'Mary'");

    assertEquals(&m.unset(k2), 0, "map ('a'=>'Paul','c'=>'Mary') does not unset element 'b' again");
    assertFalse(m.isEmpty(), "map ('a'=>'Paul','c'=>'Mary') is not empty");
    assertEquals(m.size(), 2, "map ('a'=>'Paul','c'=>'Mary') has size 2");

    assertEquals(&m.unset(k3), &v3, "map ('a'=>'Paul','c'=>'Mary') unsets element 'c'=>'Mary'");
    assertFalse(m.isEmpty(), "map ('a'=>'Paul') is not empty");
    assertEquals(m.size(), 1, "map ('a'=>'Paul') has size 1");
    assertTrue(m.has(k1), "map ('a'=>'Paul') has 'a'");
    assertFalse(m.has(k2), "map ('a'=>'Paul') does not have 'b'");
    assertFalse(m.has(k3), "map ('a'=>'Paul') does not have 'c'");
    assertEquals(&m.get(k1), &v2, "map ('a'=>'Paul') gets 'Paul' for 'a'");
    assertEquals(&m.get(k2), 0, "map ('a'=>'Paul') gets nothing for 'b'");
    assertEquals(&m.get(k3), 0, "map ('a'=>'Paul') gets nothing for 'c'");
    assertFalse(m.contains(v1), "map ('a'=>'Paul') does not contain 'Peter'");
    assertTrue(m.contains(v2), "map ('a'=>'Paul') contains 'Paul'");
    assertFalse(m.contains(v3), "map ('a'=>'Paul') does not contain 'Mary'");

    assertEquals(&m.unset(k1), &v2, "map ('a'=>'Paul') unsets element 'a'=>'Paul'");
    assertTrue(m.isEmpty(), "map () is empty");
    assertEquals(m.size(), 0, "map () has size 0");
    assertFalse(m.has(k1), "map () does not have 'a'");
    assertFalse(m.has(k2), "map () does not have 'b'");
    assertFalse(m.has(k3), "map () does not have 'c'");
    assertEquals(&m.get(k1), 0, "map () gets nothing for 'a'");
    assertEquals(&m.get(k2), 0, "map () gets nothing for 'b'");
    assertEquals(&m.get(k3), 0, "map () gets nothing for 'c'");
    assertFalse(m.contains(v1), "map () does not contain 'Peter'");
    assertFalse(m.contains(v2), "map () does not contain 'Paul'");
    assertFalse(m.contains(v3), "map () does not contain 'Mary'");

    m.destroy();
    v3_2.destroy();
    v3.destroy();
    v2.destroy();
    v1.destroy();
    k3_2.destroy();
    k3.destroy();
    k2.destroy();
    k1.destroy();
    success();
}

bool HashMapTest::testIteratorsAndClear() {
    String &k1 = env().create<String, const char *>("Peter");
    String &k2 = env().create<String, const char *>("Paul");
    String &k3 = env().create<String, const char *>("Mary");
    Integer &v1 = env().create<Integer, int>(0);
    Integer &v2 = env().create<Integer, int>(1);
    Integer &v3 = env().create<Integer, int>(6);
    
    HashMap<String, Integer> &m = env().create<HashMap<String, Integer>, int>(13);
    {    
        Iterator<String> &kit = m.keys();
        assertFalse(kit.hasNext(), "empty map keys-iterator has no element");
        kit.destroy();
        
        Iterator<Integer> &vit = m.values();
        assertFalse(vit.hasNext(), "empty map values-iterator has no element");
        vit.destroy();
    }
    
    m.set(k1, v1); m.set(k3, v3); m.set(k2, v2);
    assertFalse(m.isEmpty(), "filled map is not empty");
    assertEquals(m.size(), 3, "filled map has size");

    {    
        Iterator<String> &kit = m.keys();
        assertTrue(kit.hasNext(), "filled map keys-iterator has first element");
        assertEquals(kit.next(), k1, "filled map keys-iterator has first element 'Peter'");
        assertTrue(kit.hasNext(), "filled map keys-iterator has second element");
        assertEquals(kit.next(), k3, "filled map keys-iterator has second element 'Mary'");
        assertTrue(kit.hasNext(), "filled map keys-iterator has third element");
        assertEquals(kit.next(), k2, "filled map keys-iterator has third element 'Paul'");
        assertFalse(kit.hasNext(), "filled map keys-iterator has no forth element");
        kit.destroy();
        
        Iterator<Integer> &vit = m.values();
        assertTrue(vit.hasNext(), "filled map values-iterator has first element");
        assertEquals(vit.next(), v1, "filled map values-iterator has first element '0'");
        assertTrue(vit.hasNext(), "filled map values-iterator has second element");
        assertEquals(vit.next(), v3, "filled map values-iterator has second element '6'");
        assertTrue(vit.hasNext(), "filled map values-iterator has third element");
        assertEquals(vit.next(), v2, "filled map values-iterator has third element '1'");
        assertFalse(vit.hasNext(), "filled map values-iterator has no forth element");
        vit.destroy();
    }

    // change values do not reorder keys
    m.set(k2, v3); m.set(k3, v2);
    {    
        Iterator<String> &kit = m.keys();
        assertTrue(kit.hasNext(), "changed map keys-iterator has first element");
        assertEquals(kit.next(), k1, "changed map keys-iterator has first element 'Peter'");
        assertTrue(kit.hasNext(), "changed map keys-iterator has second element");
        assertEquals(kit.next(), k3, "changed map keys-iterator has second element 'Mary'");
        assertTrue(kit.hasNext(), "changed map keys-iterator has third element");
        assertEquals(kit.next(), k2, "changed map keys-iterator has third element 'Paul'");
        assertFalse(kit.hasNext(), "changed map keys-iterator has no forth element");
        kit.destroy();
        
        Iterator<Integer> &vit = m.values();
        assertTrue(vit.hasNext(), "changed map values-iterator has first element");
        assertEquals(vit.next(), v1, "changed map values-iterator has first element '0'");
        assertTrue(vit.hasNext(), "changed map values-iterator has second element");
        assertEquals(vit.next(), v2, "changed map values-iterator has second element '1'");
        assertTrue(vit.hasNext(), "changed map values-iterator has third element");
        assertEquals(vit.next(), v3, "changed map values-iterator has third element '6'");
        assertFalse(vit.hasNext(), "changed map values-iterator has no forth element");
        vit.destroy();
    }

    m.clear();
    assertTrue(m.isEmpty(), "cleared map is empty");
    assertEquals(m.size(), 0, "cleared map has size 0");
    {    
        Iterator<String> &kit = m.keys();
        assertFalse(kit.hasNext(), "cleared map keys-iterator has no element");
        kit.destroy();
        
        Iterator<Integer> &vit = m.values();
        assertFalse(vit.hasNext(), "cleared map values-iterator has no element");
        vit.destroy();
    }
    
    m.destroy();
    v3.destroy();
    v2.destroy();
    v1.destroy();
    k3.destroy();
    k2.destroy();
    k1.destroy();
    success();
}
