#include <gtest/gtest.h>

#include "my_class.h"

TEST(MyClassTestUi, ClassInitializesToTwo){
    MyClass newClass(2);
    EXPECT_EQ(newClass.getA(), 2) << "The value of 'a' is not the expected";
}