#include "test/sys/StringTest.hpp"

#include "sys/Bool.hpp"
#include "sys/Integer.hpp"

// public
StringTest::StringTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
StringTest::~StringTest() {};

bool StringTest::runAll() {
    bool success = true;
    success &= testAssignmentAndLength();
    success &= testHashAndEquals();
    success &= testComparable();
    success &= testIStream();
    success &= testOStreamAndAppend();
    return success;
}

// test cases
bool StringTest::testAssignmentAndLength() {
    char numbers[] = "0123456789";
    String &s1 = env().create<String>();
    assertEquals(s1.length(), 0, "Create empty String");

    String &s2 = env().create<String, char*>(numbers);
    assertEquals(s2.length(), 10, "Create from native cstring");

    String &s3 = env().create<String, const char*>("string");
    assertEquals(s3.length(), 6, "Create from native const string");

    String &s4 = env().create<String, char*, char*>(&numbers[1], &numbers[5]);
    assertEquals(s4.length(), 4, "Create from native char buffer");

    String &s5 = env().create<String, String&>(s2);
    assertEquals(s5.length(), 10, "Create from String");
    
    s1 = numbers;
    assertEquals(s1.length(), 10, "Assign native cstring");
    
    s1 = "cstring";
    assertEquals(s1.length(), 7, "Assign native const string");
    
    s1 = s4;
    assertEquals(s1.length(), 4, "Assign String");
    
    s5.destroy();
    s4.destroy();
    s3.destroy();
    s2.destroy();
    s1.destroy();
    success();
}

bool StringTest::testHashAndEquals() {
    String &s1 = env().create<String, const char*>("string");
    String &s2 = env().create<String, const char*>("string");
    String &s3 = env().create<String, const char*>("other string");
    
    assertEquals(s1.hash(), s1.hash(), "Constant hash");
    assertEquals(s1.hash(), s2.hash(), "Same hash for same string as different Strings");
    assertNotEquals(s1.hash(), s3.hash(), "Different hash for different strings");

    assert(s1.equals(s1), "Identity check");
    assert(s1.equals(s2), "Same string as different Strings are equal");
    assert(!s1.equals(s3), "Different strings are not equal");
    assert(!s1.equals(env()), "Different Objects are not equal");
    
    s3.destroy();
    s2.destroy();
    s1.destroy();
    success();
}

bool StringTest::testComparable() {
    String &s1 = env().create<String>();
    String &s2 = env().create<String, const char*>("ABC");
    String &s3 = env().create<String, const char*>("ABCDE");
    String &s4 = env().create<String, const char*>("ABCDE");
    String &s5 = env().create<String, const char*>("BCD");
    String &s6 = env().create<String, const char*>("b");
    String &s7 = env().create<String>();
    
    assert(s1 != s2, "'' != 'ABC'");
    assert(s1 <  s3, "'' <  'ABCDE'");
    assert(s1 <= s6, "'' <= 'a'");
    assert(s2 <  s3, "'ABC' <  'ABCDE'");
    assert(s2 <= s5, "'ABC' <= 'BCD'");
    assert(s3 <= s3, "'ABCDE' <= 'ABCDE' (identity)");
    assert(s3 <= s4, "'ABCDE' <= 'ABCDE' (different Strings)");
    assert(s3 == s3, "'ABCDE' == 'ABCDE' (identity)");
    assert(s3 == s4, "'ABCDE' == 'ABCDE' (different Strings)");
    assert(s3 >= s3, "'ABCDE' >= 'ABCDE' (identity)");
    assert(s3 >= s4, "'ABCDE' >= 'ABCDE' (different Strings)");
    assert(s6 >  s2, "'a' >  'ABC'");
    assert(s6 >= s5, "'a' >= 'BCD'");
    assert(s6 != s3, "'a' != 'ABCDE'");
    assert(s1 == s1, "'' == '' (identity)");
    assert(s1 == s7, "'' == '' (different Strings)");

    char cstring[] = "ABCDE";
    assert(s1 != cstring, "'' != 'ABCDE' (char*)" );
    assert(s3 == cstring, "'ABCDE' == 'ABCDE' (char*)" );
    assert(s2 <  cstring, "'ABC' <  'ABCDE' (char*)" );
    assert(s2 <= cstring, "'ABC' <= 'ABCDE' (char*)" );
    assert(s5 >  cstring, "'BCD' >  'ABCDE' (char*)" );
    assert(s5 >= cstring, "'BCD' >= 'ABCDE' (char*)" );
    
    assert(s1 != "ABCDE", "'' != 'ABCDE' (const char*)" );
    assert(s3 == "ABCDE", "'ABCDE' == 'ABCDE' (const char*)" );
    assert(s2 <  "ABCDE", "'ABC' <  'ABCDE' (const char*)" );
    assert(s2 <= "ABCDE", "'ABC' <= 'ABCDE' (const char*)" );
    assert(s5 >  "ABCDE", "'BCD' >  'ABCDE' (const char*)" );
    assert(s5 >= "ABCDE", "'BCD' >= 'ABCDE' (const char*)" );

    assertEquals(s2.compareTo(s3), -'D', "distance 'ABC' to 'ABCDE'");
    assertEquals(s5.compareTo("ABC"), 1, "distance 'BCD' to 'ABC'");
    assertEquals(s5.compareTo("BCD"), 0, "distance 'BCD' to 'BCD'");
    assertEquals(s6.compareTo(cstring), 'b'-'A', "distance 'b' to 'ABCDE'");

    s7.destroy();
    s6.destroy();
    s5.destroy();
    s4.destroy();
    s3.destroy();
    s2.destroy();
    s1.destroy();
    success();
}

bool StringTest::testIStream() {
    { // test empty string
        Char tmp(env());
        String &testString = env().create<String>();
        IStream &testStream = testString.toIStream();
        assert(testStream.isEmpty(), "Empty string has empty stream");
        testStream >> tmp;
        assertEquals(tmp, '\0', "Empty stream returns \\0");
        
        testStream.destroy();
        testString.destroy();
    }
    
    { // test filled string
        char tmp;
        String &testString = env().create<String, const char*>("test");
        IStream &testStream = testString.toIStream();
        
        assert(!testStream.isEmpty(), "Stream not empty after creation");
        testStream >> tmp;
        assertEquals(tmp, 't', "First char is 't'");
        
        assert(!testStream.isEmpty(), "Stream not empty after first char");
        testStream >> tmp;
        assertEquals(tmp, 'e', "Second char is 'e'");
        
        assert(!testStream.isEmpty(), "Stream not empty after second char");
        testStream >> tmp;
        assertEquals(tmp, 's', "Third char is 's'");
        
        assert(!testStream.isEmpty(), "Stream not empty after third char");
        testStream >> tmp;
        assertEquals(tmp, 't', "Forth char is 't'");
        
        assert(testStream.isEmpty(), "Stream empty after forth char");
        testStream >> tmp;
        assertEquals(tmp, '\0', "Empty stream returns \\0");
        
        testStream.destroy();
        testString.destroy();
    }
    
    success();
}

bool StringTest::testOStreamAndAppend() {
    char space[] = " ";
    void *null = (void*) 0;
    Bool &b = env().create<Bool, bool>(false);
    Char &c = env().create<Char, char>('\n');
    String &s = env().create<String, const char*>("text");
    Integer &i = env().create<Integer>();
    
    String &string = env().create<String>();
    string<<"ABC"<<space<<1<<' '<<null<<'\n';
    assertEquals(string, "ABC 1 0x00000000\n", "filled with natives");
    
    string = "";
    IStream &stream = s.toIStream();
    string<<i<<' '<<s<<c<<stream<<" "<<b;
    stream.destroy();
    assertEquals(string, "0 text\ntext false", "filled with Char, String, Integer, IStream, and Bool");
    
    string = "";
    string += space;
    string += '2';
    string += "  ";
    string += s;
    string += c;
    assertEquals(string, " 2  text\n", "append natives, Char, and String");
    
    i.destroy();
    s.destroy();
    c.destroy();
    b.destroy();
    string.destroy();
    success();
}
