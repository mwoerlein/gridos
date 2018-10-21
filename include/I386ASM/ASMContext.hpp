#ifndef I386ASM_ASMCONTEXT_HPP_LOCK
#define I386ASM_ASMCONTEXT_HPP_LOCK

#include "sys/Object.hpp"
#include "I386ASM/ASMTypes.hpp"

class ASMContext: virtual public Object {
    public:
    BitWidth mode, data, addr;
    size_t pos;
    ASMContext(Environment &env, MemoryInfo &mi, BitWidth mode, BitWidth data, BitWidth addr)
        :Object(env, mi), mode(mode), data(data), addr(addr), pos(0) {}
    virtual ~ASMContext() {}
    
    virtual bool requiresOperandSizeOverride(BitWidth operandSize) {
        return (operandSize == bit_16 && data == bit_32) || (operandSize == bit_32 && data == bit_16);
    }
    
    virtual bool requiresAddressSizeOverride(BitWidth addressSize) {
        return (addressSize == bit_16 && mode == bit_32) || (addressSize == bit_32 && mode == bit_16);
    }
};

#endif //I386ASM_ASMCONTEXT_HPP_LOCK
