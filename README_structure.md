# Files Structures

```bash
.
├── .github
├── .vscode
├── cmake    # cmake modules
├── conan    # conan config files to be installed by `conan config`
├── doc
│ # vvv examples vvv
├── my_app
├── my_header_only_lib
├── my_lib
│ # ^^^ examples ^^^
├── script
├── .clang-format
├── .clang-tidy
├── .clangd
├── .gitattributes
├── .gitignore
├── CMakeLists.txt
├── LICENSE
├── README.md
└── conanfile.py
```

## Conan config files

You can find a usage example in [ci workflow](.github/workflows/ci.yml).

See conan docs listed in [References](./README_references.md) for more details.

## Source files

All actual code are listed as the examples above.

Different folders indicate they are different sub-projects. In the code level, this means they are in different top-level namespaces. For instance, all header include guards in `my_app` should be `#ifndef MY_APP_<file_relative_path>` and the code
are all in `namespace my_app`, and all header include guards in `my_lib` should be `#ifndef MY_LIB_<file_relative_path>` and
the code are all in `namespace my_lib`.

If an even more granular sub-project is required, It is recommended to put it inside the parent project. That is,

```bash
my_app
├── include
├── my_sublib
├── src
├── test
└── CMakeLists.txt
```

Or,

```bash
my_app
├── my_app
├── my_sublib
└── CMakeLists.txt
```
