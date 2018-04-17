#include "KernelJIT/KernelJIT.hpp"
#include "KernelJIT/HaltKernel.hpp"

#include "I386/MemoryType.hpp"
#include "I386/I386InterruptVectorTable.hpp"

KernelJIT::KernelJIT(MemoryList &ml,DebugSystem &ds):ml(ml),ds(ds){}
Kernel &KernelJIT::kernel_compile(){
    int x=0;
    char c=255;
    int ackblock=0;
    
    IStream &in=ml.getKernelText();
    OStream &out=ds.getOStream();
    OStream &kout=ml.getOStreamKernel();
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

    out<<'d'<<'e'<<'b'<<'u'<<'g'<<':'<<'\n';
//    Speichergröße ermitteln
    out<<'m'<<'e'<<'m'<<':'<<' '<<ml.getMemSize()<<'\n';

    out<<'c'<<'o'<<'p'<<'y'<<'i'<<'n'<<'g'<<' ';
    while (!in.empty()){
    	in>>c;
    	//	out<<c;
    	kout<<c;
    	x++;
    }
    out<<x<<' '<<'b'<<'y'<<'t'<<'e'<<'\n';
    out<<'r'<<'e'<<'a'<<'d'<<'y'<<'!'<<'\n';
    ml.printBuffers(ds);
    out<<'S'<<'t'<<'a'<<'c'<<'k'<<':'<<' '<<(void*)(int32_t) ml.getStackSpace()<<'\n';

    return ml.getOStreamKernel();

}

