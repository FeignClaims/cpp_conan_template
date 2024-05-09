#include "my_lib/sort.hpp"

#include <vector>

#include <catch2/catch_all.hpp>
#include <my_header_only_lib/to_string.hpp>

TEST_CASE("[my_lib::sort] pass") {
  std::vector<int> vector{1, 3, 0, 4};
  REQUIRE(my_header_only_lib::to_string(vector) == "1, 3, 0, 4");
  my_lib::sort(vector);
  REQUIRE(my_header_only_lib::to_string(vector) == "0, 1, 3, 4");
}