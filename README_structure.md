# Files Structures

```bash
.
├── .github
├── .vscode
├── cmake  # cmake modules and project options for this project
├── conan  # conan config files to be installed by `conan config`
├── script
│   ├── match_conan_profile.py  # match the most suitable conan profile for the input config
│   └── rename.py  # renames the project/target name to a new name
│ # vvv examples vvv
├── sample_app
├── sample_header_only_lib
├── sample_lib
│ # ^^^ examples ^^^
├── .clang-format
├── .clang-tidy
├── .clangd
├── .gitattributes
├── .gitignore
├── conanfile.py
├── CMakeLists.txt
├── LICENSE
└── README.md
```

## Conan config files

You can find a usage example in [ci workflow](.github/workflows/ci.yml).

See conan docs listed in [References](./README_references.md) for more details.

## Source files

All actual code are listed as the examples above.

Different folders indicate they are different sub-projects. In the code level, this means they are in different top-level namespaces. For instance, all header include guards in `sample_app` should be `#ifndef SAMPLE_APP_<file_relative_path>` and the code
are all in `namespace sample_app`, and all header include guards in `sample_lib` should be `#ifndef SAMPLE_LIB_<file_relative_path>` and
the code are all in `namespace sample_lib`.

If an even more granular sub-project is required, It is recommended to put it inside the parent project. That is,

```bash
sample_app
├── include
├── my_sublib
├── src
├── test
└── CMakeLists.txt
```

Or,

```bash
sample_app
├── sample_app
├── my_sublib
└── CMakeLists.txt
```
