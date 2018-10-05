#include "test/sys/collection/PropertyContainerTest.hpp"

// public
PropertyContainerTest::PropertyContainerTest(Environment &env, MemoryInfo &mi): TestCase(env, mi) {}
PropertyContainerTest::~PropertyContainerTest() {};

bool PropertyContainerTest::runAll() {
    bool success = true;
    success &= testObjectProperties();
    success &= testStringProperties();
    return success;
}

// test cases
bool PropertyContainerTest::testObjectProperties() {
    String &k1 = env().create<String, const char *>("foo.bar");

    PropertyContainer &c = env().create<PropertyContainer>();
    assertFalse(c.hasProperty(k1), "new container does not have property 'meta.mimetype'");
    assertFalse(c.hasProperty("foo.bar"), "new container does not have property 'foo.bar'");

    assertEquals(&c.setProperty("foo.bar", env()), 0, "set new property 'foo.bar'");
    assertEquals(&c.setProperty(k1, env().out()), &env(), "update property 'foo.bar'");
    
    assertTrue(c.hasProperty("foo.bar"), "filled container has property 'foo.bar'");
    assertEquals(&c.getProperty(k1), &(env().out()), "property 'foo.bar'");
    
    c.destroy();
    k1.destroy();
    success();
}

bool PropertyContainerTest::testStringProperties() {
    String &k1 = env().create<String, const char *>("meta.mimetype");
    String &k2 = env().create<String, const char *>("meta.description");
    String &k3 = env().create<String, const char *>("foo.bar");
    String &v1 = env().create<String, const char *>("text/x-pasm");
    
    PropertyContainer &c = env().create<PropertyContainer>();
    
    assertFalse(c.hasStringProperty(k2), "new container does not have property 'meta.description'");
    assertFalse(c.hasStringProperty("foo.bar"), "new container does not have property 'foo.bar'");
    
    assertEquals(&c.setStringProperty(k1, v1), 0, "set new property 'meta.mimetype'");
    assertEquals(&c.setStringProperty(k2, "descriptive text"), 0, "set new property 'meta.description'");
    assertEquals(&c.setStringProperty("foo.bar", k3), 0, "set new property 'foo.bar'");
    assertEquals(&c.setProperty("foo.bar", v1), &k3, "update property 'foo.bar'");
    assertEquals(&c.setStringProperty("foo.bar", "bar"), &v1, "update property 'foo.bar'");

    assertTrue(c.hasStringProperty(k1), "filled container has property 'meta.mimetype'");
    assertTrue(c.hasStringProperty("meta.description"), "filled container has property 'meta.description'");
    assertTrue(c.hasStringProperty(k3), "filled container has property 'foo.bar'");
    assertFalse(c.hasStringProperty("foo.foo"), "filled container does not have property 'foo.foo'");

    assertEquals(c.getStringProperty(k1), "text/x-pasm", "property 'meta.mimetype'");
    assertEquals(c.getStringProperty(k2), "descriptive text", "property 'meta.description'");
    assertEquals(c.getStringProperty("foo.bar"), "bar", "property 'foo.bar'");
    assertEquals(&c.getStringProperty("foo.foo"), 0, "property 'foo.foo'");
    
    // mixed access
    assertEquals(&c.setProperty("env", env()), 0, "set new property 'env'");
    assertTrue(c.hasProperty("env"), "filled container has property 'env'");
    assertEquals(&c.getProperty("env"), &env(), "property 'env'");
    assertFalse(c.hasStringProperty("env"), "filled container does not have string property 'env'");
    assertEquals(&c.getStringProperty("env"), 0, "property 'env' is not a string");
    assertEquals(&c.setProperty("env", v1), &env(), "update property 'env'");
    assertTrue(c.hasStringProperty("env"), "filled container now has string property 'env'");
    assertEquals(&c.getProperty("env"), &v1, "property 'env'");
    assertEquals(&c.getStringProperty("env"), &v1, "property 'env' is a string");

    c.destroy();
    v1.destroy();
    k3.destroy();
    k2.destroy();
    k1.destroy();
    success();
}
