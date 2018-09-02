#ifndef I386ASMMOV_HPP_LOCK
#define I386ASMMOV_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Move: public ASMInstruction {
    private:
    
    public:
    Move(Environment &env, MemoryInfo &mi):Object(env, mi) {}
    virtual ~Move() {}
    
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "mov" << 'l' << ' ' << "%eax" << ", " << (void *) 0xb8f00;
        stream << '\n';
        
        stream << "mov" << 'w' << ' ' << "(%eax)" << ", " << (void *) 0x740;
        stream << '\n';
        
        stream << "add" << 'l' << ' ' << "%eax" << ", " << 2;
        stream << '\n';
        
        stream << "mov" << 'w' << ' ' << "(%eax)" << ", " << (void *) 0x740;
    }
};

#endif //I386ASMMOV_HPP_LOCK
