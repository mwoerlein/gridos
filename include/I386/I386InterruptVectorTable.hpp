#ifndef I386INTERRUPTVECTORTABLE_HPP_LOCK
#define I386INTERRUPTVECTORTABLE_HPP_LOCK

#include "I386/I386IntTypes.hpp"
#include "sys/InterruptVectorTable.hpp"
#define TABLESIZE 256

class I386InterruptVectorTable;
extern "C" {
    void trampoline(I386InterruptVectorTable *table, int32_t nr);
}

class I386InterruptVectorTable: public InterruptVectorTable {
    private:
    friend void trampoline(I386InterruptVectorTable *table, int32_t nr);
    
    // TODO: InterruptHandler extends Object and use env().out() 
    class IgnoreHandler: public InterruptHandler {
        private:
        int pos;
        
        public:
        IgnoreHandler(int line):pos(160*line) {}
        
        void call(int nr) {
            char* s = &((char*) 0xb8000)[pos];
            *s++ = 'i';            *s++ = 7;
            *s++ = 'n';            *s++ = 7;
            *s++ = 't';            *s++ = 7;
            *s++ = '0'+nr/100;     *s++ = 7;
            *s++ = '0'+(nr%100)/10;*s++ = 7;
            *s++ = '0'+nr%10;      *s++ = 7;
            *s++ = ' ';            *s++ = 7;
        }
    } ignore;

    typedef InterruptHandler* HandlerRef;
    HandlerRef ITable[TABLESIZE];
    
    MemoryInfo &idtInfo;
    void (*activateIdt)();
    virtual MemoryInfo & generateIdt();

    public:
    enum { timer = 32, keyboard = 33 };
    
    I386InterruptVectorTable(Environment &env, MemoryInfo &mi = *notAnInfo)
            :Object(env,mi), ignore(0), idtInfo(generateIdt()),
             activateIdt((void (*)())(&idtInfo != notAnInfo ? idtInfo.buf : 0)) {
        for (int i = 0; i < TABLESIZE; i++) ITable[i] = &ignore;
    }
    virtual ~I386InterruptVectorTable() {
        if (&idtInfo != notAnInfo) {
            env().getAllocator().free(idtInfo);
        }
    }
    
    void insert(int nr, InterruptHandler &hdl) {
        ITable[nr] = &hdl;
    }
    
    void deactivate() {
        //warten bis aktuell laufende Interrupts abgearbeitet sind
        //Speicherfreigeben, ...
    }
    
    void activate() {
        if (!activateIdt) {
            env().err()<<"idt generation failed => skip activate\n";
            return;
        }
        __asm__("cli");
        //if (active) active->deactivate();
        //active = this;
        activateIdt();
        __asm__("sti");
    }
    
    int getSize() {
        return TABLESIZE;
    }
};

#endif //I386INTERRUPTVECTORTABLE_HPP_LOCK
