#include "sample_lib/concat.hpp"

#include <catch2/catch_all.hpp>

TEST_CASE("Concat with an empty string results the original", "[sample_lib::concat]") {
  REQUIRE(sample_lib::concat("", "").empty());
  REQUIRE(sample_lib::concat("he", "") == "he");
  REQUIRE(sample_lib::concat("", "llo") == "llo");
}

TEST_CASE("Concat of strings combines them", "[sample_lib::concat]") {
  REQUIRE(sample_lib::concat("he", "llo") == "hello");
}