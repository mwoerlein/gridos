#ifndef INTERRUPTVECTORTABLE_HPP_LOCK
#define INTERRUPTVECTORTABLE_HPP_LOCK

#include "sys/InterruptHandler.hpp"

class InterruptVectorTable {
    public:
	virtual ~InterruptVectorTable(){};
	virtual void insert(int i,InterruptHandler &hdl)=0;
	virtual void activate()=0;
	virtual int getSize()=0;
};

#endif //INTERRUPTVECTORTABLE_HPP_LOCK

