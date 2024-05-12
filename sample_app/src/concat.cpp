#include "sample_app/concat.hpp"

#include <string>

namespace sample_app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string {
  return lhs + rhs;
}
}  // namespace sample_app