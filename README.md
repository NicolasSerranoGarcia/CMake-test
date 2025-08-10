This repo is just a setup for a CMake environment.

Technologies used: 
- CMake:
  - Uses flags for sanitizers, static analyzers, enable tests and benchmarks (see GUIDE.md)
- CTest to handle tests
- CPack: Creates .zip or .tar.gz depending on the OS
- Support for CDash
- CPM
- Google Tests to create the tests
- Google Benchmark
- Doxygen
- Github Actions:
  - For CI on *main* (runs tests and benchmark on PR's and commits)
  - To automatically create a release with a package for each OS when a tag is pushed to main
  -(Not implemented yet) Add release notes automatically by looking at commit history or other params
  - To run tests in debug mode with the implemented debug flags when in a branch that's not main or docs/
