#ifndef I386ASM_INSTRUCTION_ASCII_HPP_LOCK
#define I386ASM_INSTRUCTION_ASCII_HPP_LOCK

#include "I386ASM/ASMInstruction.hpp"

class Ascii: public ASMInstruction {
    private:
    String &value;
    bool terminalZero;
    
    protected:
    virtual size_t approximateSizeInBytes() override;
    virtual void checkOperands() override;
    virtual void validateOperands() override;
    virtual size_t compileOperands() override;
    virtual void writeOperandsToStream(OStream &stream) override;
    
    public:
    Ascii(Environment &env, MemoryInfo &mi, String &value, bool terminalZero)
        :ASMInstruction(env, mi, "ASCII"), Object(env, mi), value(value), terminalZero(terminalZero) {}
    virtual ~Ascii() {
        value.destroy();
    }
    
    virtual void writeToStream(OStream &stream) override;
    virtual OStream & operator >>(OStream & stream) override;
};

#endif //I386ASM_INSTRUCTION_ASCII_HPP_LOCK
