#include "linux/LinuxBootstrap.hpp"
#include "test/TestSuite.hpp"

int main() {
    TestSuite ts(LinuxBootstrap::buildEnvironment());
    ts.runAll();
}
