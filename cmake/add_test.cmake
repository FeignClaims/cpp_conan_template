# - Handy functions to create tests
# This module provides handy add_test wrappers and configs.
#
# The below config function will generate a test config target that can be used by linking it.
#
#   add_test_config(<config_name>  # target will be named as `test_config.${config_name}`
#     [SOURCES [arg1...]]
#     [INCLUDES [arg1...]]
#     [SYSTEM_INCLUDES [arg1...]]
#     [DEPENDENCIES_CONFIG [arg1...]]
#     [DEPENDENCIES [arg1...]]
#     [LIBRARIES [arg1...]]
#     [SYSTEM_LIBRARIES [arg1...]]
#     [COMPILE_DEFINITIONS [arg1...]]
#     [COMPILE_OPTIONS [arg1...]]
#     [COMPILE_FEATURES [arg1...]]
#     [EXECUTE_ARGS [arg1...]]
#   )
#
# The below add_test wrappers will generate a test target and register it in CTest.
#
#   add_library_test(<library> <test_name>
#     [CONFIGS [arg1...]]  # accepts both `${config_name}` and `test_config.${config_name}`
#     [SOURCES [arg1...]]
#     [INCLUDES [arg1...]]
#     [SYSTEM_INCLUDES [arg1...]]
#     [DEPENDENCIES_CONFIG [arg1...]]
#     [DEPENDENCIES [arg1...]]
#     [LIBRARIES [arg1...]]
#     [SYSTEM_LIBRARIES [arg1...]]
#     [COMPILE_DEFINITIONS [arg1...]]
#     [COMPILE_OPTIONS [arg1...]]
#     [COMPILE_FEATURES [arg1...]]
#     [EXECUTE_ARGS [arg1...]]
#   )
#
#   add_executable_test(<executable> <test_name>
#     [CONFIGS [arg1...]]  # accepts both `${config_name}` and `test_config.${config_name}`
#     [EXECUTE_ARGS [arg1...]]
#   )

include_guard()

function(_configure_target target_name type)
  set(options)
  set(one_value_args)
  set(multi_value_args
    SOURCES
    INCLUDES
    SYSTEM_INCLUDES
    DEPENDENCIES_CONFIG
    DEPENDENCIES
    LIBRARIES
    SYSTEM_LIBRARIES
    COMPILE_DEFINITIONS
    COMPILE_OPTIONS
    COMPILE_FEATURES
  )
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  if(${type} STREQUAL "library_test")
    add_executable(${target_name})
    set(source_scope PRIVATE)
    set(scope PRIVATE)
  elseif(${type} STREQUAL "test_config")
    if(args_SOURCES)
      add_library(${target_name} STATIC)
      set(source_scope PRIVATE)
      set(scope PUBLIC)
    else()
      add_library(${target_name} INTERFACE)
      set(source_scope INTERFACE)
      set(scope INTERFACE)
    endif()
  endif()

  target_sources(${target_name}
    ${source_scope}
    ${args_SOURCES}
  )
  target_include_directories(${target_name}
    ${scope}
    ${args_INCLUDES}
  )
  target_link_libraries(${target_name}
    ${scope}
    ${args_LIBRARIES}
  )
  target_include_system_directories(${target_name}
    ${scope}
    ${args_SYSTEM_INCLUDES}
  )
  target_find_dependencies(${target_name}
    "${scope}_CONFIG"
    ${args_DEPENDENCIES_CONFIG}

    ${scope}
    ${args_DEPENDENCIES}
  )
  target_link_system_libraries(${target_name}
    ${scope}
    ${args_SYSTEM_LIBRARIES}
  )
  target_compile_definitions(${target_name}
    ${scope}
    ${args_COMPILE_DEFINITIONS}
  )
  target_compile_options(${target_name}
    ${scope}
    ${args_COMPILE_OPTIONS}
  )
  target_compile_features(${target_name}
    ${scope}
    ${args_COMPILE_FEATURES}
  )
endfunction()

function(_set_config_execute_args target_name execute_args)
  set_property(TARGET ${target_name} APPEND PROPERTY PROJECT_OPTIONS_EXECUTE_ARGS ${execute_args})
endfunction()

#  add_test_config(<config_name>  # target will be named as `test_config.${config_name}`
#    [SOURCES <source_file...>]
#    [INCLUDES <include_dir...>]
#    [SYSTEM_INCLUDES <system_include_dir...>]
#    [DEPENDENCIES_CONFIG <dependency...>]  # find_package(<dependency> CONFIG REQUIRED)
#    [DEPENDENCIES <depdency...>]  # find_package(<dependency> REQUIRED)
#    [LIBRARIES <lib...>]
#    [SYSTEM_LIBRARIES <system_lib...>]
#    [COMPILE_DEFINITIONS <definition...>]
#    [COMPILE_OPTIONS <option...>]
#    [COMPILE_FEATURES <feature...>]
#    [EXECUTE_ARGS <arg...>]  # Args used as command args running the test
#  )
#
# Add a library test config called test_config.${config_name}
function(add_test_config config_name)
  set(options)
  set(one_value_args)
  set(multi_value_args
    EXECUTE_ARGS

    SOURCES
    INCLUDES
    SYSTEM_INCLUDES
    DEPENDENCIES_CONFIG
    DEPENDENCIES
    LIBRARIES
    SYSTEM_LIBRARIES
    COMPILE_DEFINITIONS
    COMPILE_OPTIONS
    COMPILE_FEATURES
  )
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  set(target_name "test_config.${config_name}")
  _configure_target(${target_name} test_config
    SOURCES
    ${args_SOURCES}
    INCLUDES
    ${args_INCLUDES}
    SYSTEM_INCLUDES
    ${args_SYSTEM_INCLUDES}
    DEPENDENCIES_CONFIG
    ${args_DEPENDENCIES_CONFIG}
    DEPENDENCIES
    ${args_DEPENDENCIES}
    LIBRARIES
    ${args_LIBRARIES}
    SYSTEM_LIBRARIES
    ${args_SYSTEM_LIBRARIES}
    COMPILE_DEFINITIONS
    ${args_COMPILE_DEFINITIONS}
    COMPILE_OPTIONS
    ${args_COMPILE_OPTIONS}
    COMPILE_FEATURES
    ${args_COMPILE_FEATURES}
  )

  _set_config_execute_args(${target_name} "${args_EXECUTE_ARGS}")
endfunction()

function(_get_configs_execute_args variable_name)
  set(value)

  foreach(config IN LISTS ARGN)
    get_target_property(execute_args ${config} PROJECT_OPTIONS_EXECUTE_ARGS)
    if(execute_args)
      list(APPEND variable_name ${execute_args})
    endif()
  endforeach()

  set(${variable_name} ${value} PARENT_SCOPE)
endfunction()

function(_add_configs_prefix variable_name)
  set(value)

  foreach(config IN LISTS ARGN)
    if(${config} MATCHES "test_config\..*")
      list(APPEND value "${config}")
    else()
      list(APPEND value "test_config.${config}")
    endif()
  endforeach()

  set(${variable_name} ${value} PARENT_SCOPE)
endfunction()

function(_set_will_fail test_name)
  set_property(TEST ${test_name} PROPERTY WILL_FAIL TRUE)
endfunction()

# add_library_test(<library> <test_name>
#   [CONFIGS <config...>]  
#   [SOURCES <source...>]
#   [INCLUDES <include_dir...>]
#   [SYSTEM_INCLUDES <system_include_dir...>]
#   [DEPENDENCIES_CONFIG <dependency...>]  # find_package(<dependency> CONFIG REQUIRED)
#   [DEPENDENCIES <dependency...>]         # find_package(<dependency> REQUIRED)
#   [LIBRARIES <lib...>]
#   [SYSTEM_LIBRARIES <system_lib...>]
#   [COMPILE_DEFINITIONS <definition...>]
#   [COMPILE_OPTIONS <option...>]
#   [COMPILE_FEATURES <feature...>]
#   [EXECUTE_ARGS <arg...>]  # Args used as command args running the test
#   [WORKING_DIRECTOY <dir>]
# )
#
# Add a library test called test.${library}.${test_name}
function(add_library_test library test_name)
  set(options)
  set(one_value_args
    WORKING_DIRECTOY
  )
  set(multi_value_args
    CONFIGS
    EXECUTE_ARGS

    SOURCES
    INCLUDES
    SYSTEM_INCLUDES
    DEPENDENCIES_CONFIG
    DEPENDENCIES
    LIBRARIES
    SYSTEM_LIBRARIES
    COMPILE_DEFINITIONS
    COMPILE_OPTIONS
    COMPILE_FEATURES
  )
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  if(NOT args_WORKING_DIRECTORY)
    set(args_WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  _add_configs_prefix(prefixed_configs ${args_CONFIGS})

  set(target_name "test.${library}.${test_name}")
  _configure_target(${target_name} library_test
    SOURCES
    ${args_SOURCES}
    INCLUDES
    ${args_INCLUDES}
    SYSTEM_INCLUDES
    ${args_SYSTEM_INCLUDES}
    DEPENDENCIES_CONFIG
    ${args_DEPENDENCIES_CONFIG}
    DEPENDENCIES
    ${args_DEPENDENCIES}
    LIBRARIES
    ${args_LIBRARIES}
    SYSTEM_LIBRARIES
    ${args_SYSTEM_LIBRARIES}
    COMPILE_DEFINITIONS
    ${args_COMPILE_DEFINITIONS}
    COMPILE_OPTIONS
    ${args_COMPILE_OPTIONS}
    COMPILE_FEATURES
    ${args_COMPILE_FEATURES}
  )

  target_link_libraries(${target_name}
    PRIVATE
    ${prefixed_configs}
    ${library}
  )

  _get_configs_execute_args(configs_execute_args ${prefixed_configs})
  add_test(
    NAME ${target_name}
    COMMAND ${target_name} ${configs_execute_args} ${args_EXECUTE_ARGS}
    WORKING_DIRECTORY ${args_WORKING_DIRECTORY}
  )

  if(args_WILL_FAIL)
    _set_will_fail(${target_name})
  endif()
endfunction()

# add_executable_test(<executable> <test_name>
#   [CONFIGS <config...>]    # Only accepts the EXECUTE_ARGS part in CONFIGS
#   [EXECUTE_ARGS <arg...>]  # Args used as command args running the test
#   [WORKING_DIRECTOY <dir>]
#   [WILL_FAIL]  # The test should exists with code non-zero
# )
#
# Add an executable test called test.${executable}.${test_name}
function(add_executable_test executable test_name)
  set(options WILL_FAIL)
  set(one_value_args WORKING_DIRECTORY)
  set(multi_value_args CONFIGS EXECUTE_ARGS)
  cmake_parse_arguments(args "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

  if(NOT args_WORKING_DIRECTORY)
    set(args_WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  _add_configs_prefix(prefixed_configs ${args_CONFIGS})

  set(target_name "test.${executable}.${test_name}")

  _get_configs_execute_args(configs_execute_args ${prefixed_configs})
  add_test(
    NAME ${target_name}
    COMMAND ${executable} ${configs_execute_args} ${args_EXECUTE_ARGS}
    WORKING_DIRECTORY ${args_WORKING_DIRECTORY}
  )

  if(args_WILL_FAIL)
    _set_will_fail(${target_name})
  endif()
endfunction()