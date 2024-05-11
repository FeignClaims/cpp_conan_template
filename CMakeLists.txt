cmake_minimum_required(VERSION 3.25)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(replace_this_options)
include(replace_this_fetch_project_options)

project(replace_this VERSION 0.0.1 LANGUAGES CXX)

# Propagate customized project_options. That is,
# - Some global project settings like default C++ version and so on.
# - `replace_this_project_options` and `replace_this_project_warnings` interface libraries that contain C++ options
include(replace_this_custom_project_options)

# workaround: RPATH stuff
# !!!NOT RECOMMENDED!!! see https://github.com/ossf/wg-best-practices-os-developers/blob/main/docs/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C%2B%2B.md
include(rpath)

if(replace_this_BUILD_TESTING OR replace_this_BUILD_FUZZ_TESTING)
  # Include CTest before any tests
  include(CTest)

  # Add handy test wrappers
  include(add_test)

  if(replace_this_BUILD_TESTING)
    # Common test config
    add_test_config(common
      DEPENDENCIES_CONFIG
      Catch2

      LIBRARIES
      replace_this_project_options
      replace_this_project_warnings

      SYSTEM_LIBRARIES
      Catch2::Catch2WithMain

      EXECUTE_ARGS
      --reporter xml
    )
  endif()

  if(replace_this_BUILD_FUZZ_TESTING)
    add_library(replace_this_project_libfuzzer INTERFACE)
    target_link_libraries(replace_this_project_libfuzzer
      INTERFACE
      -coverage
      -fsanitize=fuzzer,undefined,address
    )
    target_compile_options(replace_this_project_libfuzzer
      INTERFACE
      -fsanitize=fuzzer,undefined,address
    )

    add_subdirectory(fuzz_test)
  endif()
endif()

# Add src
add_subdirectory(my_app)
add_subdirectory(my_header_only_lib)
add_subdirectory(my_lib)

# Package the project
# for products, using `package_project(TARGETS app)` to pack the executable should be enough
package_project(
  TARGETS
  my_app
  my_lib
  my_header_only_lib
  replace_this_project_options
  replace_this_project_warnings
)

detect_architecture(arch)
set(CPACK_PACKAGE_FILE_NAME
  "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${arch}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)