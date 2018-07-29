#ifndef I386BOOTSTRAP_HPP_LOCK
#define I386BOOTSTRAP_HPP_LOCK

#include "sys/Environment.hpp"

class I386Bootstrap {
    private:
	void trickCompiler();
    public:
    I386Bootstrap(){};
	virtual ~I386Bootstrap(){};
	Environment & buildEnvironment(unsigned long magic, void *mbi, void *mbh);
};

#endif //I386BOOTSTRAP_HPP_LOCK

