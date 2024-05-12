#include "sample_header_only_lib/to_string.hpp"

#include <vector>

#include <catch2/catch_all.hpp>

TEST_CASE("[sample_header_only_lib::to_string] pass") {
  std::vector<int> const vec{1, 2, 3, 4};
  REQUIRE(sample_header_only_lib::to_string(vec) == "1, 2, 3, 4");
}