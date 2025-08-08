# 🛠️ Project Build & Workflow Guide

> **📍 Note:** All commands are intended to be executed from within the `build/` directory.

---

## 📁 Initial Setup

1. If `build/` doesn't exist, create it:

   ```bash
   mkdir build
   ```

2. Navigate to the `build/` directory:

   ```bash
   cd build
   ```

3. Run CMake to generate the build system:

   ```bash
   cmake ..
   ```

   Optionally, you can add flags to enable tools or configure the build (see below).

4. Build the project:

   ```bash
   cmake --build .
   ```

5. Run the program manually to check if the added code works.

6. Run the test suite:

   ```bash
   ctest
   ```

   - To run specific tests by name:

     ```bash
     ctest -R <regex>
     ```

     Example:
     ```bash
     ctest -R class
     ```

     > **Note:** Google Test uses the format `<test_suite>.<test_name>`, so you can target individual tests like:
     ```bash
     ctest -R MyTestSuite.MyTestCase
     ```

7. Write new tests for your feature.

8. Commit your changes to the current branch (see commit format below).

9. If you have a CI pipeline, it should run the tests across different OSes. If not, test manually.

10. If something breaks, return to step 3, fix the problem, and do **not** push until resolved.

11. Once the feature is complete and stable, consider creating a release.

---

## ⚙️ CMake Build Flags

You can pass these flags when running `cmake ..` to control what gets built or enabled.

### Build Type

You can build the program in different types, depending on if you want a debug or a release build. These flags are provided by CMake itself, and run optimizations, debug flags... that are useful for each use case

```bash
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake -DCMAKE_BUILD_TYPE=Release ..
```

Note that it doesn't make sense to use the upcoming flags for a release type.


### 🔬 Build Options

| Flag                     | DESCRIPTION                       | Default |
|--------------------------|--------------------------------------|---------|
| `-DBUILD_TESTS=ON\|OFF`   | Enables/disables building tests      | OFF    |
| `-DBUILD_BENCHMARK=ON\|OFF`| Enables/disables building benchmarks | OFF      |


### 🧼 Sanitizers

Enable runtime checks for common bugs:

```bash
cmake .. -DUSE_SANITIZER=Address
cmake .. -DUSE_SANITIZER=Thread
cmake .. -DUSE_SANITIZER=Memory
cmake .. -DUSE_SANITIZER=MemoryWithOrigins
cmake .. -DUSE_SANITIZER=Undefined
cmake .. -DUSE_SANITIZER=Leak
cmake .. -DUSE_SANITIZER="Address;Undefined"  # multiple sanitizers
```


### 🔍 Static Analyzers

Run static analysis tools during the build:

```bash
cmake .. -DUSE_STATIC_ANALYZER=clang-tidy
cmake .. -DUSE_STATIC_ANALYZER=cppcheck
cmake .. -DUSE_STATIC_ANALYZER=iwyu
cmake .. -DUSE_STATIC_ANALYZER="clang-tidy;iwyu;cppcheck"  # multiple tools
```

---

## 📦 Other CMake Tools

### 🏗️ Build and Install

```bash
cmake --build .
cmake --install .
```

Installs the project to the `install/` directory.

### 📦 CPack (Packaging)

Run to create platform-specific install packages:

```bash
cpack
```

---

## 🧪 CTest Modes

CTest provides different modes for testing:

| Command                   | Description                          |
|---------------------------|--------------------------------------|
| `ctest -D Experimental`   | For local development testing        |
| `ctest -D Nightly`        | For daily scheduled testing          |
| `ctest -D Continuous`     | For CI/CD pipelines (on push, etc.)  |

---

## 📚 Documentation with Doxygen

### 📝 Generate Documentation

```bash
doxygen Doxyfile
```

### 🧾 Example of Doxygen-style Comment:

```cpp
/**
 * @brief Adds two integers.
 * 
 * This function takes two integers as input and returns their sum.
 * 
 * @param a First integer.
 * @param b Second integer.
 * @return The result of a + b.
 */
int add(int a, int b);
```

---

## 📌 Commit Message Convention (Conventional Commits)

### ✍️ Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

- `type` can be:
  - `feat` – New feature
  - `fix` – Bug fix
  - `docs` – Documentation change
  - `style` – Code formatting (no logic change)
  - `refactor` – Code refactor (no behavior change)
  - `perf` – Performance improvements
  - `test` – Adding/modifying tests
  - `build` – Build system or dependency changes
  - `ci` – Continuous Integration changes
  - `chore` – Other changes (e.g., maintenance)

---

### 💻 Commit from Git Bash

```bash
git commit -m "feat(parser): add support for config files" \
            -m "Adds YAML and JSON config parsing modules.\n\nIncludes unit tests and default config loading." \
            -m "Closes #42"
```