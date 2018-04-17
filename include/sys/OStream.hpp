#ifndef OSTREAM_HPP_LOCK
#define OSTREAM_HPP_LOCK

//#include "sys/String.hpp"

class OStream {
    public:
	virtual ~OStream(){};
	virtual OStream &operator<<(char c)=0;
	virtual OStream &operator<<(int i)=0;
	virtual OStream &operator<<(void *ptr)=0;
//	virtual OStream &operator<<(String &s)=0;
	virtual	void clear()=0;
};

#endif //OSTREAM_HPP_LOCK

