#include "my_app/concat.hpp"

#include <catch2/catch_all.hpp>

TEST_CASE("[my_app::concat] pass") {
  REQUIRE(my_app::concat("h", "ello") == "hello");
}