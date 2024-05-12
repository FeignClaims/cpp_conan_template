add_library(sample_header_only_lib INTERFACE)
target_include_interface_directories(sample_header_only_lib include) # Includes
target_link_libraries(sample_header_only_lib
  INTERFACE
  sample_project_project_options
  sample_project_project_warnings
)

target_find_dependencies(sample_header_only_lib # Find dependencies
  INTERFACE_CONFIG
  fmt
  range-v3
  Microsoft.GSL
)
target_link_system_libraries(sample_header_only_lib # Link dependencies
  INTERFACE
  fmt::fmt
  range-v3::range-v3
  Microsoft.GSL::GSL
)

# Tests
if(sample_project_BUILD_TESTING)
  add_subdirectory(test)
endif()