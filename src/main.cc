#include <iostream>

#include "MyClass/MyClass.h"
#include "MyPrivateClass/MyPrivateClass.h"

int main(){

    std::cout << "Hello, World!" << std::endl;

    MyClass newClass;

    newClass.printA();

    MyPrivateClass privateClass;

    privateClass.printB();

    return 0;
}