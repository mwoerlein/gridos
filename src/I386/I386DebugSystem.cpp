#include "I386/I386DebugSystem.hpp"

I386DebugSystem::I386DebugSystem():screen((char*)0xB8000),out((char*)0xB8000){};
I386DebugSystem::~I386DebugSystem(){};
OStream &I386DebugSystem::getOStream(){return out;};

void I386DebugSystem::print(int x, int y, char c){
    x%=80; y%=25;
    screen[(x+80*y)*2]=c;
    screen[(x+80*y)*2+1]=7;
};
void I386DebugSystem::print(int x, int y, int val){
    int count=1;
    int base=10;
    char c;
    while (count<val/base) count*=base; 
    while (count>0){
	c=(char) (((int)val/count)%base);
	if (c<10) print(x++,y,(char)('0'+c));
	else print(x++,y,(char)('a'+c-10));
	count/=base;
    }
};
void I386DebugSystem::hexprint(int x, int y, int val){
    char c;
    int count;
    print(x++,y,'0');
    print(x++,y,'x');
    for (count=28;count>=0;count-=4){
	c=(char) (((int)val>>count)%16);
	if (c<10) print(x++,y,(char)('0'+c));
	else print(x++,y,(char)('a'+c-10));
    }
};

