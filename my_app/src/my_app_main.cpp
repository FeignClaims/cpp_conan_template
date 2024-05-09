#include "my_app/my_app_main.hpp"

#include "my_app/concat.hpp"

#include <exception>
#include <iostream>
#include <iterator>

#include <fmt/core.h>

namespace my_app {
[[nodiscard]] auto my_app_main(/*std::vector<std::string_view> const& args*/) noexcept -> int {
  try {
    fmt::print("{}\n", my_app::concat("hello", "world"));
  } catch (std::exception& exception) {
    fmt::format_to(std::ostream_iterator<char>{std::cerr}, "Unhandled exception in main: {}\n", exception.what());
    std::terminate();
  }
  return 0;
}
}  // namespace my_app