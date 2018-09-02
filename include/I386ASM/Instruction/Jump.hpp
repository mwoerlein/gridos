#ifndef I386ASMJUMP_HPP_LOCK
#define I386ASMJUMP_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Jump: public ASMInstruction {
    private:
    
    public:
    Jump(Environment &env, MemoryInfo &mi):Object(env, mi) {}
    virtual ~Jump() {}
    
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "jmp" << ' ' << -3;
    }
};

#endif //I386ASMJUMP_HPP_LOCK
