#include "my_private_class.h"

#include <iostream>

#include "my_class.h" 

void MyPrivateClass::printB(){
    std::cout << b << std::endl;
}

MyClass MyPrivateClass::getNewClass(){
    return newClass;
}