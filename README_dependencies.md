# Depedencies

The template depdendes on:

- cmake 3.25+
- conan 2.0+
- a compiler
- (optional) ccache
- (optional) clang-tidy
- (optional) clang-format
- (optional) cppcheck

For Chinese, you can learn how to install all these with VSCode on Windows/MacOS [here](https://windowsmacos-vscode-c-llvm-clang-clangd-lldb.readthedocs.io/).

## Setup quickly

### Docker

:warning: Unfinished!

### setup-cpp

You can install all these dependencies using [setup-cpp](https://github.com/aminya/setup-cpp), for example, on Windows, you can run the following to install llvm, cmake, ninja, ccache, and cppcheck.

```bash
# windows example (open shell as admin)
curl -LJO "https://github.com/aminya/setup-cpp/releases/download/v0.5.7/setup_cpp_windows.exe"
./setup_cpp_windows --compiler llvm --cmake true --ninja true --ccache true --cppcheck true

RefreshEnv.cmd # reload the environment
```

## Setup manually

- for Linux, you may install quickly using the system package tool.
- for Windows, you may use [choco](https://chocolatey.org/install).
- for MacOS, you may use [homebrew](https://brew.sh/).

### Required Dependencies

- cmake

  <details>
  <summary>Install command</summary>

  - Debian/Ubuntu:

    ```bash
    sudo apt install cmake
    ```

  - Windows:

    ```bash
    choco install cmake -y
    ```

  - MacOS:

    ```bash
    brew install cmake
    ```

  </details>

- conan

  <details>
  <summary>Install command</summary>

  - Debian/Ubuntu:

    ```bash
    sudo apt install python3
    pip3 install conan
    ```

  - Windows:

    ```bash
    choco install conan -y
    ```

  - MacOS:

    ```bash
    brew install conan
    ```

  </details>

- a C++ compiler that supports C++20. See [cppreference.com](https://en.cppreference.com/w/) to see which features are supported by each compiler. The following compilers should work:

  - gcc 11+

    <details>
    <summary>Install command</summary>

    - Debian/Ubuntu:

      ```bash
      sudo apt install build-essential
      ```

    - Windows:

      ```bash
      choco install mingw -y
      ```

    - MacOS:

      ```bash
      brew install gcc
      ```

    </details>

  - clang 16+

    <details>
    <summary>Install command</summary>

    - Debian/Ubuntu:

      ```bash
      bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
      ```

    - Windows:

      ```bash
      choco install llvm -y
      ```

    - MacOS:

      ```bash
      brew install llvm
      ```

    </details>

  - Visual Studio 2019+

    <details>
    <summary>Install command</summary>

    The most friendly way is to [install the software](https://visualstudio.microsoft.com/)

    </details>

### Optional Dependencies

- ccache

  <details>
  <summary>Install command</summary>

  - Debian/Ubuntu:

    ```bash
    sudo apt install ccache
    ```

  - Windows:

    ```bash
    choco install ccache -y
    ```

  - MacOS:

    ```bash
    brew install ccache
    ```

  </details>

- llvm (clang-tidy, clang-format)

  <details>
  <summary>Install command</summary>

  - Debian/Ubuntu:

    ```bash
    sudo apt install llvm
    ```

  - Windows:

    ```bash
    choco install llvm -y
    ```

  - MacOS:

    ```bash
    brew install llvm
    ```

  </details>

- cppcheck

  <details>
  <summary>Install command</summary>

  - Debian/Ubuntu:

    ```bash
    sudo apt install cppcheck
    ```

  - Windows:

    ```bash
    choco install cppcheck -y
    ```

  - MacOS:

    ```bash
    brew install cppcheck
    ```

  </details>

- include-what-you-use

  <details>
  <summary>Install command</summary>

  Follow instructions here: https://github.com/include-what-you-use/include-what-you-use#how-to-install

  </details>
