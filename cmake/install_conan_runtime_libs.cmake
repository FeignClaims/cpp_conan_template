# - Collect runtime dependencies by install `CONAN_RUNTIME_LIB_DIRS` variable provided by CMakeToolchain
include_guard()

install(RUNTIME_DEPENDENCY_SET conan_deps
  PRE_EXCLUDE_REGEXES
  [[api-ms-win-.*]]
  [[ext-ms-.*]]
  [[kernel32\.dll]]
  [[libc\.so\..*]] [[libgcc_s\.so\..*]] [[libm\.so\..*]] [[libstdc\+\+\.so\..*]]
  POST_EXCLUDE_REGEXES
  [[.*/system32/.*\.dll]]
  [[^/lib.*]]
  [[^/usr/lib.*]]
  DIRECTORIES ${CONAN_RUNTIME_LIB_DIRS}
)