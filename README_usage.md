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

First, rename all `sample_project` in file contents and file names to a project name you like. You can do this via the script `rename.py` in `script.py` folder:

```bash
python3 script/rename.py sample_project <new_project_name>
```

You can also do this to the sample C++ executable, header-only library and library:

```bash
python3 script/rename.py sample_app <new_app_name>
python3 script/rename.py sample_header_only_lib <new_header_only_lib_name>
python3 script/rename.py sample_lib <new_lib_name>
```

:warning: For simplicity, the script has hardcoded to replace all files inside the parent directory of where the script located (`dirname(dirname(abspath(__file__))`). DON'T move the script to somewhere else.

## Configure option 1: only use cmake (recommended)

Edit `CMakeLists.txt`, add a line `run_conan()` between `include(sample_project_fetch_project_options)` and `project(cpp_novice LANGUAGES CXX)`. That is:

```cmake
cmake_minimum_required(VERSION 3.25)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(fix_msvc)
include(sample_project_options)
include(sample_project_fetch_project_options)

run_conan()
project(sample_project VERSION 0.0.1 LANGUAGES CXX)
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

In addition, in the `conan/profiles` folder, I've provided some generic profiles for you (and for [CI](.github/actions/setup_conan/action.yml)). You can use `script/match_conan_profile.py` to find the best matching generic profile based on your query:

(See more details in [conan/profiles/README.md](conan/profiles/README.md).)

```bash
# "Usage: python3 script/match_conan_profile.py <conan_profile> (specified as <os>-<os_version>-<architecture>-<compiler>-<compiler_version>-<build_type>)"
python3 script/match_conan_profile.py "macos-#-armv8-clang-#-Debug"  # `#` represents a wildcard character
```

#### Write your own profile

However, it is highly recommended to write a conan profile manually instead of depending on the detected one. In the profile, you can set information like the operating system, compiler or build configuration.

For example, the following is my clang and gcc profile on MacOS m1: (see more in [conan/profiles](conan/profiles))

<details>
<summary><code>_common</code> for common profile settings</summary>

```txt
[settings]
arch={{ detect_api.detect_arch() }}
os={{ detect_api.detect_os() }}
build_type=Release
benchmark/*:build_type=Release
boost/*:compiler.cppstd=20

[platform_tool_requires]
cmake/3.29.3
ninja/1.12.1

[conf]
# &: influence only the current package but not any depedencies
# see more in https://docs.conan.io/2/reference/config_files/profiles.html#profile-patterns
&:tools.cmake.cmaketoolchain:generator=Ninja Multi-Config
```

</details>

<details>
<summary><code>clang</code> profile</summary>

```txt
include(_common)

{% set compiler, version, compiler_exe = detect_api.detect_clang_compiler("clang") %}

[settings]
compiler={{ compiler }}
compiler.cppstd=26
compiler.libcxx={{ detect_api.detect_libcxx(compiler, version, compiler_exe) }}
compiler.version={{ detect_api.default_compiler_version(compiler, version) }}

[conf]
tools.build:compiler_executables = {"c": "{{ compiler_exe }}", "cpp": "{{ compiler_exe | replace("clang", "clang++") }}"}
tools.build:cflags=['-L/opt/homebrew/opt/llvm/lib/c++', '-Wno-unused-command-line-argument']
tools.build:cxxflags=['-L/opt/homebrew/opt/llvm/lib/c++', '-Wno-unused-command-line-argument']
```

</details>

<details>
<summary><code>gcc</code> profile</summary>

```txt
include(_common)

{% set compiler, version, compiler_exe = detect_api.detect_gcc_compiler("gcc-14") %}

[settings]
compiler={{ compiler }}
compiler.cppstd=23
compiler.libcxx={{ detect_api.detect_libcxx(compiler, version, compiler_exe) }}
compiler.version={{ detect_api.default_compiler_version(compiler, version) }}

scnlib/*:compiler.cppstd=20

[conf]
tools.build:compiler_executables = {"c": "{{ compiler_exe }}", "cpp": "{{ compiler_exe | replace("gcc", "g++") }}"}
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
