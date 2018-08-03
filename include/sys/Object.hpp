#ifndef OBJECT_HPP_LOCK
#define OBJECT_HPP_LOCK

class Environment;
class Object {
    private:
    Environment &_env;
    
    public:
    Object(Environment &env):_env(env) {}
    virtual ~Object() {}
    
    Environment &env() {
        return _env;
    }
};

#endif //OBJECT_HPP_LOCK

