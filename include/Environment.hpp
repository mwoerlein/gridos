#ifndef ENVIRONMENT_HPP_LOCK
#define ENVIRONMENT_HPP_LOCK

class Environment{
    public:
	template <class C> C &create() {
	}
	template <class C, class P1> C &create(P1 &p1){
	}
	template <class C, class P1, class P2> C &create(P1 &p1,P2 &p2){
	}
};

#endif //ENVIRONMENT_HPP_LOCK

