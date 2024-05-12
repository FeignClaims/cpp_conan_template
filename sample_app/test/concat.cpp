#include "sample_app/concat.hpp"

#include <catch2/catch_all.hpp>

TEST_CASE("Concat with an empty string results the original", "[sample_app::concat]") {
  REQUIRE(sample_app::concat("", "").empty());
  REQUIRE(sample_app::concat("he", "") == "he");
  REQUIRE(sample_app::concat("", "llo") == "llo");
}

TEST_CASE("Concat of strings combines them", "[sample_app::concat]") {
  REQUIRE(sample_app::concat("he", "llo") == "hello");
}