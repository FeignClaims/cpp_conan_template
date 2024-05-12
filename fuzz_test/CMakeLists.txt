
add_executable(fuzz_tester)
target_sources(fuzz_tester
  PRIVATE
  fuzz_test.cpp
)
target_link_libraries(fuzz_tester
  PRIVATE
  sample_project_project_options
  sample_project_project_warnings
  sample_project_project_libfuzzer
)
target_find_dependencies(fuzz_tester
  PRIVATE_CONFIG
  fmt
)
target_link_system_libraries(fuzz_tester
  PRIVATE
  fmt::fmt
)

# Allow short runs during automated testing to see if something new breaks, default to 10 seconds
set(FUZZ_RUNTIME 10 CACHE STRING "Number of seconds to run fuzz tests during ctest run")

add_executable_test(fuzz_tester limited_time EXECUTE_ARGS -max_total_time=${FUZZ_RUNTIME})