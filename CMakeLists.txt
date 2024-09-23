cmake_minimum_required(VERSION 3.25)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(fix_msvc)
include(sample_project_options)
include(sample_project_fetch_project_options)

project(sample_project VERSION 1.0.0 LANGUAGES CXX)

# Propagate customized project_options. That is,
# - Some global project settings like default C++ version and so on.
# - `sample_project_project_options` and `sample_project_project_warnings` interface libraries that contain C++ options
include(sample_project_custom_project_options)

# workaround: RPATH stuff
# !!!NOT RECOMMENDED!!! see https://github.com/ossf/wg-best-practices-os-developers/blob/main/docs/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C%2B%2B.md
include(rpath)

if(sample_project_BUILD_TESTING OR sample_project_BUILD_FUZZ_TESTING)
  # Include CTest before any tests
  include(CTest)

  # Add handy test wrappers
  include(add_test)

  if(sample_project_BUILD_TESTING)
    # Common test config
    add_test_config(common
      DEPENDENCIES_CONFIG
      Catch2

      LIBRARIES
      sample_project_project_options
      sample_project_project_warnings

      SYSTEM_LIBRARIES
      Catch2::Catch2WithMain

      EXECUTE_ARGS
      --reporter xml
    )
  endif()

  if(sample_project_BUILD_FUZZ_TESTING)
    add_library(sample_project_project_libfuzzer INTERFACE)
    target_link_libraries(sample_project_project_libfuzzer
      INTERFACE
      -coverage
      -fsanitize=fuzzer,undefined,address
    )
    target_compile_options(sample_project_project_libfuzzer
      INTERFACE
      -fsanitize=fuzzer,undefined,address
    )

    add_subdirectory(fuzz_test)
  endif()
endif()

# Add src
add_subdirectory(sample_app)
add_subdirectory(sample_header_only_lib)
add_subdirectory(sample_lib)

# Package the project
# for products, using `package_project(TARGETS app)` to pack the executable should be enough
package_project(
  TARGETS
  sample_app
  sample_lib
  sample_header_only_lib
  sample_project_project_options
  sample_project_project_warnings
)

detect_architecture(arch)
set(CPACK_PACKAGE_FILE_NAME
  "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${arch}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)