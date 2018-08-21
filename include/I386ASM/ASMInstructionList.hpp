#ifndef I386ASMINSTRUCTIONLIST_HPP_LOCK
#define I386ASMINSTRUCTIONLIST_HPP_LOCK

#include "sys/Object.hpp"

class ASMInstructionList: public Object {
    public:
    ASMInstructionList(Environment &env):Object(env) {}
    virtual ~ASMInstructionList() {}
};

#endif //I386ASMINSTRUCTIONLIST_HPP_LOCK
