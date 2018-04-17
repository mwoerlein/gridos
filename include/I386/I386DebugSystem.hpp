#ifndef I386DEBUGSYSTEM_HPP_LOCK
#define I386DEBUGSYSTEM_HPP_LOCK

#include "KernelJIT/DebugSystem.hpp"
#include "I386/I386CgaOStream.hpp"

class I386DebugSystem: public DebugSystem{
    private:
	char* const screen;
	I386CgaOStream out;
    public:
	I386DebugSystem();
	virtual ~I386DebugSystem();
	virtual OStream &getOStream();
	virtual void print(int x,int y,char c);
	virtual void print(int x,int y,int val);
	virtual void hexprint(int x,int y,int val);
};

#endif //I386DEBUGSYSTEM_HPP_LOCK

