# - Customization point for this project
# This module contains all options to configure this project
include_guard()

get_directory_property(is_subproject PARENT_DIRECTORY)

if(NOT is_subproject)
  set(is_standalone YES)
else()
  set(is_standalone NO)
endif()

include(CMakeDependentOption)

cmake_dependent_option(sample_project_BUILD_TESTING "Building the test tree." ON "${is_standalone}" OFF)
option(sample_project_BUILD_FUZZ_TESTING "Building the fuzz test tree." OFF)