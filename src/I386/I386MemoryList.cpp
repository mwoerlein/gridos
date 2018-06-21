#include "I386/I386MemoryList.hpp"
#include "I386/I386IO_Port.hpp"
#include "I386/I386IntTypes.hpp"

I386MemoryList::I386MemoryList(memlist *ml):ml(ml),kt(ml->mem[2]),osk(ml->mem[3]){};
I386MemoryList::~I386MemoryList(){};
IStream &I386MemoryList::getKernelText(){ return kt; };
OStreamKernel &I386MemoryList::getOStreamKernel(){ return osk; };
int I386MemoryList::getStackSpace(){
    int esp;
    __asm__ __volatile__ ("movl %%esp, %0":"=r"(esp):);
    return esp - (int32_t)ml->mem[1].buf;
};
int I386MemoryList::getMemSize(){
    int old;
    int size=0;
    old=I386IO_Port(0x70).inb()&0xe0;
    I386IO_Port(0x70).outb(old|0x18);
    size+=I386IO_Port(0x71).inb()<<8;
    I386IO_Port(0x70).outb(old|0x17);
    size+=I386IO_Port(0x71).inb();
    I386IO_Port(0x70).outb(old|0x16);
    size+=I386IO_Port(0x71).inb()<<8;
    I386IO_Port(0x70).outb(old|0x15);
    size+=I386IO_Port(0x71).inb();
    return size;
};
void I386MemoryList::printBuffers(DebugSystem &ds) {
    int i;
    for (i=0;i<ml->len;i++){
        ds.getOStream()<<i<<'.'<<'b'<<'u'<<'f'<<':'<<' '<<(ml->mem[i].buf)<<' '<<(void*)(int32_t)(ml->mem[i].len)<<'\n';
    }
};
