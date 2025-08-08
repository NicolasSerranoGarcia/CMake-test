<!--Add some explanation outside of the CMakeLists.txt and also IMPORTANT add all the commands available for the build and debugging. 
Make a walkthrough of a how a real workflow would go using the commands and what are the results-->
Guide

Grouping all useful commands:

ctest -D Experimental   # local
ctest -D Nightly        # daily
ctest -D Continuous     # CI/CD (push, merge, etc.)

"cmake ../" on build/ creates the builder (makefiles and libraries)

cmake --build .

cmake --install .

cpack -> automated: creates a different package depending on the platform

commands for 

