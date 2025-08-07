#include <iostream>

#include "my_class.h"
#include "my_private_class/my_private_class.h"

int main(){

    std::cout << "Hello, World!" << std::endl;

    MyClass newClass;

    newClass.printA();

    MyPrivateClass privateClass;

    privateClass.printB();

    return 0;
}