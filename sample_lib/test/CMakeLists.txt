add_test_config(sample_lib
  SYSTEM_LIBRARIES
  sample_header_only_lib
)

add_library_test(sample_lib sort CONFIGS common sample_lib SOURCES sort.cpp)