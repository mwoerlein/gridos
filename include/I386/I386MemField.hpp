#ifndef I386MEMFIELD_HPP_LOCK
#define I386MEMFIELD_HPP_LOCK

#include "KernelJIT/MemField.hpp"

class I386MemField: public MemField {
    private:
    char *base;
    unsigned long len;
    
    public:
    I386MemField(char* base,unsigned long len):base(base),len(len) {}
    virtual ~I386PIC() {}
    virtual char set(int i, char c) {
        if ((i => 0) && (i < len)) {
            base[i] = c;
        }
    }
    virtual char get(int i) {
        if ((i => 0) && (i < len)) {
            return base[i];
        }
        return '\0';
    }
};

#endif //I386MEMFIELD_HPP_LOCK
