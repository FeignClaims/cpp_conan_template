# Conan profiles overview

These are conan profiles used in ci.

You can use `script/match_conan_profile.py` to find the most matched conan profile (which is also the script used by `.github/actions/setup_conan`):

```bash
python3 script/match_conan_profile.py "<os>-<os_version>-<architecture>-<compiler>-<compiler_version>-<build_type>"
```

| section          | value                                      |
| ---------------- | ------------------------------------------ |
| os               | linux, macos, windows, ...                 |
| os_version       | <specific_version>, latest                 |
| architecture     | x86_64, armv8, ...                         |
| compiler         | clang, gcc, msvc, ...                      |
| compiler_version | <specific_version>, latest                 |
| build_type       | Debug, Release, RelWithDebInfo, MinSizeRel |

Among all matched files, the file has the maximum number of equal sections should be chosen; if there're multiple files having maximum number of equal sections, the section-lexicographically less one should be chosen.

For example, with conan profiles:

- `#-#-#-clang-#-#`;
- `#-#-#-gcc-#-#`;
- `#-#-#-msvc-#-#`;
- `macos-#-#-gcc-13-#`;
- `windows-#-#-clang-#-#`;
- `windows-#-#-clang-#-Debug`.
- `windows-#-#-clang-17-#`.
- `windows-#-#-clang-17-Release`.

The jobs should match as the following:

| job                                    | matched conan profile          |
| -------------------------------------- | ------------------------------ |
| `macos-12-armv8-clang-latest-Debug`    | `#-#-#-clang-#-#`              |
| `macos-12-armv8-gcc-13-Debug`          | `macos-#-#-gcc-#-#`            |
| `windows-2022-x86_64-clang-16-Debug`   | `windows-#-#-clang-#-#`        |
| `windows-2022-x86_64-clang-17-Debug`   | `windows-#-#-clang-#-Debug`    |
| `windows-2022-x86_64-clang-17-Release` | `windows-#-#-clang-17-Release` |
