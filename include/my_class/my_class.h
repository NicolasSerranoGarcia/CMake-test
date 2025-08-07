#ifndef MYCLASS_H
#define MYCLASS_H

class MyClass{
    public:
        MyClass(int newA) {a = newA;};

        int getA() {return a;};

        void setA(int newA) {a = newA;};

        void printA();
    private:
        int a;
};

#endif