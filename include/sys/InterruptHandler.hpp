#ifndef INTERRUPTHANDLER_HPP_LOCK
#define INTERRUPTHANDLER_HPP_LOCK

class InterruptHandler {
    public:
    virtual ~InterruptHandler() {}
    virtual void call(int nr) = 0;
};

#endif //INTERRUPTHANDLER_HPP_LOCK

