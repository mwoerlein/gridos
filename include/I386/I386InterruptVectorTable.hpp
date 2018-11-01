#ifndef I386_I386INTERRUPTVECTORTABLE_HPP_LOCK
#define I386_I386INTERRUPTVECTORTABLE_HPP_LOCK

#include "I386/I386IntTypes.hpp"
#include "sys/InterruptVectorTable.hpp"
#define TABLESIZE 256

class I386InterruptVectorTable;
extern "C" {
    void I386_interrupt_trampoline(I386InterruptVectorTable *table, int32_t nr);
}

class I386InterruptVectorTable: public InterruptVectorTable {
    private:
    class IgnoreHandler;
    friend void I386_interrupt_trampoline(I386InterruptVectorTable *table, int32_t nr);
    
    // TODO: create and use ArrayList<InterruptHandler>/Vector<InterruptHandler> and allow creation time size of vector table
    InterruptHandler* ITable[TABLESIZE];
    
    InterruptHandler &ignore;
    MemoryInfo *idtInfo;
    virtual MemoryInfo * compileIdt();

    public:
    enum { timer = 32, keyboard = 33 };
    
    I386InterruptVectorTable(Environment &env, MemoryInfo &mi = *notAnInfo);
    virtual ~I386InterruptVectorTable();
    
    virtual int getSize() override;
    virtual void insert(int nr, InterruptHandler &hdl) override;
    virtual void activate() override;
    virtual void deactivate() override;
};

#endif //I386_I386INTERRUPTVECTORTABLE_HPP_LOCK
