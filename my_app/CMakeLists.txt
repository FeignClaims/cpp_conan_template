# Seperate library part and `main()` function to simplify testing.
# If not doing so, you can't test because there's already a `main()` function.

# Library part
add_library(my_app_library STATIC) # Just a logic seperation for testing, so should be static
target_sources(my_app_library
  PRIVATE
  src/my_app_main.cpp # Seperate the actual main part for even better support for testing
  src/concat.cpp
)
target_include_interface_directories(my_app_library include) # Includes
target_link_libraries(my_app_library
  PRIVATE
  replace_this_project_options
  replace_this_project_warnings
)

target_find_dependencies(my_app_library # Find dependencies
  PUBLIC_CONFIG
  fmt
  range-v3
  Microsoft.GSL
)
target_link_system_libraries(my_app_library # Link dependencies
  PUBLIC
  fmt::fmt
  range-v3::range-v3
  Microsoft.GSL::GSL
)

# Executable part
add_executable(my_app)
target_sources(my_app
  PRIVATE
  src/main.cpp # Just for main() function
)
target_link_libraries(my_app
  PRIVATE
  my_app_library
  replace_this_project_options
  replace_this_project_warnings
)

# Tests
if(replace_this_BUILD_TESTING)
  add_subdirectory(test)
endif()