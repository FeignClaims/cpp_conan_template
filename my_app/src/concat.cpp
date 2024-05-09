#include "my_app/concat.hpp"

#include <string>

namespace my_app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string {
  return lhs + rhs;
}
}  // namespace my_app