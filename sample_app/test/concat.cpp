#include "sample_app/concat.hpp"

#include <catch2/catch_all.hpp>

TEST_CASE("[sample_app::concat] pass") {
  REQUIRE(sample_app::concat("h", "ello") == "hello");
}