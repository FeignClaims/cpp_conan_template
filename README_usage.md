# Usage

## About

The usage steps of this template can be divided into

- Rename
- Configure
  - [Option 1: only use cmake (the conan part is handled by cmake automatically)](#configure-option-1-only-use-cmake)
  - [Option 2: invoke conan, then cmake](#configure-option-2-invoke-conan-then-cmake)
- [Switch to developer mode](#switch-to-developer-mode)
- [Build](#build)
- [Test](#test)
- [Install](#install)

Note that vcpkg can also be handled like [configure option 1](#configure-option-1-only-use-cmake), see [aminya/cpp_vcpkg_project](https://github.com/aminya/cpp_vcpkg_project).

In addition, the appendix gives a hint on [almost-always-use-conan style usage](#almost-always-use-conan).

## Rename

First, rename all `replace_this` in file contents and file names to a project name you like. You can do this via the script `rename_project.py` in `script.py` folder:

```bash
python3 script/rename_project.py <project_root_path> <new_project_name>
```

## Configure option 1: only use cmake

Edit `CMakeLists.txt`, add a line `run_conan()` between `include(fetch_project_options)` and `project(cpp_novice LANGUAGES CXX)`. That is:

```cmake
cmake_minimum_required(VERSION 3.25)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(fetch_project_options)

run_conan()
project(replace_this VERSION 0.0.1 LANGUAGES CXX)
```

By adding this line of code, we enable cmake to use conan automatically, all we need to do is to configure cmake as usual. For example:

```bash
cmake -B build -S .
```

## Configure option 2: invoke conan, then cmake

### Generate conan profile

See [Conan Docs: Consuming packages](https://docs.conan.io/2/tutorial/consuming_packages.html) for more help.

#### Detect profile

You can let conan try to guess the profile, based on the current operating system and installed tools:

```bash
conan profile detect --force
```

You can set environment variables `CC` and `CXX` to help conan find the correct compilers, for example in bash:

```bash
export CC="clang"
export CXX="clang++"
conan profile detect --force
```

#### Write your own profile

However, it is highly recommended to write a conan profile manually instead of depending on the detected one. In the profile, you can set information like the operating system, compiler or build configuration.

For example, the following is my gcc profile on MacOS m1:

<details>
<summary><code>_common</code> for common profile settings</summary>

```txt
[platform_tool_requires]
autoconf/2.71
automake/1.16.5
cmake/3.27.6
ninja/1.11.1

[conf]
# &: influence current package (your project)
&:tools.cmake.cmaketoolchain:generator=Ninja Multi-Config

# qt/*: influence required qt
qt/*:tools.cmake.cmaketoolchain:generator=Ninja

# *: influence both current package and all depedencies
*: tools.build:compiler_executables={"c": "/opt/homebrew/opt/llvm/bin/clang", "cpp": "/opt/homebrew/opt/llvm/bin/clang++"}

# no specifier: same as *
tools.build:compiler_executables={"c": "/opt/homebrew/opt/llvm/bin/clang", "cpp": "/opt/homebrew/opt/llvm/bin/clang++"}

# see more in https://docs.conan.io/2/reference/config_files/profiles.html#profile-patterns
```

</details>

<details>
<summary><code>gcc</code> for common profile settings</summary>

```txt
include(_common)

[settings]
arch=armv8
build_type=Release
compiler=gcc
compiler.cppstd=23
compiler.libcxx=libstdc++11
compiler.version=13
os=Macos

[conf]
tools.build:compiler_executables = {"c": "/opt/homebrew/bin/gcc-13", "cpp": "/opt/homebrew/bin/g++-13"}
```

</details>

### Install conan dependencies

Use `conan install -h` for help.

To install conan dependencies:

```bash
conan install . -pr <profile> -b missing
```

You can add `-s build_type=[Release|Debug|MinSizeRel|RelWithDebInfo]` or other settings/configurations/options in the command line:

```bash
conan install . -pr <profile> -b missing -s build_type=Release
```

You can specify more than one profiles, to merge the profile settings:

```bash
conan install . -pr _common -pr gcc -b missing -s build_type=Release
```

After this, conan will generate `CMakeUserPresets.json` for cmake.

### Configure cmake

Use `cmake --help` for help.

List all available configure presets:

```bash
cmake --list-presets
```

Choose one to configure (preset `clang` for instance):

```bash
cmake --preset clang
```

## Switch to developer mode

By default, cmake configures the project on user mode. For developers, you can switch to developer mode by:

### Use `-DENABLE_DEVELOPER_MODE:BOOL=ON`

```bash
cmake --preset clang -DENABLE_DEVELOPER_MODE:BOOL=ON
```

### Use `ccmake` after first configuration

```bash
cmake --preset clang
ccmake --preset clang
```

### Use `cmake-gui`

Try it yourself.

## Build

Use `cmake --build` and `conan build -h` for help.

### Build `ALL`

List all available build presets:

```bash
cmake --build --list-presets
```

Choose one to build (preset `clang-debug` for instance):

```bash
cmake --build --preset clang-debug
```

### Build the choosen target

List all available targets:

```bash
cmake --build --preset clang-debug -t help
```

Then build (targets `app` and `test_app` for instance):

```bash
cmake --build --preset clang-debug -t app test_app
```

## Test

Use `ctest --help` for help.

List all available test presets:

```bash
ctest --list-presets
```

Choose one to test (preset `clang-debug` for instance):

```bash
ctest --preset clang-debug
```

If fails, run the failed test with coloured output:

```bash
ctest --preset clang-debug --rerun-failed --output-on-failure
```

## Install

### Install without knowing the build directory

> the install prefix defaults to `/usr/local` on UNIX and `C:/Program Files/${PROJECT_NAME}` on Windows

Reconfigure to specify the install prefix if hasn't:

```bash
cmake --preset clang --install-prefix <directory>
```

Install:

```bash
cmake --build --preset clang-debug -t install
```

### Install with knowing the build directory

Use `cmake --install` for help.

```bash
cmake --install <build_dir> [<options>]
```

## Almost always use conan

See [Conan Docs: Creating packages](https://docs.conan.io/2/tutorial/creating_packages.html) and [Conan Docs: Developing packages locally](https://docs.conan.io/2/tutorial/developing_packages.html) for more help.

You can make use of conan commands to simplify CI and so on.

- install dependencies: `conan install <args>`
- install dependencies and build: `conan build <args> -c tools.build:skip_test=True`
- install dependencies, build and test: `conan build <args>`
- install, build, test and package project: `conan create <args>`
- pacakge built project: `conan export-pkg <args>`
  - :warning: Not working, you need to write `pacakge()` and `pacakge_id()` methods in conanfile.py
