add_library(my_lib)
target_sources(my_lib
  PRIVATE
  src/sort.cpp
)
target_include_interface_directories(my_lib include) # Includes
target_link_libraries(my_lib
  PRIVATE
  replace_this_project_options
  replace_this_project_warnings
)

target_find_dependencies(my_lib # Find dependencies
  PRIVATE_CONFIG
  range-v3
)
target_link_system_libraries(my_lib # Link dependencies
  PRIVATE
  range-v3::range-v3
)

# Tests
if(replace_this_BUILD_TESTING)
  add_subdirectory(test)
endif()