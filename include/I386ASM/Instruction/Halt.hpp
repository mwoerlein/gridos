#ifndef I386ASMHALT_HPP_LOCK
#define I386ASMHALT_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Halt: public ASMInstruction {
    private:
    
    public:
    Halt(Environment &env, MemoryInfo &mi):ASMInstruction(env, mi), Object(env, mi) {}
    virtual ~Halt() {}
    
    virtual size_t getSizeInBytes();
    virtual void writeToStream(OStream &stream);
    virtual void logToStream(OStream &stream) {
        stream << "hlt";
    }
};

#endif //I386ASMHALT_HPP_LOCK
