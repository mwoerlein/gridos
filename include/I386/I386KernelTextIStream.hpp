#ifndef I386KERNELTEXTISTREAM_HPP_LOCK
#define I386KERNELTEXTISTREAM_HPP_LOCK

#include "memory/MemoryTypes.hpp"
#include "sys/IStream.hpp"

class I386KernelTextIStream: public IStream {
    private:
	MemoryInfo &mem;
	size_t pos;
    public:
	I386KernelTextIStream(MemoryInfo &m):mem(m),pos(0){};
	virtual ~I386KernelTextIStream(){};
	virtual IStream &operator>>(char &c){c=((char*)mem.buf)[pos++];};
	virtual IStream &operator>>(int &i){};
	virtual bool empty(){ return (pos==mem.len); };
	
//	virtual IStream &operator>>(void *ptr)=0;
};

#endif //I386KERNELTEXTISTREAM_HPP_LOCK

