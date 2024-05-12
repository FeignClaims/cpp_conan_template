# Seperate library part and `main()` function to simplify testing.
# If not doing so, you can't test because there's already a `main()` function.

# Library part
add_library(sample_app_library STATIC) # Just a logic seperation for testing, so should be static
target_sources(sample_app_library
  PRIVATE
  src/sample_app_main.cpp # Seperate the actual main part for even better support for testing
  src/concat.cpp
)
target_include_interface_directories(sample_app_library include) # Includes
target_link_libraries(sample_app_library
  PRIVATE
  sample_project_project_options
  sample_project_project_warnings
)

target_find_dependencies(sample_app_library # Find dependencies
  PUBLIC_CONFIG
  fmt
  range-v3
  Microsoft.GSL
)
target_link_system_libraries(sample_app_library # Link dependencies
  PUBLIC
  fmt::fmt
  range-v3::range-v3
  Microsoft.GSL::GSL
)

# Executable part
add_executable(sample_app)
target_sources(sample_app
  PRIVATE
  src/main.cpp # Just for main() function
)
target_link_libraries(sample_app
  PRIVATE
  sample_app_library
  sample_project_project_options
  sample_project_project_warnings
)

# Tests
if(sample_project_BUILD_TESTING)
  add_subdirectory(test)
endif()