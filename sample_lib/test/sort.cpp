#include "sample_lib/sort.hpp"

#include <vector>

#include <catch2/catch_all.hpp>
#include <sample_header_only_lib/to_string.hpp>

TEST_CASE("[sample_lib::sort] pass") {
  std::vector<int> vector{1, 3, 0, 4};
  REQUIRE(sample_header_only_lib::to_string(vector) == "1, 3, 0, 4");
  sample_lib::sort(vector);
  REQUIRE(sample_header_only_lib::to_string(vector) == "0, 1, 3, 4");
}