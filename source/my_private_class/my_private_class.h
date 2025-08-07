#ifndef MYPRIVATECLASS_H
#define MYPRIVATECLASS_H

#include "my_class.h"

class MyPrivateClass{
    public:
        void printB();
        MyClass getNewClass();
    
        private:
            int b;
            MyClass newClass;
};

#endif