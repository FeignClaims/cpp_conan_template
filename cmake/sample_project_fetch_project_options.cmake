# - Fetches project_options: https://github.com/aminya/project_options
# This module fetches project_options from the specified repository and tag.
#
# `fetch_project_options(<git_repository> <git_tag (i.e., branch name or tag name)>)`
#
# It is highly recommended to include this module before `project(...)`, which is a must when using `run_vcpkg()` or
#   `run_conan()`
include_guard()

macro(fetch_project_options git_repository git_tag)
  include(FetchContent)
  FetchContent_Declare(_sample_project_project_options
    GIT_REPOSITORY ${git_repository}
    GIT_TAG ${git_tag}
    GIT_SHALLOW true
    GIT_SUBMODULES ""
    SOURCE_SUBDIR this-directory-does-not-exist # Avoid add_subdirectory automatically
  )
  FetchContent_MakeAvailable(_sample_project_project_options)
  include(${_sample_project_project_options_SOURCE_DIR}/src/Index.cmake)
  include(${_sample_project_project_options_SOURCE_DIR}/src/DynamicProjectOptions.cmake)
endmacro()

fetch_project_options(https://github.com/aminya/project_options.git v0.40.0)