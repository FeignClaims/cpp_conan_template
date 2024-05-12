add_library(sample_lib)
target_sources(sample_lib
  PRIVATE
  src/sort.cpp
)
target_include_interface_directories(sample_lib include) # Includes
target_link_libraries(sample_lib
  PRIVATE
  sample_project_name_project_options
  sample_project_name_project_warnings
)

target_find_dependencies(sample_lib # Find dependencies
  PRIVATE_CONFIG
  range-v3
)
target_link_system_libraries(sample_lib # Link dependencies
  PRIVATE
  range-v3::range-v3
)

# Tests
if(sample_project_name_BUILD_TESTING)
  add_subdirectory(test)
endif()