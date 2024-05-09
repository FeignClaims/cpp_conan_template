# cmake_starter_template

[![ci](https://github.com/FeignClaims/cmake_starter_template/actions/workflows/ci.yml/badge.svg)](https://github.com/FeignClaims/cmake_starter_template/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/FeignClaims/cmake_starter_template/graph/badge.svg?token=BQEOMHO4P6)](https://codecov.io/gh/FeignClaims/cmake_starter_template)

> Write your own conan profile and conanfile, then cmake using the generated toochians.

:warning: support for docker images and fuzz testing dose NOT complete yet!

## About cmake_starter_template

This is a cmake template using conan 2.0 for setting up and running with C++ quickly.

This repository highly depends on [aminya/project_options](https://github.com/aminya/project_options), which improves the CMake experience a lot.

It includes:

- a basic example on how to manage dependencies using conan and use it simply
- an example github action testing working on Linux/MacOS/Windows
- examples for testing using [boost-ext/ut](https://github.com/boost-ext/ut)

It requires:

- cmake 3.25+
- conan 2.0.15+
- a C++ compiler that supports C++20.
- (optional) ccache
- (optional) clang-tidy
- (optional) clang-format
- (optional) cppcheck

## Getting Started

### Use the Github template

First, click the green `Use this template` button near the top of this page.
This will take you to Github's ['Generate Repository'](https://github.com/FeignClaims/cmake_starter_template/generate) page.
Fill in a repository name and short description, and click 'Create repository from template'.
This will allow you to create a new repository in your Github account,
prepopulated with the contents of this project.

After creating the project please wait until the cleanup workflow has finished
setting up your project and commited the changes.

Now you can clone the project locally and get to work!

```bash
git clone https://github.com/<user>/<your_new_repo>.git
```

### Docs

- [Dependencies Setup](./README_dependencies.md)
- [Usage](./README_usage.md)
- [File Structure](./README_structure.md)
- [Useful References](./README_references.md)

## More Details

The repository is templated from [cpp-best-practices/gui_starter_template](https://github.com/cpp-best-practices/gui_starter_template), but changed a lot.

This repository highly depends on [aminya/project_options](https://github.com/aminya/project_options), which improves the CMake experience a lot.

For conan 2.0, [here](https://docs.conan.io/2.0/index.html) is the official documentation.
