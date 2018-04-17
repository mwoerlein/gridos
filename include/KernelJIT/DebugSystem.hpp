#ifndef DEBUGSYSTEM_HPP_LOCK
#define DEBUGSYSTEM_HPP_LOCK

#include "sys/OStream.hpp"

class DebugSystem{
    public:
	virtual ~DebugSystem(){};
	virtual OStream &getOStream()=0;
};

#endif //DEBUGSYSTEM_HPP_LOCK

