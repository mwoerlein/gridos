#include "sys/String.hpp"

class String::_Element: public Char {
    public:
    _Element *next;
    
    _Element(Environment &env, MemoryInfo &mi, char c): Char(env, mi, c), Object(env, mi), next(0) {}
    virtual ~_Element() {}
};

class String::_IStream: public IStream {
    private:
    _Element *ack;
    
    public:
    _IStream(Environment &env, MemoryInfo &mi, _Element &first): Object(env, mi), ack(&first) {}
    virtual ~_IStream() {}
    
    using IStream::operator >>;
    virtual IStream &operator >>(char &c) override {
        if (ack == 0) {
            c = '\0';
        } else {
            c = (char) *ack;
            ack = ack->next;
        }
    }
    virtual bool isEmpty() override {
        return ack == 0;
    }
};

// public
String::String(Environment &env, MemoryInfo &mi): Object(env, mi), first(0), last(0), _length(0), _hash(0) {}
String::String(Environment &env, MemoryInfo &mi, String &s): Object(env, mi), first(0), last(0), _length(0), _hash(0) {
    *this << s;
}
String::String(Environment &env, MemoryInfo &mi, char *cstring): Object(env, mi), first(0), last(0), _length(0), _hash(0) {
    *this << cstring;
}
String::String(Environment &env, MemoryInfo &mi, const char *cstring): Object(env, mi), first(0), last(0), _length(0), _hash(0) {
    *this << cstring;
}
String::String(Environment &env, MemoryInfo &mi, char *start, char* end): Object(env, mi), first(0), last(0), _length(0), _hash(0) {
    for (char *cur = start; cur < end; cur++) {
        *this << *cur;
    }
}
String::~String() {
    clear();
}

String & String::operator =(char *cstring) {
    clear();
    *this << cstring;
    return *this;
}

String & String::operator =(const char *cstring) {
    clear();
    *this << cstring;
    return *this;
}

String & String::operator =(String &s) {
    clear();
    *this << s;
    return *this;
}

OStream & String::operator <<(char c) {
    _Element *newElem = &env().create<_Element, char>(c);
    if (last) {
        last = last->next = newElem;
    } else {
        first = last = newElem;
    }
    _length++;
    _hash += _hash << 5;
    _hash += c;
    return *this;
}

int String::compareTo(char *cstring) {
    _Element *e1 = first;
    char *e2 = cstring;
    while (e1 && e2) {
        int diff = (char) *e1 - *e2;
        if (diff) {
            return diff;
        }
        e1 = e1->next;
        e2++;
    }
    if (e1) {
        return (int) (char) *e1;
    }
    if (e2) {
        return -(int) *e2;
    }
    return 0;
}

int String::compareTo(const char *cstring) {
    return compareTo((char*) cstring);
}

int String::compareTo(String &s) {
    _Element *e1 = first;
    _Element *e2 = s.first;
    while (e1 && e2) {
        int diff = (char) *e1 - (char) *e2;
        if (diff) {
            return diff;
        }
        e1 = e1->next;
        e2 = e2->next;
    }
    if (e1) {
        return (int) (char) *e1;
    }
    if (e2) {
        return -(int) (char) *e2;
    }
    return 0;
}

IStream & String::toIStream() {
    return env().create<_IStream, _Element&>(*first);
};

int String::length() {
    return _length;
}

int String::hash() {
    return _hash;
}


// protected

void String::clear() {
    _Element * cur = first;
    while (cur) {
        _Element * kill = cur;
        cur = cur->next;
        kill->destroy();
    }
    last = first = 0;
    _length = _hash = 0;
}
