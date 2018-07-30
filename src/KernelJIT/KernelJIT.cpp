#include "KernelJIT/KernelJIT.hpp"

#include "KernelJIT/HaltKernel.hpp"
#include "KernelJIT/OStreamKernel.hpp"
#include "I386/I386InterruptVectorTable.hpp"
#include "I386/I386OStreamKernel.hpp"

KernelJIT::KernelJIT(Environment & env):Object(env){}
Kernel &KernelJIT::kernel_compile(IStream & in){
    int x=0;
    char c=255;
    int ackblock=0;
    
    OStream &out=env().getStdO();
    if(!in.empty()) do{
    	in>>c;
	    switch (c){
	        case '>': ackblock+=2;
	        case '<': ackblock--;
		        while(c!='\n') in>>c; //rest der Zeile ueberlesen
		        break;
	        default: out<<c;
	    }
    }while(ackblock>0);

    // TODO: "malloc" kernel output space
    MemoryInfo &zeroInfo = env()._create<MemoryInfo>();
    zeroInfo.buf = (void*)0;
    zeroInfo.len = 0x10000;
    zeroInfo.flags.magic = MEMORY_INFO_MAGIC;
    zeroInfo.flags.used = 1;
    zeroInfo.owner = this;
    
    OStreamKernel &osk = env()._create<I386OStreamKernel, MemoryInfo&>(zeroInfo);
    
    out<<"copying ";
    while (!in.empty()){
    	in>>c;
    	//	out<<c;
    	osk<<c;
    	x++;
    }
    out<<x<<" bytes"<<'\n';
    out<<"ready!"<<'\n';

    return osk;
}

