#ifndef I386BOOTSTRAP_HPP_LOCK
#define I386BOOTSTRAP_HPP_LOCK

#include "I386/I386CgaOStream.hpp"
#include "sys/Environment.hpp"

class I386Bootstrap {
    private:
    I386CgaOStream _out;
	OStream & out(){ return _out; }
	void trickCompiler();
    public:
    I386Bootstrap():_out(){};
	virtual ~I386Bootstrap(){};
	Environment & buildEnvironment(unsigned long magic, void *mbi, void *mbh);
};

#endif //I386BOOTSTRAP_HPP_LOCK

