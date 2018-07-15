#include "KernelJIT/KernelJIT.hpp"
#include "KernelJIT/HaltKernel.hpp"

#include "I386/I386InterruptVectorTable.hpp"

KernelJIT::KernelJIT(IStream &in, OStreamKernel &osk, DebugSystem &ds):in(in),osk(osk),ds(ds){}
Kernel &KernelJIT::kernel_compile(){
    int x=0;
    char c=255;
    int ackblock=0;
    
    OStream &out=ds.getOStream();
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

    out<<'c'<<'o'<<'p'<<'y'<<'i'<<'n'<<'g'<<' ';
    while (!in.empty()){
    	in>>c;
    	//	out<<c;
    	osk<<c;
    	x++;
    }
    out<<x<<' '<<'b'<<'y'<<'t'<<'e'<<'\n';
    out<<'r'<<'e'<<'a'<<'d'<<'y'<<'!'<<'\n';

    return osk;
}

