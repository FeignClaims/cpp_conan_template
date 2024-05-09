add_test_config(my_lib
  SYSTEM_LIBRARIES
  my_header_only_lib
)

add_library_test(my_lib sort CONFIGS common my_lib SOURCES sort.cpp)