#ifndef I386INTERRUPTVECTORTABLE_HPP_LOCK
#define I386INTERRUPTVECTORTABLE_HPP_LOCK

#include "I386/I386IntTypes.hpp"
#include "sys/InterruptVectorTable.hpp"
#define TABLESIZE 64

#define wrap(func,nr) static void func(){\
    active->ITable[(nr)]->call(nr);\
    __asm__("leave");\
    __asm__("iret");\
}
#define initWrap(idte,func) {\
    (idte).addr_lo=((int32_t) (func)&0x0000ffff)>> 0;\
    (idte).addr_hi=((int32_t) (func)&0xffff0000)>>16;\
    (idte).attr[0]=0x0008;\
    (idte).attr[1]=0x8e00;\
}
#define makeWrapper() wrap(__WR_0,0);wrap(__WR_1,1);wrap(__WR_2,2);wrap(__WR_3,3);wrap(__WR_4,4);wrap(__WR_5,5);wrap(__WR_6,6);wrap(__WR_7,7);wrap(__WR_8,8);wrap(__WR_9,9);wrap(__WR_10,10);wrap(__WR_11,11);wrap(__WR_12,12);wrap(__WR_13,13);wrap(__WR_14,14);wrap(__WR_15,15);wrap(__WR_16,16);wrap(__WR_17,17);wrap(__WR_18,18);wrap(__WR_19,19);wrap(__WR_20,20);wrap(__WR_21,21);wrap(__WR_22,22);wrap(__WR_23,23);wrap(__WR_24,24);wrap(__WR_25,25);wrap(__WR_26,26);wrap(__WR_27,27);wrap(__WR_28,28);wrap(__WR_29,29);wrap(__WR_30,30);wrap(__WR_31,31);wrap(__WR_32,32);wrap(__WR_33,33);wrap(__WR_34,34);wrap(__WR_35,35);wrap(__WR_36,36);wrap(__WR_37,37);wrap(__WR_38,38);wrap(__WR_39,39);wrap(__WR_40,40);wrap(__WR_41,41);wrap(__WR_42,42);wrap(__WR_43,43);wrap(__WR_44,44);wrap(__WR_45,45);wrap(__WR_46,46);wrap(__WR_47,47);wrap(__WR_48,48);wrap(__WR_49,49);wrap(__WR_50,50);wrap(__WR_51,51);wrap(__WR_52,52);wrap(__WR_53,53);wrap(__WR_54,54);wrap(__WR_55,55);wrap(__WR_56,56);wrap(__WR_57,57);wrap(__WR_58,58);wrap(__WR_59,59);wrap(__WR_60,60);wrap(__WR_61,61);wrap(__WR_62,62);wrap(__WR_63,63)

#define initWrapper(table) initWrap(table[0],__WR_0);initWrap(table[1],__WR_1);initWrap(table[2],__WR_2);initWrap(table[3],__WR_3);initWrap(table[4],__WR_4);initWrap(table[5],__WR_5);initWrap(table[6],__WR_6);initWrap(table[7],__WR_7);initWrap(table[8],__WR_8);initWrap(table[9],__WR_9);initWrap(table[10],__WR_10);initWrap(table[11],__WR_11);initWrap(table[12],__WR_12);initWrap(table[13],__WR_13);initWrap(table[14],__WR_14);initWrap(table[15],__WR_15);initWrap(table[16],__WR_16);initWrap(table[17],__WR_17);initWrap(table[18],__WR_18);initWrap(table[19],__WR_19);initWrap(table[20],__WR_20);initWrap(table[21],__WR_21);initWrap(table[22],__WR_22);initWrap(table[23],__WR_23);initWrap(table[24],__WR_24);initWrap(table[25],__WR_25);initWrap(table[26],__WR_26);initWrap(table[27],__WR_27);initWrap(table[28],__WR_28);initWrap(table[29],__WR_29);initWrap(table[30],__WR_30);initWrap(table[31],__WR_31);initWrap(table[32],__WR_32);initWrap(table[33],__WR_33);initWrap(table[34],__WR_34);initWrap(table[35],__WR_35);initWrap(table[36],__WR_36);initWrap(table[37],__WR_37);initWrap(table[38],__WR_38);initWrap(table[39],__WR_39);initWrap(table[40],__WR_40);initWrap(table[41],__WR_41);initWrap(table[42],__WR_42);initWrap(table[43],__WR_43);initWrap(table[44],__WR_44);initWrap(table[45],__WR_45);initWrap(table[46],__WR_46);initWrap(table[47],__WR_47);initWrap(table[48],__WR_48);initWrap(table[49],__WR_49);initWrap(table[50],__WR_50);initWrap(table[51],__WR_51);initWrap(table[52],__WR_52);initWrap(table[53],__WR_53);initWrap(table[54],__WR_54);initWrap(table[55],__WR_55);initWrap(table[56],__WR_56);initWrap(table[57],__WR_57);initWrap(table[58],__WR_58);initWrap(table[59],__WR_59);initWrap(table[60],__WR_60);initWrap(table[61],__WR_61);initWrap(table[62],__WR_62);initWrap(table[63],__WR_63)

class I386InterruptVectorTable: public InterruptVectorTable {
    private:
	typedef InterruptHandler* HandlerRef;
	HandlerRef ITable[TABLESIZE];

	typedef struct {
	    int16_t addr_lo;
	    int16_t attr[2];
	    int16_t addr_hi;
	} idt_entry;
	idt_entry table[TABLESIZE];

	typedef struct {
	    int16_t len;
	    int16_t tab_lo;
	    int16_t tab_hi;
	} idt_desc;
	idt_desc desc;
	
	static I386InterruptVectorTable *active;
	makeWrapper();

	class IgnoreHandler: public InterruptHandler{
	    private:
		int pos;
	    public:
		IgnoreHandler(int line):pos(160*line){};
		void call(int nr){
		    char* s=&((char*) 0xb8000)[pos];
		    *s++='i';			*s++=7;
		    *s++='n';			*s++=7;
		    *s++='t';			*s++=7;
		    *s++='0'+nr/100;		*s++=7;
		    *s++='0'+(nr%100)/10;	*s++=7;
		    *s++='0'+nr%10;		*s++=7;
		    *s++=' ';			*s++=7;
		}
	} ignore;


    public:
	enum {timer=32,keyboard=33};
	I386InterruptVectorTable():ignore(23){
	    desc.len=TABLESIZE*sizeof(idt_entry)-1;
	    desc.tab_lo=(((int32_t) table)&0x0000ffff)>> 0;
	    desc.tab_hi=(((int32_t) table)&0xffff0000)>>16;

	    for (int i=0;i<TABLESIZE;i++) ITable[i]=&ignore;
	    initWrapper(table);
	};
	void insert(int nr, InterruptHandler &hdl) { ITable[nr]=&hdl; }
	void deactivate() {
	    //warten bis aktuell laufende Interrupts abgearbeitet sind
	    //Speicherfreigeben, ...
	};
	void activate(){
	    if (active) active->deactivate();
	    active=this;
	    __asm__("lidt %0": "=m"(desc));
	};
	int getSize() { return TABLESIZE; }
	idt_desc &getDesc(){return desc; }
};

#endif //I386INTERRUPTVECTORTABLE_HPP_LOCK

